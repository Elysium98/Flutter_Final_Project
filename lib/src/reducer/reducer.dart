import 'package:final_project/src/actions/get_photos.dart';
import 'package:final_project/src/models/index.dart';
import 'package:redux/redux.dart';

// state + action => state
Reducer<AppState> reducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, GetPhotosStart>(_getPhotos),
  TypedReducer<AppState, GetPhotosSuccessful>(_getPhotosSuccessful),
  TypedReducer<AppState, GetPhotosError>(_getPhotosError),
]);

AppState _getPhotos(AppState state, GetPhotosStart action) {
  return state.copyWith(isLoading: true);
}

AppState _getPhotosSuccessful(AppState state, GetPhotosSuccessful action) {
  final List<Photo> photos = <Photo>[];

  photos.addAll(state.photos);
  photos.addAll(action.photos);

  return state.copyWith(
    photos: photos,
    page: state.page + 1,
    isLoading: false,
  );
}

AppState _getPhotosError(AppState state, GetPhotosError action) {
  return state.copyWith(isLoading: false);
}
