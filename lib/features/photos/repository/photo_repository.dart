import 'package:get/get.dart';
import 'package:get/get_connect.dart';

class PhotoRepository extends GetConnect {
  // Get Photo List API
  Future<List<dynamic>> getPhotoList(int albumId) async {
    final result = await get(
        'https://jsonplaceholder.typicode.com/albums/$albumId/photos');
    return result.body;
  }

  // Delete Photo API
  Future<Response> deletePhoto(int photoId) async {
    final result =
        await delete('https://jsonplaceholder.typicode.com/photos/$photoId');
    return result;
  }

// Upload the New Photo API
  Future<Response> uploadPhoto({
    required int id,
    required int albumId,
    required String title,
    required List<int> file,
  }) async {
    final body = {
      "albumId": albumId,
      "id": id,
      "title": title,
    };
    FormData formData = FormData(body);
    formData.files.add(MapEntry('file', MultipartFile(file, filename: title)));
    final result =
        await post('https://jsonplaceholder.typicode.com/photos', formData);
    return result;
  }
}
