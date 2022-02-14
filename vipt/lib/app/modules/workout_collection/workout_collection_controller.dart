import 'package:get/get.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/providers/workout_collection_setting_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutCollectionController extends GetxController {
  late List<WorkoutCollection> collections;
  late List<Category> collectionCategories;
  late Map<String, int> cateListAndNumCollection;
  late Rx<CollectionSetting> collectionSetting;
  Rx<int> caloValue = 0.obs;
  Rx<int> timeValue = 0.obs;

  @override
  void onInit() {
    loadCollectionCategories();
    initCollections();
    loadCateListAndNumCollection();
    initCollectionSetting();
    super.onInit();

    ever(collectionSetting, (_) {
      calculateCaloAndTime();
    });
  }

  List<Workout> loadWorkoutList(List<String> workoutIDs) {
    List<Workout> list = [];
    for (var id in workoutIDs) {
      var workout = DataService.instance.workoutList
          .firstWhere((element) => element.id == id);
      list.add(workout);
    }

    return list;
  }

  void resetCaloAndTime() {
    caloValue.value = 0;
    timeValue.value = 0;
  }

  void calculateCaloAndTime() {
    caloValue.value++;
    timeValue.value++;
  }

  void initCollectionSetting() {
    collectionSetting = CollectionSetting().obs;
  }

  void loadCollectionSetting() {
    collectionSetting.value = DataService.currentUser.collectionSetting;
    update();
  }

  Future<void> updateCollectionSetting() async {
    await WorkoutCollectionSettingProvider()
        .update('id', collectionSetting.value);
  }

  void loadCateListAndNumCollection() {
    cateListAndNumCollection = DataService.instance.cateListAndNumCollection;
  }

  void loadCollectionCategories() {
    collectionCategories = DataService.instance.collectionCateList
        .where((element) => element.parentCategoryID == null)
        .toList();
  }

  void initCollections() {
    collections = [];
  }

  void loadCollectionListBaseOnCategory(Category cate) {
    collections = DataService.instance.collectionList
        .where((collection) => collection.categoryIDs.contains(cate.id))
        .toList();
    Get.toNamed(Routes.workoutCollectionList, arguments: cate);
  }

  void loadChildCategoriesBaseOnParentCategory(String categoryID) {
    collectionCategories = DataService.instance.collectionCateList
        .where((element) => element.parentCategoryID == categoryID)
        .toList();
    Get.toNamed(Routes.workoutCollectionCategory, preventDuplicates: false);
  }
}
