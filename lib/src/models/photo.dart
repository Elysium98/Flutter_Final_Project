part of models;

@freezed
class Photo with _$Photo {
  const factory Photo({
    required String image,
    required String photographer,
  }) = Photo$;

  factory Photo.fromJson(Map<dynamic, dynamic> json) => _$PhotoFromJson(Map<String, dynamic>.from(json));
}
