import 'dart:convert';

import 'package:http/http.dart';

import '../models/index.dart';

class PhotosApi {
  Future<List<Photo>> getPhotos(int page) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'api.pexels.com',
      pathSegments: <String>['v1', 'search'],
      queryParameters: <String, String>{
        'page': '$page',
        'per_page': '80',
        'query': 'nature and art',
      },
    );

    final Response response =
        await get(uri, headers: {'Authorization': '563492ad6f917000010000010bc6c6be76454145882b824d4ec5efa9'});
    if (response.statusCode != 200) {
      throw StateError('Error fetching the photos.');
    }

    final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> photos = body['photos'] as List<dynamic>;
    return photos //
        .map(
            (dynamic item) => Photo(image: item['src']['tiny'] as String, photographer: item['photographer'] as String))
        .toList();
  }
}
