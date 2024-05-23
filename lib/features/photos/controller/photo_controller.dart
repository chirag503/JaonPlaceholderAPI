import 'dart:convert';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/features/photos/models/photo_listing_model.dart';
import 'package:myapp/features/photos/repository/photo_repository.dart';

class PhotoController extends GetxController {
  final int alubumId;
  final PhotoRepository _photoRepository = PhotoRepository();

  var isLoading = false.obs;
  List<PhotoListModel> _photosList = [];

  PhotoController(this.alubumId);
  List<PhotoListModel> get photosList => _photosList;

  PlatformFile? pickedImage;

  @override
  void onInit() {
    getPhotosData();
    super.onInit();
  }

// Get the photo list from API
  void getPhotosData() async {
    try {
      isLoading(true);
      final response = await _photoRepository.getPhotoList(alubumId);
      _photosList = photoListModelFromJson(jsonEncode(response));
      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
  }

// Delete the photo based on id
  void deletePhoto(int photoId) async {
    try {
      isLoading(true);
      final response = await _photoRepository.deletePhoto(photoId);
      if (response.statusCode == 200) {
        _photosList.removeWhere((element) => element.id == photoId);
        isLoading(false);
        Get.snackbar("Success", "Photo deleted successfully",
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

  // Pick the image file from gallery
  void pickFile() async {
    try {
      final res = await FilePicker.platform.pickFiles(type: FileType.image);
      if (res != null) {
        pickedImage = res.files.first;
        uploadPhoto();
      }
    } catch (e) {
      Get.snackbar("Unsuccessful", "Something went wrong",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Upload the new photo
  void uploadPhoto() async {
    try {
      isLoading(true);
      final id = Random().nextInt(1000) + Random().nextInt(1000);
      final response = await _photoRepository.uploadPhoto(
          title: pickedImage?.name ?? "",
          albumId: alubumId,
          id: id,
          file: pickedImage?.bytes ?? []);
      if (response.statusCode == 201) {
        _photosList.insert(
            0,
            PhotoListModel(
                albumId: alubumId,
                id: id,
                title: pickedImage?.name ?? "",
                url: pickedImage?.path,
                thumbnailUrl: pickedImage?.path));
        isLoading(false);
        Get.snackbar("Success", "Photo upload successfully",
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
}
