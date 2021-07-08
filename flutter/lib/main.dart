import 'package:cooking/providers/posts.dart';
import 'package:cooking/providers/rewards.dart';
import 'package:cooking/providers/users.dart';
import 'package:cooking/views/profile/profile.dart';
import 'package:cooking/views/reward_detail/reward_detail.dart';
import 'package:cooking/views/home/home_view.dart';
import 'package:cooking/views/not_found/not_found.dart';
import 'package:cooking/views/search_page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Cooking());
}

class Cooking extends StatefulWidget {
  @override
  _CookingState createState() => _CookingState();
}

class _CookingState extends State<Cooking> {
  final RewardsProvider rewardsProvider = RewardsProvider();
  final PostsProvider postsProvider = PostsProvider();

  @override
  void initState() {
    rewardsProvider.fetchRewards();
    postsProvider.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData cookingTheme = ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(232, 196, 81, 1)),
        ),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: rewardsProvider),
        ChangeNotifierProvider.value(value: postsProvider),
        ChangeNotifierProvider.value(value: UsersProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "homepage",
        initialRoute: "/",
        routes: {
          "/": (_) => HomeView(),
          RewardDetail.routeName: (_) => RewardDetail(),
          SearchPage.routeName: (_) => const SearchPage(),
          Profile.routeName: (_) => Profile(),
        },
        onUnknownRoute: (_) => MaterialPageRoute(builder: (_) => const NotFound()),
        theme: cookingTheme,
      ),
    );
  }
}
