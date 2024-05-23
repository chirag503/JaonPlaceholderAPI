import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/common_appbar.dart';
import 'package:myapp/features/photos/controller/photo_controller.dart';
import 'package:myapp/features/photos/widgets/photo_card.dart';
import 'package:myapp/features/photos/widgets/upload_photo_dialog.dart';

class PhotoListingScreen extends StatelessWidget {
  final int alubumId;
  const PhotoListingScreen({super.key, required this.alubumId});

  @override
  Widget build(BuildContext context) {
    PhotoController photoController = Get.put(PhotoController(alubumId));
    return Scaffold(
        appBar: CommonAppbar(
          title: "Photos",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => UploadPhotoDialog(
                onUpload: () {
                  photoController.pickFile();
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
        body: Obx(() => photoController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : photoController.photosList.isEmpty
                ? const Center(
                    child: Text(
                    "No Photos Found",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ))
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return PhotoCard(
                        item: photoController.photosList[index],
                        onTap: () {
                          photoController.deletePhoto(
                              photoController.photosList[index].id ?? 0);
                        },
                      );
                    },
                    itemCount: photoController.photosList.length)));
  }
}

