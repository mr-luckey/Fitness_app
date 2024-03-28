import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';

///comment for language changing code @@@
class BodyStatusScreen extends StatefulWidget {
  const BodyStatusScreen({Key? key}) : super(key: key);

  @override
  State<BodyStatusScreen> createState() => _BodyStatusScreenState();
}

class _BodyStatusScreenState extends State<BodyStatusScreen> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    _currentPageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> bodyStatusList = [
      {
        'name': 'Blood sugar increases',
        'asset': SVGAssetString.bloodSugarRises,
        'selectedAsset': SVGAssetString.selectedBloodSugarRises,
        'content':
            'Circadian fasting is a great way to ease into fasting. It matches your body\'s natural metabolism, so you only eat when you\'re full. Fasting can help with weight loss and even prevent diseases.',
        'duration': '0h - 4h',
      },
      {
        'name': 'Blood sugar drops',
        'asset': SVGAssetString.bloodSugarFalls,
        'selectedAsset': SVGAssetString.selectedBloodSugarFalls,
        'content':
            'Your blood sugar continues to fall as your body starts burning fat for energy.',
        'duration': '4h - 8h',
      },
      {
        'name': 'Stable blood sugar',
        'asset': SVGAssetString.bloodSugarStabilizes,
        'selectedAsset': SVGAssetString.selectedBloodSugarStabilizes,
        'content':
            'Your blood sugar levels are at their lowest, which tells your body to turn to fat for energy.',
        'duration': '8h - 12h',
      },
      {
        'name': 'Ketosis',
        'asset': SVGAssetString.ketosis,
        'selectedAsset': SVGAssetString.selectedKetosis,
        'content':
            'After 8-12 hours, glucose in the blood becomes scarce. At this point, your body begins to burn fatty acids.\n\nThis leads to the production of ketones, a flammable organic compound. When you are in ketosis, your body is burning fat.\n\nAt this time, your liver produces ketones that burn fat instead of carbohydrates for fuel. This lowers insulin levels, causing your body to burn more fat for fuel.',
        'duration': '12h - 14h',
      },
      {
        'name': 'Metabolically',
        'asset': SVGAssetString.metabolism,
        'selectedAsset': SVGAssetString.selectedMetabolism,
        'content':
            'Longer fasting periods allow you to burn more fat. During this phase, your body is producing ketones at a rapid rate because there is no glucose in the system. This helps boost metabolism and reduce inflammation.',
        'duration': '14h - 16h',
      },
      {
        'name': 'Autophagy'.tr,
        'asset': SVGAssetString.autophagy,
        'selectedAsset': SVGAssetString.selectedAutophagy,
        'content':
            'After 12 hours of fasting, autophagy begins to work. It means \'self-eating\', because your cells start consuming their own damaged proteins.\n\nFasting for more than 12 hours can boost growth hormone by up to 2,000 parts hundred. This is because fasting helps release another compound called IGFBP1.\n\nHigher levels of IGFBP1 mean better muscle gain, enhanced cognitive function and protection against the effects of aging. ',
        'duration': '16h+',
      },
    ];

    double bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;

    return Scaffold(
      //extendBodyBehindAppBar: true,
      backgroundColor: AppColor.fastingBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 20,
          color: Theme.of(context).backgroundColor,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.accentTextColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Body condition',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: AppColor.accentTextColor,
              ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: bodyStatusList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                if (itemIndex == _currentPageIndex) {
                  return _buildBodyStatusAsset(
                      bodyStatusList[itemIndex]['selectedAsset']);
                } else {
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () async {
                      await _carouselController.animateToPage(itemIndex,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                      await _pageController.animateToPage(itemIndex,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    },
                    child: _buildBodyStatusAsset(
                        bodyStatusList[itemIndex]['asset']),
                  );
                }
              },
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                height: bodyHeight * 0.25,
                viewportFraction: 0.32,
                enableInfiniteScroll: false,
                initialPage: _currentPageIndex,
                onPageChanged: (index, reason) async {
                  await _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
              ),
            ),
            SizedBox(
              height: bodyHeight * 0.7,
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                onPageChanged: (index) async {
                  await _carouselController.animateToPage(index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: [
                  ...bodyStatusList.map((status) {
                    return _buildBodyStatusContent(
                      context,
                      status['name'],
                      status['content'],
                      status['duration'],
                    );
                  }).toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBodyStatusAsset(String? asset) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: asset != null
          ? SvgPicture.asset(
              asset,
              width: 60,
              height: 60,
            )
          : Container(),
    );
  }

  _buildBodyStatusContent(
      context, String? name, String? content, String? duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                decoration: BoxDecoration(
                    color: AppColor.fastingLightSecondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(24)),
                child: Text(
                  duration ?? '',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.fastingBackgroundColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 16,
            ),
            child: Text(
              name ?? '',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: AppColor.accentTextColor.withOpacity(0.90),
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            content ?? '',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColor.accentTextColor.withOpacity(0.80),
                ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
