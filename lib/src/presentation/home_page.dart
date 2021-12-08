import 'package:final_project/src/actions/get_photos.dart';
import 'package:final_project/src/container/is_loading_container.dart';
import 'package:final_project/src/container/photos_container.dart';
import 'package:final_project/src/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();
  final style = const TextStyle(fontSize: 62, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    final Store store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(GetPhotos(onResult));

    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final double currentPosition = _controller.offset;
    final double maxPosition = _controller.position.maxScrollExtent;

    final Store<AppState> store = StoreProvider.of<AppState>(context);

    if (!store.state.isLoading && currentPosition > maxPosition - MediaQuery.of(context).size.height) {
      store.dispatch(GetPhotos(onResult));
    }
  }

  void onResult(dynamic action) {
    if (action is GetPhotosError) {
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error getting photos'),
            content: Text('${action.error}'),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Nature & Art',
            style: TextStyle(
              fontFamily: 'Tangerine',
              fontSize: 50,
            ),
          ),
        ),
        actions: <Widget>[
          IsLoadingContainer(
            builder: (BuildContext context, bool isLoading) {
              if (!isLoading) {
                return const SizedBox.shrink();
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      body: PhotosContainer(
        builder: (BuildContext context, List<Photo> photos) {
          return ListView.builder(
            controller: _controller,
            itemCount: photos.length,
            itemBuilder: (BuildContext context, int index) {
              final Photo photo = photos[index];
              return ListTile(
                title: Image.network(photo.image),
                subtitle: Text(
                  photo.photographer,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
