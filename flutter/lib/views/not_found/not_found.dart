import 'package:cooking/widgets/scaffolds/secondary_scaffold.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SecondaryScaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Not Found'),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/'),
                child: Text("Homepage"))
          ],
        ),
      ),
    );
  }
}
