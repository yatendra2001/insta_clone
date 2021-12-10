import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/config/paths.dart';
import 'package:insta_clone/models/post_model.dart';
import 'package:insta_clone/models/comment_model.dart';
import 'package:insta_clone/repositories/post/base_post_repository.dart';

class PostRepository extends BasePostRepository {
  final FirebaseFirestore _firebaseFirestore;
  PostRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createPost({required Post post}) async {
    await _firebaseFirestore.collection(Paths.posts).add(post.toDocument());
  }

  @override
  Future<void> createComment({required Comment comment}) async {
    await _firebaseFirestore
        .collection(Paths.comments)
        .doc(comment.id)
        .collection(Paths.postComments)
        .add(comment.toDocument());
  }

  @override
  Stream<List<Future<Post?>>> getUserPosts({required String userId}) {
    final authorRef = _firebaseFirestore.collection(Paths.users).doc(userId);
    return _firebaseFirestore
        .collection(Paths.posts)
        .where('authors', isEqualTo: authorRef)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => Post.fromDocument(doc)).toList());
  }

  @override
  Stream<List<Future<Comment?>>> getPostComments({required String postId}) {
    return _firebaseFirestore
        .collection(Paths.comments)
        .doc(postId)
        .collection(Paths.postComments)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => Comment.fromDocument(doc)).toList());
  }
}
