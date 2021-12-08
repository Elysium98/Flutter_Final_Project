import 'package:final_project/src/actions/get_photos.dart';
import 'package:final_project/src/data/photos_api.dart';
import 'package:final_project/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// action => action
class AppEpics {
  AppEpics(this._api);

  final PhotosApi _api;

  Epic<AppState> get epics {
    return combineEpics([
      TypedEpic<AppState, GetPhotosStart>(getPhotos),
    ]);
  }

  Stream<dynamic> getPhotos(Stream<GetPhotosStart> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap<void>((GetPhotosStart action) => Stream<void>.value(null)
            .asyncMap((_) => _api.getPhotos(store.state.page))
            .map<Object>((List<Photo> photos) => GetPhotos.successful(photos))
            .onErrorReturnWith((error, stackTrace) => GetPhotos.error(error, stackTrace))
            .doOnData(action.result));
  }
}
