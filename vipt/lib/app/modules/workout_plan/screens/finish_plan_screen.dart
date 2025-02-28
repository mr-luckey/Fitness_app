import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/global_widgets/intro_collection_widget.dart';
import 'package:vipt/app/modules/profile/widgets/weight_tracking_widget.dart';
import 'package:vipt/app/modules/workout_plan/widgets/progress_info_widget.dart';
import 'package:vipt/app/modules/workout_plan/workout_plan_controller.dart';

class FinishPlanScreen extends StatelessWidget {
  FinishPlanScreen({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutPlanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.secondaryColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        label: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            'Finished',
            style: Theme.of(context).textTheme.button,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildAsset(JPGAssetString.yourWorkoutCollection),
          Container(color: AppColor.completeSessionFilterColor),
          Container(color: AppColor.completeSessionSecondaryFilterColor),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.0, -0.85),
                end: const Alignment(0.0, 1.0),
                colors: [
                  Colors.white.withOpacity(1.0),
                  Colors.white.withOpacity(0.79),
                  Colors.white.withOpacity(0.58),
                  Colors.white.withOpacity(0.0),
                ],
              ),
            ),
          ),
          ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                padding:
                    AppDecoration.screenPadding.copyWith(top: 24, bottom: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: IntroCollectionWidget(
                          title: "END",
                          description:
                              "The 15-day roadmap has ended, let's review your results."),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                            child: Text('Weight statistics',
                                style: Theme.of(context).textTheme.headline5),
                          ),
                          Obx(
                            () => WeightTrackingWidget(
                              showTitle: false,
                              weighTracks: _controller.weightTrackList,
                              handleChangeTimeRange:
                                  _controller.changeWeighDateRange,
                              timeRange: _controller.weightDateRange.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                            child: Text('Level of goal accomplishment',
                                style: Theme.of(context).textTheme.headline5),
                          ),
                          ProgressInfoWidget(
                            completeDays: _controller.planStreak,
                            currentDay:
                                _controller.currentStreakDay.value.toString(),
                            showAction: false,
                            showTitle: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Theme.of(context).textTheme.button!.fontSize! * 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildAsset(String imageURL) {
    if (imageURL.isURL) {
      return CachedNetworkImage(
          imageUrl: imageURL,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, loadingProgress) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                value: loadingProgress.progress,
              ),
            );
          },
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          });
    } else {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(JPGAssetString.userWorkoutCollection),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
