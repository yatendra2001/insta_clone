import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:insta_clone/repositories/repositories.dart';
import 'package:uuid/uuid.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({
    FirebaseStorage? firebaseStorage,
  }) : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> _uploadImage(
      {required String ref, required File image}) async {
    final downloadUrl = _firebaseStorage
        .ref(ref)
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    return downloadUrl;
  }

  @override
  Future<String> uploadProfileImage(
      {required String profileImageUrl, required File image}) async {
    var imageId = const Uuid().v4();

    //Update user profile image
    if (profileImageUrl.isNotEmpty) {
      final exp = RegExp(r'userProfile_(.*).jpg');
      imageId = exp.firstMatch(profileImageUrl)![1]!;
    }
    final downloadUrl = await _uploadImage(
        ref: 'images/users/userProfile_$imageId.jpg', image: image);
    return downloadUrl;
  }

  @override
  Future<String> uploadPostImage({required File image}) async {
    final imageId = const Uuid().v4();
    final downloadUrl =
        await _uploadImage(ref: 'images/posts/post_$imageId.jpg', image: image);
    return downloadUrl;
  }
}
