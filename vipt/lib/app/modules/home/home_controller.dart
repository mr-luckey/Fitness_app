import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/modules/splash/screens/splash_screen.dart';
import 'package:vipt/app/modules/splash/splash_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class HomeController extends GetxController {
  Rx<int> tabIndex = 0.obs;

  final List<Widget> _tabList = [];

  Widget getCurrentTab() {
    return _tabList.elementAt(tabIndex.value);
  }

  void onChangeTab(int index) {
    tabIndex.value = index;
  }

  Future<ViPTUser> fetchUserData() async {
    return await UserProvider().fetch('xxhRe9z3WrVaUqwiTwEloL1N4oU2');
  }

  Future<void> signOut() async {
    await AuthService.instance.signOut();
    Get.offAllNamed(Routes.auth);
  }
}
