import 'package:cooking/models/Reward.dart';
import 'package:cooking/widgets/scaffolds/secondary_scaffold.dart';
import 'package:flutter/material.dart';

class RewardDetail extends StatelessWidget {
  static const String routeName = '/rewardDetail';

  @override
  Widget build(BuildContext context) {
    Reward reward = ModalRoute.of(context)!.settings.arguments as Reward;
    return SecondaryScaffold(
      body: Center(
        child: Text(reward.description),
      ),
    );
  }
}
