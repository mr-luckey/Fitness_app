import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/modules/setting/setting_controller.dart';
import 'package:vipt/app/routes/pages.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/enums/app_enums.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final _controller = Get.find<SettingController>();

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
            'Setting',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CircleAvatar(
              radius: Get.size.width * 0.1,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  AuthService.instance.currentUser!.photoURL!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DataService.currentUser!.name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AuthService.instance.currentUser!.email!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: ListTile(
              dense: true,
              title: Text(
                'Information',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          const Divider(
            indent: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: ListTile(
              title: Text(
                'Sex',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Text(
                getGenderString(DataService.currentUser!.gender),
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: ListTile(
              title: Text(
                'Target weight',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Text(
                '${DataService.currentUser!.goalWeight} ${DataService.currentUser!.weightUnit.toString().split('.').last}',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: ListTile(
              title: Text(
                'Current weight',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Text(
                '${DataService.currentUser!.currentWeight} ${DataService.currentUser!.weightUnit.toString().split('.').last}',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: ListTile(
              title: Text(
                'Current height',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Text(
                '${DataService.currentUser!.currentHeight} ${DataService.currentUser!.heightUnit.toString().split('.').last}',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: ListTile(
              title: Text(
                'Operating frequency',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Text(
                getActiveFrequencyString(
                    DataService.currentUser!.activeFrequency),
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8),
            child: ListTile(
              title: Text(
                'Date of birth',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Text(
                DateFormat('dd/MM/yyyy')
                    .format(DataService.currentUser!.dateOfBirth),
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListTile(
              onTap: () async {
                await _controller.changeBasicInforamtion();
              },
              leading: Icon(Icons.info, color: AppColor.textColor),
              title: Text(
                'Change original information',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListTile(
              onTap: () async {
                await _controller.changeWeightGoal();
              },
              leading: Icon(Icons.checklist_rounded, color: AppColor.textColor),
              title: Text(
                'Change your weight goal',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          const Divider(
            indent: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListTile(
              onTap: () async {
                await AuthService.instance.signOut();
                DataService.instance.resetUserData();
                Get.offAllNamed(Routes.auth);
              },
              leading:
                  Icon(Icons.exit_to_app_rounded, color: AppColor.textColor),
              title: Text(
                'Log out',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getGenderString(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Nam';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }

  getActiveFrequencyString(ActiveFrequency activeFrequency) {
    switch (activeFrequency) {
      case ActiveFrequency.notMuch:
        return 'Not much';
      case ActiveFrequency.few:
        return 'Little';
      case ActiveFrequency.average:
        return 'Average';
      case ActiveFrequency.much:
        return 'Many';
      case ActiveFrequency.soMuch:
        return 'A lot';
    }
  }
}
