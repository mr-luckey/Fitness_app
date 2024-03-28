import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CloudStorageService {
  CloudStorageService._privateConstuctor();
  static final CloudStorageService instance =
      CloudStorageService._privateConstuctor();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final String _storageLink = 'gs://fitness-app-b53a5.appspot.com';
  String get storageLink => _storageLink;
}
