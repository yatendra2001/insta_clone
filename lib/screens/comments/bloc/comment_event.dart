part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentsFetchComments extends CommentEvent {
  final Post post;
  const CommentsFetchComments({
    required this.post,
  });
  @override
  List<Object> get props => [post];
}

class CommentsUpdateComments extends CommentEvent {
  final List<Comment?> comments;
  const CommentsUpdateComments({
    required this.comments,
  });

  @override
  List<Object> get props => [comments];
}

class CommentsPostComment extends CommentEvent {
  final String content;
  const CommentsPostComment({
    required this.content,
  });

  @override
  List<Object> get props => [content];
}
