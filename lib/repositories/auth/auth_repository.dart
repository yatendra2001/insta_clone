import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:insta_clone/config/paths.dart';
import 'package:insta_clone/models/models.dart';
import 'package:insta_clone/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository(
      {auth.FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User> signUpWithEmailAndPassword(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credentials.user;
      _firebaseFirestore.collection(Paths.users).doc(user!.uid).set({
        'username': username,
        'email': email,
        'followers': 0,
        'following': 0,
      });
      return user;
    } on auth.FirebaseAuthException catch (err) {
      throw FailureModel(code: err.code, message: err.message!);
    } on PlatformException catch (err) {
      throw FailureModel(code: err.code, message: err.message!);
    }
  }

  @override
  Future<auth.User> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credentials.user!;
    } on auth.FirebaseAuthException catch (err) {
      throw FailureModel(code: err.code, message: err.message!);
    } on PlatformException catch (err) {
      throw FailureModel(code: err.code, message: err.message!);
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
