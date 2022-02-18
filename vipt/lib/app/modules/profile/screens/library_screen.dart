import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/routes/pages.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

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
            Get.back();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            'Thư viện'.tr,
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
            title: 'Bài tập',
            description: 'Tra cứu thông tin chi tiết của một bài tập cụ thể',
          ),
          const Divider(
            indent: 24,
          ),
          CustomTile(
            asset: JPGAssetString.workout_2,
            onPressed: () {
              Get.toNamed(Routes.workoutCollectionCategory);
            },
            title: 'Bộ luyện tập',
            description:
                'Tra cứu các bộ sưu tập gồm nhiều bài tập để tập luyện',
          ),
          const Divider(
            indent: 24,
          ),
          CustomTile(
            asset: PNGAssetString.nutrition_1,
            onPressed: () {},
            title: 'Món ăn',
            description: 'Tra cứu thông tin chi tiết của một món ăn cụ thể',
          ),
          const Divider(
            indent: 24,
          ),
          CustomTile(
            asset: PNGAssetString.nutrition_2,
            onPressed: () {},
            title: 'Bộ dinh dưỡng',
            description: 'Tra cứu các bộ sưu tập gồm nhiều món ăn',
          ),
          const Divider(
            indent: 24,
          ),
        ],
      ),
    );
  }
}
