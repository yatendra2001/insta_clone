import 'dart:io';

abstract class BaseStorageRepository {
  Future<String> uploadProfileImage(
      {required String profileImageUrl, required File image});
  Future<String> uploadPostImage({required File image});
}
