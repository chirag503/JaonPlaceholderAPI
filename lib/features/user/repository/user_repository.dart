import 'package:get/get_connect.dart';

class UserRepository extends GetConnect {

  
  // Get User List
  Future<List<dynamic>> getUserList() async {
    final result = await get('https://jsonplaceholder.typicode.com/users');
    return result.body;
  }

// Delete User API
  Future<Response> deleteuser(int id) async {
    final result =
        await delete('https://jsonplaceholder.typicode.com/users/$id');
    return result;
  }

// Update User Details API
  Future<Response> updateUser(
      {required int id, required String name, required String username}) async {
    final body = {"username": username, "name": name};
    final result =
        await patch('https://jsonplaceholder.typicode.com/users/$id', body);
    return result;
  }

// Create User API
  Future<Response> createUser(
      {required String phone,
      required String username,
      required String name,
      required String email}) async {
    final body = {
      "name": name,
      "username": username,
      "phone": phone,
      "email": email
    };
    final result =
        await post('https://jsonplaceholder.typicode.com/users', body);
    return result;
  }
}
