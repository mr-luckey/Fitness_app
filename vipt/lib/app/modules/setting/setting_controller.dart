import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/others/tab_refesh_controller.dart';
import 'package:vipt/app/data/providers/exercise_nutrition_route_provider.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/global_widgets/custom_confirmation_dialog.dart';
import 'package:vipt/app/modules/workout_plan/widgets/input_dialog.dart';
import 'package:vipt/app/routes/pages.dart';

class SettingController extends GetxController {
  @override
  Future<void> onInit() async {
    await DataService.instance.loadUserData();
    super.onInit();
  }

  Future<void> changeBasicInforamtion() async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomConfirmationDialog(
          label: 'Do you really want to change the original information?',
          content:
              'Current progress will be reset from the beginning and will not be saved',
          labelCancel: 'Cancel',
          labelOk: 'Confirm',
          onCancel: () {
            Navigator.of(context).pop();
          },
          onOk: () async {
            await Get.toNamed(Routes.setupInfoQuestion);
            Get.back();
          },
          buttonsAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );
  }

  Future<void> changeWeightGoal() async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomConfirmationDialog(
          label: 'Do you really want to change your weight goals?',
          content:
              'Current progress will be reset from the beginning and will not be saved',
          labelCancel: 'Cancel',
          labelOk: 'Confirm',
          onCancel: () {
            Navigator.of(context).pop();
          },
          onOk: () async {
            Get.back();
            await _showInputWeightDialog();
          },
          buttonsAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );
  }

  Future<void> updateWeightGoal(String goalWeightStr) async {
    UIUtils.showLoadingDialog();
    int? newWeight = int.tryParse(goalWeightStr);
    if (newWeight == null) {
      await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
            icon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(Icons.error_rounded,
                  color: AppColor.errorColor, size: 48),
            ),
            label: 'Error! An error occurred. Please try again later',
            content: 'The weight value is not in the correct format',
            showOkButton: false,
            labelCancel: 'Close',
            onCancel: () {
              Navigator.of(context).pop();
            },
            buttonsAlignment: MainAxisAlignment.center,
            buttonFactorOnMaxWidth: double.infinity,
          );
        },
      );
      return;
    }

    final _userInfo = DataService.currentUser;
    if (_userInfo != null) {
      _userInfo.goalWeight = newWeight;
      await UserProvider().update(_userInfo.id ?? '', _userInfo);

      await DataService.instance.loadUserData();
      await ExerciseNutritionRouteProvider().resetRoute();
    }

    _markRelevantTabToUpdate();
    UIUtils.hideLoadingDialog();

    Get.offAllNamed(Routes.home);
  }

  void _markRelevantTabToUpdate() {
    if (!RefeshTabController.instance.isProfileTabNeedToUpdate) {
      RefeshTabController.instance.toggleProfileTabUpdate();
    }
  }

  Future<void> _showInputWeightDialog() async {
    return await showDialog(
        context: Get.context!,
        builder: (_) {
          return InputDialog(
              title: 'Enter weight goal',
              weightEditingController: TextEditingController(
                  text: DataService.currentUser!.goalWeight.toString()),
              logWeight: updateWeightGoal);
        });
  }
}
