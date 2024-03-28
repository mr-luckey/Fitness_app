import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/modules/auth/authentication_controller.dart';

class AuthenticationScreen extends StatelessWidget {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _controller = Get.find<AuthenticationController>();

  AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PageView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            onPageChanged: (index) {
              _currentPageNotifier.value = index;
            },
            controller: _pageController,
            children: [
              // Build phần giới thiệu - trang 1
              // actionOnPress là hàm sẽ chạy khi ấn nút "Bắt đầu"
              _buildIntroduction(
                context,
                actionOnPressed: _nextPage,
              ),

              // Build phần các nút ấn để xác thực tài khoản - trang 2
              _buildAuthentication(
                context,
                authWithGoogleFunc: _authWithGoogle,
                authWithFacebookFunc: _authWithFacebook,
              ),
            ],
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CirclePageIndicator(
                itemCount: 2,
                currentPageNotifier: _currentPageNotifier,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _authWithGoogle() {
    _controller.handleSignIn(SignInType.withGoogle);
  }

  void _authWithFacebook() {
    _controller.handleSignIn(SignInType.withFacebook);
  }
}

// ********************** BUILD PART COMPONENTS **********************

// Hàm build phần giới thiệu
Widget _buildIntroduction(context, {required Function() actionOnPressed}) {
  return Container(
    padding: AppDecoration.screenPadding,
    color: Theme.of(context).backgroundColor,
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              PNGAssetString.logo,
              height: 25,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'Hello I am',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'ViPT',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        Expanded(
          child: Image.asset(
            GIFAssetString.introduction,
            fit: BoxFit.fitHeight,
          ),
        ),
        Text(
          'Lets practice together!',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'I will help you achieve your goals through a specific roadmap.'
              ,
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
            onPressed: actionOnPressed,
            child:
                Text('Begin', style: Theme.of(context).textTheme.button),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    ),
  );
}

// Hàm build phần xác thực
Widget _buildAuthentication(context,
    {required Function() authWithGoogleFunc,
    required Function() authWithFacebookFunc}) {
  return Container(
    padding: AppDecoration.screenPadding,
    color: Theme.of(context).backgroundColor,
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              PNGAssetString.logo,
              height: 25,
            ),
          ],
        ),
        Expanded(
          child: Image.asset(
            GIFAssetString.introduction_2,
            fit: BoxFit.fitHeight,
          ),
        ),
        Text(
          'First, log in to your account!',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Logging in will help save your training and nutrition progress.'
              ,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 20,
        ),
        _buildSignInWithGoogleButton(
          context,
          onPressed: authWithGoogleFunc,
        ),
        const SizedBox(
          height: 14,
        ),
        _buildSignInWithFacebookButton(
          context,
          onPressed: authWithFacebookFunc,
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    ),
  );
}

// Hàm build nút truy cập với Google
Widget _buildSignInWithGoogleButton(context, {required Function() onPressed}) {
  return Container(
    color: Colors.transparent,
    width: double.maxFinite,
    height: 40,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.googleButtonBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              SVGAssetString.google,
              width: 20,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Access with Google'.tr,
              style: Theme.of(context).textTheme.button!.copyWith(
                  fontSize: 14, color: AppColor.googleButtonForegroundColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

// Hàm build nút truy cập với Facebook
Widget _buildSignInWithFacebookButton(context,
    {required Function() onPressed}) {
  return Container(
    color: Colors.transparent,
    width: double.maxFinite,
    height: 40,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.facebookButtonBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              SVGAssetString.facebook,
              color: AppColor.facebookButtonForegroundColor,
              width: 20,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Access using Facebook',
              style: Theme.of(context).textTheme.button!.copyWith(
                  fontSize: 14, color: AppColor.facebookButtonForegroundColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
