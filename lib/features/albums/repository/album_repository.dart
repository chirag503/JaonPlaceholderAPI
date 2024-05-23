import 'package:get/get_connect.dart';

class AlbumRepository extends GetConnect {
  // Get Album List API
  Future<List<dynamic>> getAlbumList(int userId) async {
    final result =
        await get('https://jsonplaceholder.typicode.com/users/$userId/albums');
    return result.body;
  }

// Delete Album API
  Future<Response> deleteAlbum(int id) async {
    final result =
        await delete('https://jsonplaceholder.typicode.com/albums/$id');
    return result;
  }

// Update Album Details API
  Future<Response> updateAlbum({
    required int id,
    required String name,
  }) async {
    final body = {"title": name};
    final result =
        await patch('https://jsonplaceholder.typicode.com/albums/$id', body);
    return result;
  }

// Create New Album API
  Future<Response> createAlbum({
    required int id,
    required int userId,
    required String name,
  }) async {
    final body = {"userId": userId, "id": id, "title": name};
    final result =
        await post('https://jsonplaceholder.typicode.com/albums', body);
    return result;
  }
}
