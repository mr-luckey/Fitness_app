import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/providers/workout_equipment_provider.dart';
import 'package:vipt/app/data/providers/workout_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/home/home_controller.dart';
import 'package:vipt/app/modules/profile/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller.tabController,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        border: Border(
          top: BorderSide(color: AppColor.textFieldUnderlineColor),
        ),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.bounceInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9, // 6 vs 9 phù hợp
    );
  }

  List<Widget> _buildScreens() {
    return [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                // WorkoutCollectionProvider().addUserCollectionFakeData();
                // WorkoutEquipmentProvider().addFakeData();
                // WorkoutProvider().addFakeData();
              },
              child: const Text('Fetch data'),
            ),
            TextButton(
              onPressed: () async {
                await _controller.signOut();
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
      Container(),
      Container(),
      Container(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Lộ trình"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.check_box_outlined),
        title: ("Kế hoạch"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.directions_run_rounded),
        title: ("Chạy bộ"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.sports_outlined),
        title: ("Thử thách"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Cá nhân"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
