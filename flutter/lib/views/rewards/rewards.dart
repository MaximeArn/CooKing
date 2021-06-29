import 'package:cooking/models/Reward.type.dart';
import 'package:cooking/providers/rewards.dart';
import 'package:cooking/views/rewards/widgets/rewardCard/reward_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  late List<Reward> rewards;

  @override
  void initState() {
    rewards = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rewards = Provider.of<RewardsProvider>(context).rewards;
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int index) {
        return RewardCard(reward: rewards[index]);
      },
      itemCount: rewards.length,
    );
  }
}
