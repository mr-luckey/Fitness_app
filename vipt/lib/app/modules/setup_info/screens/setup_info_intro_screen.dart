import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/routes/pages.dart';

class SetupInfoIntroScreen extends StatelessWidget {
  const SetupInfoIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: null,
        body: Container(
          padding: AppDecoration.screenPadding,
          child: _buildIntro(context),
        ),
      ),
    );
  }
}

// Hàm build phần giới thiệu cho phần thiết lập thông tin cơ bản

Widget _buildIntro(context) {
  return Column(
    children: [
      Row(
        children: [
          Image.asset(
            PNGAssetString.logo,
            height: 25,
          ),
        ],
      ),
      Expanded(
        child: Image.asset(
          GIFAssetString.setupInfoIntro,
          fit: BoxFit.fitHeight,
        ),
      ),
      Text(
        'Update basic information.',
        style: Theme.of(context).textTheme.headline1,
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        'Stay informed and answer these questions so I can recommend a specific training and nutrition plan just for you.',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        color: Colors.transparent,
        width: double.maxFinite,
        height: 46,
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.setupInfoQuestion);
          },
          child: Text('Begin', style: Theme.of(context).textTheme.button),
        ),
      ),
      // Container(
      //   color: Colors.transparent,
      //   height: 46,
      //   width: double.maxFinite,
      //   child: TextButton(
      //     onPressed: () {},
      //     child: Text(
      //       'Để sau'.tr,
      //       style: Theme.of(context).textTheme.button!.copyWith(
      //             fontSize: 16,
      //             color:
      //                 AppColor.textColor.withOpacity(AppColor.subTextOpacity),
      //           ),
      //     ),
      //   ),
      // ),
    ],
  );
}

//

