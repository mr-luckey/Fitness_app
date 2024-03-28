import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/modules/library/library_controller.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/routes/pages.dart';

class LibraryScreen extends StatelessWidget {
  LibraryScreen({Key? key}) : super(key: key);

  final _controller = Get.find<LibraryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            'Library',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          CustomTile(
            asset: JPGAssetString.workout_1,
            onPressed: () async {
              Get.toNamed(Routes.workoutCategory);
            },
            title: 'Exercise',
            description:
                'Look up detailed information about a specific exercise',
          ),
          const Divider(
            indent: 24,
          ),
          CustomTile(
            asset: JPGAssetString.workout_2,
            onPressed: () {
              Get.toNamed(Routes.workoutCollectionCategory);
            },
            title: 'Training set',
            description: 'Browse collections of exercises to practice',
          ),
          const Divider(
            indent: 24,
          ),
          CustomTile(
            asset: JPGAssetString.meal,
            onPressed: () {
              Get.toNamed(Routes.dishCategory);
            },
            title: 'Dish',
            description: 'Look up detailed information about a specific dish',
          ),
          const Divider(
            indent: 24,
          ),
          CustomTile(
            asset: JPGAssetString.nutrition,
            onPressed: () {
              Get.toNamed(Routes.mealPlanList);
            },
            title: 'Department of nutrition',
            description: 'Look up collections that include a variety of dishes',
          ),
          const Divider(
            indent: 24,
          ),
        ],
      ),
    );
  }
}
