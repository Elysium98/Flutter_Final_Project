part of models;

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(<Photo>[]) List<Photo> photos,
    @Default(false) bool isLoading,
    @Default(1) int page,
  }) = AppState$;
}
