import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/daily_plan/daily_water_controller.dart';
import 'package:vipt/app/modules/daily_plan/widgets/goal_progress_indicator.dart';
import 'package:vipt/app/modules/daily_plan/widgets/input_amount_dialog.dart';
import 'package:vipt/app/modules/loading/screens/loading_screen.dart';
import 'package:vipt/app/routes/pages.dart';

class DailyWaterScreen extends StatelessWidget {
  DailyWaterScreen({Key? key}) : super(key: key);

  final _controller = Get.put(DailyWaterController());

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'Nutrition',
      'Practice',
      'Water',
      'Step',
      'Fasting',
    ];

    return Obx(
      () => _controller.isLoading.value
          ? const LoadingScreen()
          : Scaffold(
              //extendBodyBehindAppBar: true,
              backgroundColor: AppColor.waterBackgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    int? newIndex;
                    await _showTabSelection(context, items: tabs, value: 2,
                        onSelectedItemChanged: (value) {
                      newIndex = value;
                    });
                    if (newIndex != null) {
                      _controller.changeTab(newIndex ?? 0);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        tabs[2].tr,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: AppColor.accentTextColor,
                            ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColor.accentTextColor,
                      ),
                    ],
                  ),
                ),
                actions: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      var dateTime = await showDatePicker(
                          locale: const Locale("vi", "VI"),
                          context: context,
                          initialDate: _controller.date,
                          firstDate: DateTime(1970),
                          lastDate: DateTime.now());

                      if (dateTime != null) {
                        await _controller.fetchTracksByDate(dateTime);
                      }
                    },
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        Icon(
                          Icons.calendar_today_rounded,
                          color: AppColor.accentTextColor,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Today',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: AppColor.accentTextColor,
                                    fontSize: 16,
                                  ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              body: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        kToolbarHeight -
                        kBottomNavigationBarHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.waterHistory);
                          },
                          child: _buildInfo(context),
                        ),
                        _buildActionButton(context, _controller),
                        _buildActionDescription(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  _buildInfo(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Hero(
      tag: 'waterIntakeWidget',
      child: Obx(
        () => GoalProgressIndicator(
          radius: screenWidth * 0.36,
          value: _controller.waterVolume.value,
          unitString: 'ml',
        ),
      ),
    );
  }

  _buildActionButton(context, DailyWaterController controller) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: ScaleTap(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return InputAmountDialog(
                title: 'Water',
                unit: 'ml',
                value: 200,
                confirmButtonColor: AppColor.waterBackgroundColor,
                confirmButtonText: 'More',
                sliderActiveColor: AppColor.waterDarkBackgroundColor,
                sliderInactiveColor: AppColor.waterBackgroundColor.withOpacity(
                  AppColor.subTextOpacity,
                ),
              );
            },
          );
          if (result != null) {
            await controller.addTrack(result);
          }
        },
        child: SvgPicture.asset(SVGAssetString.dropWater),
      ),
    );
  }

  _buildActionDescription(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 24),
      child: Text(
        'Touch the water drop to update the amount of water drunk.',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: AppColor.accentTextColor,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _showTabSelection(context,
      {required List<String> items,
      required Function(int)? onSelectedItemChanged,
      required int value}) async {
    await showDialog(
      useRootNavigator: false,
      //isScrollControlled: true,
      //backgroundColor: Colors.transparent,
      barrierColor: Colors.black38,
      //elevation: 0.0,
      context: context,
      builder: (BuildContext context) {
        return TweenAnimationBuilder<double>(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
            tween: Tween(begin: 0, end: 7),
            builder: (_, blurValue, __) {
              return ClipRect(
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: AnimatedOpacity(
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 300),
                      opacity: blurValue / 7,
                      child: CupertinoPicker.builder(
                        onSelectedItemChanged: onSelectedItemChanged,
                        backgroundColor: Colors.transparent,
                        itemExtent: 48,
                        scrollController:
                            FixedExtentScrollController(initialItem: value),
                        childCount: items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              items[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: AppColor.accentTextColor,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
