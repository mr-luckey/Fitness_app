import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/modules/profile/profile_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    _initControllerForTabs();
    super.onInit();
  }

  void _initControllerForTabs() {
    Get.lazyPut(() => ProfileController());
  }

  final PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);

  Future<ViPTUser> fetchUserData() async {
    return await UserProvider().fetch('xxhRe9z3WrVaUqwiTwEloL1N4oU2');
  }

  Future<void> signOut() async {
    await AuthService.instance.signOut();
    Get.offAllNamed(Routes.auth);
  }
}
