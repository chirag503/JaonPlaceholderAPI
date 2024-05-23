import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/features/user/models/user_list_model.dart';
import 'package:myapp/features/user/repository/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();

  var isLoading = false.obs;
  var isEnable = false.obs;
  var updateBtn = false.obs;
  List<UserListModel> _usersList = [];
  List<UserListModel> get usersList => _usersList;

  final TextEditingController updateNameController = TextEditingController();
  final TextEditingController updateUsernameController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void onInit() {
    getUsersData();
    super.onInit();
  }

// Get the user list from API
  void getUsersData() async {
    try {
      isLoading(true);
      final response = await _userRepository.getUserList();
      _usersList = userListModelFromJson(jsonEncode(response));
      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
  }

// Delete the user based on id
  void deleteUser(int userId) async {
    try {
      isLoading(true);
      final response = await _userRepository.deleteuser(userId);
      if (response.statusCode == 200) {
        _usersList.removeWhere((element) => element.id == userId);
        isLoading(false);
        Get.snackbar("Success", "User deleted successfully",
            backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      } else {
        isLoading(false);
        Get.snackbar("Unsuccessful", "Something went wrong",
            backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Unsuccessful", "Something went wrong",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }

// Get the existing details of user
  getInitText(String name, String username) {
    updateNameController.text = name;
    updateUsernameController.text = username;
  }

  // Update the user details
  void updateUser(int userId) async {
    try {
      isLoading(true);
      final response = await _userRepository.updateUser(
          id: userId,
          name: updateNameController.text,
          username: updateUsernameController.text);
      if (response.statusCode == 200) {
        final user = _usersList.firstWhere((element) => element.id == userId);
        user.name = updateNameController.text;
        user.username = updateUsernameController.text;
        isLoading(false);
        Get.snackbar("Success", "User update successfully",
            backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      } else {
        isLoading(false);
        Get.snackbar("Unsuccessful", "Something went wrong",
            backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Unsuccessful", "Something went wrong",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }

  // check the user create button is enable or not
  void checkUserCreateButton() {
    bool check = nameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        phoneController.text.length == 10;
    if (check != isEnable.value) {
      isEnable.value = check;
    }
  }

  // clear the feild of create user dilaoh
  void clearFeilds() {
    nameController.clear();
    usernameController.clear();
    emailController.clear();
    phoneController.clear();
  }

// create the new user
  void createUser() async {
    try {
      isLoading(true);
      final id = Random().nextInt(1000) + Random().nextInt(1000);
      final response = await _userRepository.createUser(
          phone: phoneController.text,
          username: usernameController.text,
          name: nameController.text,
          email: emailController.text);
      if (response.statusCode == 201) {
        usersList.insert(
            0,
            UserListModel(
              id: id,
              name: nameController.text,
              username: usernameController.text,
              email: emailController.text,
              phone: phoneController.text,
            ));
        isLoading(false);
        Get.snackbar("Success", "User create successfully",
            backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      } else {
        isLoading(false);
        Get.snackbar("Unsuccessful", "Something went wrong",
            backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Unsuccessful", "Something went wrong",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }


  // check update button
  void checkUpdateButton() {
      if (updateNameController.text.isNotEmpty &&
          updateUsernameController.text.isNotEmpty) {
        updateBtn.value = true;
      } else {
        updateBtn.value = false;
      }
    
  }
}
