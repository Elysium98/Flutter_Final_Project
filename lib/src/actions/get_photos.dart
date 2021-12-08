import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/index.dart';

part 'get_photos.freezed.dart';

@freezed
class GetPhotos with _$GetPhotos {
  const factory GetPhotos(void Function(dynamic action) result) = GetPhotosStart;

  const factory GetPhotos.successful(List<Photo> photos) = GetPhotosSuccessful;

  const factory GetPhotos.error(Object error, StackTrace stackTrace) = GetPhotosError;
}
