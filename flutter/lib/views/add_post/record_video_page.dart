import 'package:camera/camera.dart';
import 'package:cooking/extensions.dart';
import 'package:cooking/widgets/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:wakelock/wakelock.dart';

import '../../widgets/loader.dart';

class RecordVideoPage extends StatefulWidget {
  const RecordVideoPage({Key? key}) : super(key: key);

  @override
  _RecordVideoPageState createState() => _RecordVideoPageState();
}

class _RecordVideoPageState extends State<RecordVideoPage> {
  late CameraController _controller;
  List<CameraDescription>? _cameras;
  bool _ready = false;
  bool _isRecording = false;
  bool _isOnPause = false;
  int _currentCameraIndex = 0;
  int _currentFlashIndex = 0;
  late final PausableTimer _timer;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (_ready) _cameraWidgets() else Loader(),
            if (_ready && !_isRecording) _overlayBtns(),
            if (_ready) _bottomBtns(),
            Positioned(left: 8, child: BackArrow()),
            if (_isRecording) _timerWidget(),
          ],
        ),
      ),
    );
  }

//////////////////////////////// WIDGETS ////////////////////////////////

  Widget _cameraWidgets() => CameraPreview(_controller);

  Widget _overlayBtns() => Positioned(
        right: 16,
        top: 16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getBtn(
              "switch",
              Icons.cameraswitch,
            ),
            const SizedBox(height: 8),
            _getBtn(
              "flash",
              _getFlashCurrentIcon(),
            ),
          ],
        ),
      );

  Widget _getBtn(String tag, IconData icon) => IconButton(
        onPressed: () => _onBtnPressed(tag),
        icon: Icon(icon, size: 32),
      );

  Widget _bottomBtns() => Positioned(
        bottom: 16,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isRecording)
              FloatingActionButton(
                heroTag: 'pause',
                onPressed: _onPauseResumeBtnPressed,
                backgroundColor: Colors.white,
                child: Icon(
                  _isOnPause ? Icons.play_arrow : Icons.pause,
                  size: 36,
                  color: Colors.black,
                ),
              ),
            const SizedBox(width: 8),
            FloatingActionButton(
              heroTag: 'record',
              onPressed: _onRecordBtnPressed,
              backgroundColor: Colors.white,
              child: Icon(
                _isRecording ? Icons.square : Icons.circle,
                size: 32,
                color: _isRecording ? Colors.black : Colors.red[700],
              ),
            ),
          ],
        ),
      );

  Widget _timerWidget() => Positioned(
      bottom: 16,
      right: 16,
      child: Text(
        _timer.tick.getFormatedTimer(),
      ));

//////////////////////////////// LISTENERS ////////////////////////////////

  void _onBtnPressed(String tag) {
    switch (tag) {
      case "flash":
        _switchFlash();
        break;
      case "switch":
        _switchCamera();
        break;
    }
  }

  void _onRecordBtnPressed() {
    if (_isRecording) {
      Wakelock.disable();
    } else {
      Wakelock.enable();
    }
    
    _initTimer();

    setState(() {
      _isRecording = !_isRecording;
    });
  }

  void _onPauseResumeBtnPressed() {
    if (_isOnPause) {
      _timer.start();
    } else {
      _timer.pause();
    }

    setState(() {
      _isOnPause = !_isOnPause;
    });
  }

//////////////////////////////// FUNCTIONS ////////////////////////////////

  void _initCamera() async {
    if (_cameras == null) _cameras = await availableCameras();
    _controller =
        CameraController(_cameras![_currentCameraIndex], ResolutionPreset.max);
    _controller.initialize().then((value) => setState(() {
          _ready = true;
        }));
  }

  void _switchCamera() {
    if (_cameras!.length <= 1) return;
    _ready = false;
    int vCam = _currentCameraIndex == 0 ? 1 : -1;
    _currentCameraIndex += vCam;
    _initCamera();
  }

  void _switchFlash() {
    List<FlashMode> flashes = [
      FlashMode.off,
      FlashMode.auto,
      FlashMode.always,
    ];
    if (_currentFlashIndex == flashes.length - 1) {
      _currentFlashIndex = 0;
    } else {
      _currentFlashIndex++;
    }
    _controller.setFlashMode(flashes[_currentFlashIndex]);
    setState(() {});
  }

  IconData _getFlashCurrentIcon() {
    switch (_currentFlashIndex) {
      case 0:
        return Icons.flash_off;
      case 1:
        return Icons.flash_auto;
      case 2:
        return Icons.flash_on;
      default:
        return Icons.flash_off;
    }
  }

  void _initTimer() {
    _timer = PausableTimer(Duration(seconds: 1), () {
      setState(() {});
      _timer
        ..reset()
        ..start();
    });
    _timer.start();
  }
}
