import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/global_widgets/app_bar_icon_button.dart';
import 'package:vipt/app/global_widgets/exercise_list_widget.dart';
import 'package:vipt/app/global_widgets/network_image_background_container.dart';
import 'package:vipt/app/global_widgets/indicator_display_widget.dart';
import 'package:vipt/app/global_widgets/intro_collection_widget.dart';
// ignore: unused_import
import 'package:vipt/app/modules/workout_collection/widgets/property_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';

class WorkoutCollectionSettingScreen extends StatelessWidget {
  WorkoutCollectionSettingScreen({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutCollectionController>();

  void onLeaveScreen() {
    _controller.updateCollectionSetting();
    _controller.resetCaloAndTime();
  }

  void init() {
    _controller.loadCollectionSetting();
    // _workoutList = _controller.loadWorkoutList(_collection.workoutIDs);
  }

  @override
  Widget build(BuildContext context) {
    init();
    return WillPopScope(
      onWillPop: () async {
        onLeaveScreen();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppBarIconButton(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
              hero: 'leadingButtonAppBar',
              iconData: Icons.arrow_back_ios_new_rounded,
              onPressed: () {
                onLeaveScreen();
                Navigator.of(context).pop();
              }),
        ),
        body: NetworkImageBackgroundContainer(
          imageURL: _controller.selectedCollection == null
              ? ''
              : _controller.selectedCollection!.asset,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: Get.size.height * 0.7),
            child: Column(
              children: [
                IntroCollectionWidget(
                    title: _controller.selectedCollection!.title.tr,
                    description:
                        _controller.selectedCollection!.description.tr),
                const SizedBox(
                  height: 8,
                ),
                Obx(() {
                  return IndicatorDisplayWidget(
                      displayTime: '${_controller.displayTime}'.tr,
                      displayCaloValue:
                          '${_controller.caloValue.value.toInt()} calories. calories');
                }),
                const SizedBox(
                  height: 24,
                ),
                Obx(() {
                  return ExerciseListWidget(
                      displayDescription: false,
                      workoutList: _controller.generatedWorkoutList,
                      displayExerciseTime:
                          '${_controller.collectionSetting.value.exerciseTime} second');
                }),
                SizedBox(
                  height: Theme.of(context).textTheme.button!.fontSize! * 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
