import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/features/albums/models/album_list_model.dart';
import 'package:myapp/features/albums/repository/album_repository.dart';

class AlbumController extends GetxController {
  final int userId;
  final AlbumRepository _albumRepository = AlbumRepository();

  var isLoading = false.obs;
  List<AlbumListModel> _albumsList = [];

  AlbumController(this.userId);
  List<AlbumListModel> get albumsList => _albumsList;

  final TextEditingController albumNameController = TextEditingController();
  final TextEditingController createAlbumNameController =
      TextEditingController();

  var checkUpdateButton = false.obs;

  @override
  void onInit() {
    getAlbumsData();
    super.onInit();
  }

// Get the album list from API
  void getAlbumsData() async {
    try {
      isLoading(true);
      final response = await _albumRepository.getAlbumList(userId);
      _albumsList = albumListModelFromJson(jsonEncode(response));
      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
  }

// Get the existing detail of album
  getInitText(String name) {
    albumNameController.text = name;
  }

// update the album based on id
  void updateAlbum(int albumId) async {
    try {
      isLoading(true);
      final response = await _albumRepository.updateAlbum(
          id: albumId, name: albumNameController.text);
      if (response.statusCode == 200) {
        final album =
            _albumsList.firstWhere((element) => element.id == albumId);
        album.title = albumNameController.text;
        isLoading(false);
        Get.snackbar("Success", "Album update successfully",
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

// Delete the album based on id
  void deleteAlbum(int id) async {
    try {
      isLoading(true);
      final response = await _albumRepository.deleteAlbum(id);
      if (response.statusCode == 200) {
        _albumsList.removeWhere((element) => element.id == id);
        isLoading(false);
        Get.snackbar("Success", "Album deleted successfully",
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

// Create the new album
  void createAlbum() async {
    try {
      isLoading(true);
      final id = Random().nextInt(1000) + Random().nextInt(1000);
      final response = await _albumRepository.createAlbum(
          userId: userId, name: createAlbumNameController.text, id: id);
      if (response.statusCode == 201) {
        _albumsList.add(AlbumListModel(
            userId: userId, id: id, title: createAlbumNameController.text));
        isLoading(false);
        Get.snackbar("Success", "Album Create successfully",
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

  // check update and create button
  void checkButton(bool forUpdateAlbum) {
    if (forUpdateAlbum) {
      if (albumNameController.text.isNotEmpty) {
        checkUpdateButton.value = true;
      } else {
        checkUpdateButton.value = false;
      }
    } else {
      if (createAlbumNameController.text.isNotEmpty) {
        checkUpdateButton.value = true;
      } else {
        checkUpdateButton.value = false;
      }
    }
  }
}
