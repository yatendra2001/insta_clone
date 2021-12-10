part of 'create_post_cubit.dart';

enum CreatePostStatus { initial, submitting, success, error }

class CreatePostState extends Equatable {
  final File? postImage;
  final String caption;
  final CreatePostStatus status;
  final FailureModel failure;
  const CreatePostState({
    required this.postImage,
    required this.caption,
    required this.status,
    required this.failure,
  });

  @override
  List<Object?> get props => [postImage, caption, status, failure];

  factory CreatePostState.initial() {
    return const CreatePostState(
      postImage: null,
      caption: '',
      status: CreatePostStatus.initial,
      failure: FailureModel(),
    );
  }

  CreatePostState copyWith({
    File? postImage,
    String? caption,
    CreatePostStatus? status,
    FailureModel? failure,
  }) {
    return CreatePostState(
      postImage: postImage ?? this.postImage,
      caption: caption ?? this.caption,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
