import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/data/models/question.dart';
import 'package:vipt/app/enums/app_enums.dart';

import 'app_strings.dart';
import 'asset_strings.dart';

class AppQuiz {
  static const Map<int, int> moduleMap = {
    // 0: 11,
    // 1: 4,
    // 2: 4,
    0: 6,
    1: 1,
    // 2: 0,
  };

  static Map<Question, List<Answer>> questions = {
    // Module 1
    Question(
        title: 'What\'s your name?',
        description: '',
        moduleParent: 0,
        moduleIndex: 1,
        propertyLink: PropertyLink.userName,
        layoutType: QuestionLayoutType.textField): [],
    Question(
        title: 'Weight goals',
        description: 'How much weight do you want to be able to achieve?',
        moduleParent: 0,
        moduleIndex: 2,
        propertyLink: PropertyLink.userGoalWeight,
        layoutType: QuestionLayoutType.measurementPicker): [],
    Question(
        title: 'Sex',
        propertyLink: PropertyLink.userGender,
        description:
            'Collecting this information will enable me to calculate your BMI and create a personalized healthy weight plan for you.'
                .tr,
        moduleParent: 0,
        moduleIndex: 3,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Name',
          description: 'Biologically there is male sex',
          asset: SVGAssetString.male,
          enumValue: Gender.male),
      Answer(
          title: 'Female',
          description: 'Biologically, there is a female sex',
          asset: SVGAssetString.female,
          enumValue: Gender.female),
      Answer(
          title: 'Other',
          description: 'Bisexual, demisexual, homosexual,...',
          asset: SVGAssetString.otherGender,
          enumValue: Gender.other),
    ],
    Question(
        propertyLink: PropertyLink.userDateOfBirth,
        title: 'Date of birth',
        description:
            'Collecting this information will enable me to calculate your BMI and create a personalized healthy weight plan for you.',
        moduleParent: 0,
        moduleIndex: 4,
        layoutType: QuestionLayoutType.datePicker): [],
    Question(
        propertyLink: PropertyLink.userWeight,
        title: 'Current weight'.tr,
        description:
            'Collecting this information will enable me to calculate your BMI and create a personalized healthy weight plan for you.',
        moduleParent: 0,
        moduleIndex: 5,
        layoutType: QuestionLayoutType.measurementPicker): [],
    Question(
        propertyLink: PropertyLink.userHeight,
        title: 'Current height',
        description:
            'Collecting this information will enable me to calculate your BMI and create a personalized healthy weight plan for you.'
                .tr,
        moduleParent: 0,
        moduleIndex: 6,
        layoutType: QuestionLayoutType.measurementPicker): [],
    // Question(
    //     title: 'Mục tiêu chính'.tr,
    //     propertyLink: PropertyLink.userMainGoal,
    //     description:
    //         'Bạn hãy chọn một lựa chọn phù hợp nhất trong những lựa chọn bên dưới.'
    //             .tr,
    //     moduleParent: 0,
    //     moduleIndex: 7,
    //     layoutType: QuestionLayoutType.singleChoiceOneColumn): [
    //   Answer(
    //       title: 'Giảm cân, giảm mỡ'.tr,
    //       description: 'Đốt mỡ nhưng không làm mất đi sức mạnh'.tr,
    //       asset: SVGAssetString.burnFire,
    //       enumValue: MainGoal.loseWeight),
    //   Answer(
    //       title: 'Tăng cơ bắp'.tr,
    //       description: 'Xây dựng cơ bắp to khỏe, săn chắc, chất lượng'.tr,
    //       asset: SVGAssetString.muscle,
    //       enumValue: MainGoal.buildMuscle),
    //   Answer(
    //       title: 'Có vóc dáng đẹp'.tr,
    //       description: 'Giữ vóc dáng vừa vặn, tăng cường sức bền của cơ thể'.tr,
    //       asset: SVGAssetString.fitBody,
    //       enumValue: MainGoal.getFit),
    //   Answer(
    //       title: 'Tăng sức mạnh'.tr,
    //       description: 'Trở nên mạnh mẽ hơn về thể chất, sức mạnh'.tr,
    //       asset: SVGAssetString.strongMan,
    //       enumValue: MainGoal.gainStrength),
    // ],
    // Question(
    //     canBeSkipped: true,
    //     title: 'Các vấn đề đặc biệt'.tr,
    //     propertyLink: PropertyLink.userLimit,
    //     description: '',
    //     moduleParent: 0,
    //     moduleIndex: 8,
    //     layoutType: QuestionLayoutType.multipleChoiceOneColumn): [
    //   Answer(
    //       title: 'Có các vấn đề về khớp gối'.tr,
    //       description: '',
    //       asset: SVGAssetString.knee,
    //       enumValue: PhyscialLimitaion.kneePain),
    //   Answer(
    //       title: 'Có các vấn đề về lưng'.tr,
    //       description: '',
    //       asset: SVGAssetString.backPain,
    //       enumValue: PhyscialLimitaion.backPain),
    //   Answer(
    //       title: 'Khả năng di chuyển hạn chế'.tr,
    //       description: '',
    //       asset: SVGAssetString.wheelChair,
    //       enumValue: PhyscialLimitaion.limitedMobility),
    // ],
    // Question(
    //     title: 'Kiểu cơ thể'.tr,
    //     propertyLink: PropertyLink.userBodyType,
    //     description: 'Hình ảnh nào dưới đây gần giống với bạn nhất?'.tr,
    //     moduleParent: 0,
    //     moduleIndex: 9,
    //     layoutType: QuestionLayoutType.singleChoiceOneColumn): [
    //   Answer(
    //       title: 'Ectomorph'.tr,
    //       description: 'Kiểu cơ thể'.tr,
    //       asset: PNGAssetString.ectomorph,
    //       enumValue: BodyType.ectomorph),
    //   Answer(
    //       title: 'Mesomorph'.tr,
    //       description: 'Kiểu cơ thể'.tr,
    //       asset: PNGAssetString.mesomorph,
    //       enumValue: BodyType.mesomorph),
    //   Answer(
    //       title: 'Endomorph'.tr,
    //       description: 'Kiểu cơ thể'.tr,
    //       asset: PNGAssetString.endomorph,
    //       enumValue: BodyType.endomorph),
    // ],
    // Question(
    //     canBeSkipped: true,
    //     title: 'Sở thích'.tr,
    //     propertyLink: PropertyLink.userHobby,
    //     description: '',
    //     moduleParent: 0,
    //     moduleIndex: 10,
    //     layoutType: QuestionLayoutType.multipleChoiceOneColumn): [
    //   Answer(
    //       title: 'Tập luyện tại nhà'.tr,
    //       description: '',
    //       asset: SVGAssetString.home,
    //       enumValue: Hobby.homeWorkOut),
    //   Answer(
    //       title: 'Đi bộ'.tr,
    //       description: '',
    //       asset: SVGAssetString.walking,
    //       enumValue: Hobby.walking),
    //   Answer(
    //       title: 'Chạy bộ'.tr,
    //       description: '',
    //       asset: SVGAssetString.running,
    //       enumValue: Hobby.running),
    //   Answer(
    //       title: 'Yoga'.tr,
    //       description: '',
    //       asset: SVGAssetString.yoga,
    //       enumValue: Hobby.yoga),
    //   Answer(
    //       title: 'Nhảy'.tr,
    //       description: '',
    //       asset: SVGAssetString.dancing,
    //       enumValue: Hobby.dancing),
    //   Answer(
    //       title: 'Gym'.tr,
    //       description: '',
    //       asset: SVGAssetString.gym,
    //       enumValue: Hobby.gym),
    //   Answer(
    //       title: 'Đánh nhau'.tr,
    //       description: '',
    //       asset: SVGAssetString.boxing,
    //       enumValue: Hobby.fighting),
    // ],
    // Question(
    //     title: 'Kinh nghiệm'.tr,
    //     propertyLink: PropertyLink.userExp,
    //     description: '',
    //     moduleParent: 0,
    //     moduleIndex: 11,
    //     layoutType: QuestionLayoutType.singleChoiceOneColumn): [
    //   Answer(
    //       title: 'Mới bắt đầu'.tr,
    //       description: '',
    //       asset: null,
    //       enumValue: Experience.beginner),
    //   Answer(
    //       title: 'Có kinh nghiệm'.tr,
    //       description: '',
    //       asset: null,
    //       enumValue: Experience.intermediate),
    //   Answer(
    //       title: 'Chuyên nghiệp'.tr,
    //       description: '',
    //       asset: null,
    //       enumValue: Experience.advanced),
    // ],

    // Module 2
    // Question(
    //     title: 'Kiểu ngày bình thường của bạn?'.tr,
    //     propertyLink: PropertyLink.userTypicalDay,
    //     description:
    //         'Để có thể đạt được mục tiêu về vóc dáng cơ thể thì mỗi cá nhân đều có một hướng tiếp cận riêng dựa trên thói quen của chính mình.'
    //             .tr,
    //     moduleParent: 1,
    //     moduleIndex: 1,
    //     layoutType: QuestionLayoutType.singleChoiceOneColumn): [
    //   Answer(
    //       title: 'Công việc văn phòng'.tr,
    //       description: 'Kiểu ngày bình thường'.tr,
    //       asset: PNGAssetString.office,
    //       enumValue: TypicalDay.office),
    //   Answer(
    //       title: 'Đi bộ mỗi ngày'.tr,
    //       description: 'Kiểu ngày bình thường'.tr,
    //       asset: PNGAssetString.walking,
    //       enumValue: TypicalDay.walkingDaily),
    //   Answer(
    //       title: 'Hầu như chỉ ở nhà'.tr,
    //       description: 'Kiểu ngày bình thường'.tr,
    //       asset: PNGAssetString.home,
    //       enumValue: TypicalDay.mostlyAtHome),
    //   Answer(
    //       title: 'Vận động tay chân'.tr,
    //       description: 'Kiểu ngày bình thường'.tr,
    //       asset: PNGAssetString.work,
    //       enumValue: TypicalDay.workPhysically),
    // ],
    Question(
        title: 'How do you usually exercise?',
        description: 'How many sessions per week do you spend exercising?',
        moduleParent: 1,
        propertyLink: PropertyLink.userActiveFrequency,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Not much',
          description: 'Irregular or absent',
          asset: null,
          enumValue: ActiveFrequency.notMuch),
      Answer(
          title: 'Little',
          description: 'From 1 to 2 sessions a week',
          asset: null,
          enumValue: ActiveFrequency.few),
      Answer(
          title: 'Medium',
          description: 'From 3 to 5 sessions a week',
          asset: null,
          enumValue: ActiveFrequency.average),
      Answer(
          title: 'Much',
          description: 'From 6 to 7 sessions a week',
          asset: null,
          enumValue: ActiveFrequency.much),
      Answer(
          title: 'So many',
          description: 'High-intensity activity throughout the week',
          asset: null,
          enumValue: ActiveFrequency.soMuch),
    ],
    // Question(
    //     title: 'Mỗi đêm bạn dành ra bao nhiêu thời gian để ngủ?'.tr,
    //     description:
    //         'Việc ngủ đủ giấc là rất cần thiết trong việc hình thành nên vóc dáng cơ thể đẹp.'
    //             .tr,
    //     moduleParent: 1,
    //     propertyLink: PropertyLink.userSleepTime,
    //     moduleIndex: 3,
    //     layoutType: QuestionLayoutType.singleChoiceOneColumn): [
    //   Answer(
    //       title: 'Không nhiều'.tr,
    //       description: 'Ít hơn 3 giờ'.tr,
    //       asset: null,
    //       enumValue: SleepTime.notMuch),
    //   Answer(
    //       title: 'Ít'.tr,
    //       description: 'Từ 3 đến 6 giờ'.tr,
    //       asset: null,
    //       enumValue: SleepTime.few),
    //   Answer(
    //       title: 'Trung bình'.tr,
    //       description: 'Từ 7 đến 8 giờ'.tr,
    //       asset: null,
    //       enumValue: SleepTime.average),
    //   Answer(
    //       title: 'Nhiều'.tr,
    //       description: 'Trên 8 giờ'.tr,
    //       asset: null,
    //       enumValue: SleepTime.much),
    // ],
    // Question(
    //     canBeSkipped: true,
    //     title: 'Thói quen xấu'.tr,
    //     propertyLink: PropertyLink.userBadHabit,
    //     description: '',
    //     moduleParent: 1,
    //     moduleIndex: 4,
    //     layoutType: QuestionLayoutType.multipleChoiceOneColumn): [
    //   Answer(
    //       title: 'Không nghỉ ngơi đủ'.tr,
    //       description: '',
    //       asset: SVGAssetString.night,
    //       enumValue: BadHabit.notRestMuch),
    //   Answer(
    //       title: 'Ăn nhiều đồ ngọt'.tr,
    //       description: '',
    //       asset: SVGAssetString.sweet,
    //       enumValue: BadHabit.drinkSoftDrink),
    //   Answer(
    //       title: 'Uống nhiều nước ngọt'.tr,
    //       description: '',
    //       asset: SVGAssetString.soda,
    //       enumValue: BadHabit.eatManySweets),
    //   Answer(
    //       title: 'Ăn đồ mặn'.tr,
    //       description: '',
    //       asset: SVGAssetString.salt,
    //       enumValue: BadHabit.eatSalty),
    //   Answer(
    //       title: 'Ăn vặt'.tr,
    //       description: '',
    //       asset: SVGAssetString.pizza,
    //       enumValue: BadHabit.eatSnackLate),
    //   Answer(
    //       title: 'Uống rượu bia nhiều'.tr,
    //       description: '',
    //       asset: SVGAssetString.beer,
    //       enumValue: BadHabit.drinkMuchBeer),
    // ],

    // Module 3
    // Question(
    //     title: 'Chế độ ăn kiêng của bạn'.tr,
    //     description:
    //         'Hãy chọn theo thói quen hằng ngày hoặc sở thích của bạn.'.tr,
    //     moduleParent: 2,
    //     propertyLink: PropertyLink.userDiet,
    //     moduleIndex: 1,
    //     layoutType: QuestionLayoutType.singleChoiceOneColumn): [
    //   Answer(
    //       title: 'Truyền thống'.tr,
    //       description: '',
    //       asset: SVGAssetString.traditional,
    //       enumValue: Diet.traditional),
    //   Answer(
    //       title: 'Ăn nửa chay'.tr,
    //       description: '',
    //       asset: SVGAssetString.vegetarian,
    //       enumValue: Diet.vegetarian),
    //   Answer(
    //       title: 'Keto'.tr,
    //       description: '',
    //       asset: SVGAssetString.keto,
    //       enumValue: Diet.keto),
    //   Answer(
    //       title: 'Ăn thuần chay'.tr,
    //       description: '',
    //       asset: SVGAssetString.vegan,
    //       enumValue: Diet.vegan),
    //   Answer(
    //       title: 'Keto chay'.tr,
    //       description: '',
    //       asset: SVGAssetString.ketoVegan,
    //       enumValue: Diet.ketoVegan),
    //   Answer(
    //       title: 'Pescatarian'.tr,
    //       description: '',
    //       asset: SVGAssetString.pescatarian,
    //       enumValue: Diet.pescatarian),
    //   Answer(
    //       title: 'Không Lactose'.tr,
    //       description: '',
    //       asset: SVGAssetString.lactoseFree,
    //       enumValue: Diet.lactoseFree),
    //   Answer(
    //       title: 'Không Gluten'.tr,
    //       description: '',
    //       asset: SVGAssetString.glutenFree,
    //       enumValue: Diet.glutenFree),
    //   Answer(
    //       title: 'Paleo'.tr,
    //       description: '',
    //       asset: SVGAssetString.paleo,
    //       enumValue: Diet.paleo),
    //   Answer(
    //       title: 'Mediterranean'.tr,
    //       description: '',
    //       asset: SVGAssetString.mediterranean,
    //       enumValue: Diet.mediterranean),
    //   Answer(
    //       title: 'Tiểu đường loại một'.tr,
    //       description: '',
    //       asset: SVGAssetString.diabetes_1,
    //       enumValue: Diet.diabetsTypeOne),
    //   Answer(
    //       title: 'Tiểu đường loại hai'.tr,
    //       description: '',
    //       asset: SVGAssetString.diabetes_2,
    //       enumValue: Diet.diabetsTypeTwo),
    //   Answer(
    //       title: 'Theo dịp lễ'.tr,
    //       description: '',
    //       asset: SVGAssetString.holiday,
    //       enumValue: Diet.holiday),
    // ],
    // Question(
    //     canBeSkipped: true,
    //     title: 'Nguồn chất đạm'.tr,
    //     propertyLink: PropertyLink.userProteinSource,
    //     description:
    //         'Hãy chọn theo thói quen hằng ngày hoặc sở thích của bạn.'.tr,
    //     moduleParent: 2,
    //     moduleIndex: 2,
    //     layoutType: QuestionLayoutType.multipleChoiceOneColumn): [
    //   Answer(
    //       title: 'Ức gà'.tr,
    //       description: '',
    //       asset: PNGAssetString.chicken,
    //       enumValue: ProteinSource.chickenBreast),
    //   Answer(
    //       title: 'Trứng gà'.tr,
    //       description: '',
    //       asset: PNGAssetString.egg,
    //       enumValue: ProteinSource.egg),
    //   Answer(
    //       title: 'Sữa chua'.tr,
    //       description: '',
    //       asset: PNGAssetString.yogurt,
    //       enumValue: ProteinSource.yogurt),
    //   Answer(
    //       title: 'Phô mai tươi'.tr,
    //       description: '',
    //       asset: PNGAssetString.cottageCheese,
    //       enumValue: ProteinSource.cottageCheese),
    //   Answer(
    //       title: 'Đậu hũ'.tr,
    //       description: '',
    //       asset: PNGAssetString.tofu,
    //       enumValue: ProteinSource.tofu),
    //   Answer(
    //       title: 'Dầu Ô-liu'.tr,
    //       description: '',
    //       asset: PNGAssetString.olives,
    //       enumValue: ProteinSource.olives),
    //   Answer(
    //       title: 'Quả hạch'.tr,
    //       description: '',
    //       asset: PNGAssetString.nuts,
    //       enumValue: ProteinSource.nuts),
    //   Answer(
    //       title: 'Bơ đậu phộng'.tr,
    //       description: '',
    //       asset: PNGAssetString.peanutButter,
    //       enumValue: ProteinSource.peanutButter),
    // ],
    // Question(
    //     title: 'Mỗi ngày bạn uống khoảng bao nhiêu nước?'.tr,
    //     propertyLink: PropertyLink.userDailyWater,
    //     description: '',
    //     moduleParent: 2,
    //     moduleIndex: 3,
    //     layoutType: QuestionLayoutType.singleChoiceOneColumn): [
    //   Answer(
    //       title: 'Không nhiều'.tr,
    //       description: 'Ít hơn 1 ly nước'.tr,
    //       asset: null,
    //       enumValue: DailyWater.notMuch),
    //   Answer(
    //       title: 'Ít'.tr,
    //       description: 'Từ 1 đến 2 ly nước'.tr,
    //       asset: null,
    //       enumValue: DailyWater.few),
    //   Answer(
    //       title: 'Trung bình'.tr,
    //       description: 'Từ 3 đến 6 ly nước'.tr,
    //       asset: null,
    //       enumValue: DailyWater.average),
    //   Answer(
    //       title: 'Nhiều'.tr,
    //       description: 'Trên 6 ly nước'.tr,
    //       asset: null,
    //       enumValue: DailyWater.much),
    // ],
  };
}
