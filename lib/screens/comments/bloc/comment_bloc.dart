import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_clone/blocs/auth/auth_bloc.dart';
import 'package:insta_clone/models/models.dart';
import 'package:insta_clone/repositories/post/post_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;
  StreamSubscription<List<Future<Comment?>>>? _commentsSubscription;
  CommentBloc(
      {required PostRepository postRepository, required AuthBloc authBloc})
      : _postRepository = postRepository,
        _authBloc = authBloc,
        super(CommentState.initial());

  @override
  Future<void> close() {
    _commentsSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is CommentsFetchComments) {
      yield* _mapCommentFetchCommentsToState(event);
    }
    // } else if (event is CommentsUpdateComments) {
    //   yield* _mapCommentsUpdateCommentsToState(event);
    // } else if (event is CommentsPostComment) {
    //   yield* _mapCommentsPostCommentToState(event);
    // }
  }

  Stream<CommentState> _mapCommentFetchCommentsToState(
      CommentsFetchComments event) async* {
    yield state.copyWith(status: CommentsStatus.loading);
    try {
      _commentsSubscription?.cancel();
      _commentsSubscription = _postRepository
          .getPostComments(postId: event.post.id!)
          .listen((comments) async {
        final allComments = await Future.wait(comments);
        add(CommentsUpdateComments(comments: allComments));
      });
      yield state.copyWith(post: event.post, status: CommentsStatus.loaded);
    } catch (err) {
      yield state.copyWith(
        status: CommentsStatus.error,
        failure:
            const FailureModel(message: 'We were unable to post\'s comments.'),
      );
    }
  }

  Stream<CommentState> _mapCommentUpdateCommentsToState(
      CommentsUpdateComments event) async* {
    yield state.copyWith(comments: event.comments);
  }

  Stream<CommentState> _mapCommentPostCommentsToState(
      CommentsPostComment event) async* {
    yield state.copyWith(status: CommentsStatus.submitting);
    try {
      final author = User.empty.copyWith(id: _authBloc.state.user!.uid);
      final comment = Comment(
        author: author,
        postId: state.post!.id!,
        content: event.content,
        date: DateTime.now(),
      );

      await _postRepository.createComment(comment: comment);

      yield state.copyWith(status: CommentsStatus.loaded);
    } catch (err) {
      print("error is  $err");
      yield state.copyWith(
        status: CommentsStatus.error,
        failure: const FailureModel(message: 'Comment failed to post'),
      );
    }
  }
}
