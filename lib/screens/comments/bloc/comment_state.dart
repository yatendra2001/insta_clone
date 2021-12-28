part of 'comment_bloc.dart';

enum CommentsStatus { initial, loading, loaded, submitting, error }

class CommentState extends Equatable {
  final Post? post;
  final List<Comment?> comments;
  final CommentsStatus status;
  final FailureModel failure;

  const CommentState({
    required this.post,
    required this.comments,
    required this.status,
    required this.failure,
  });

  factory CommentState.initial() {
    return const CommentState(
      post: null,
      comments: [],
      status: CommentsStatus.initial,
      failure: FailureModel(),
    );
  }

  @override
  List<Object?> get props => [post, comments, status, failure];

  CommentState copyWith({
    Post? post,
    List<Comment?>? comments,
    CommentsStatus? status,
    FailureModel? failure,
  }) {
    return CommentState(
      post: post ?? this.post,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
