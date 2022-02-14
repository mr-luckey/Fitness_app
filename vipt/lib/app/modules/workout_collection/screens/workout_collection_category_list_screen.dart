import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutCollectionCategoryListScreen extends StatelessWidget {
  WorkoutCollectionCategoryListScreen({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutCollectionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            'Bài tập'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      // body: ListView(

      //   children: _buildWorkoutCollectionCategory(context),
      // ),

      body: ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (_, index) {
            final cate = _controller.collectionCategories[index];
            return CustomTile(
              level: 1,
              asset: SVGAssetString.gym,
              onPressed: () {
                _navigateToSuitableScreen(cate);
              },
              title: cate.name.tr,
              description:
                  '${_controller.cateListAndNumCollection[cate.id]} bài tập',
            );
          },
          separatorBuilder: (_, index) => const Divider(
                indent: 24,
              ),
          itemCount: _controller.collectionCategories.length),
    );
  }

  void _navigateToSuitableScreen(Category cate) {
    if (cate.isRootCategory() &&
        DataService.instance.checkIfCollectionCategoryHasChild(cate)) {
      _controller.loadChildCategoriesBaseOnParentCategory(cate.id ?? '');
    } else {
      _controller.loadCollectionListBaseOnCategory(cate);
    }
  }
}
