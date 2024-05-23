import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/common_appbar.dart';
import 'package:myapp/common/common_option_widget.dart';
import 'package:myapp/common/update_detail_dialog.dart';
import 'package:myapp/features/albums/controller/album_controller.dart';
import 'package:myapp/features/photos/screens/photo_lisiting_screen.dart';

class AlbumListingScreen extends StatelessWidget {
  final int userId;
  const AlbumListingScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    AlbumController albumController = Get.put(AlbumController(userId));
    return Scaffold(
        appBar: CommonAppbar(
          title: "Albums",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                albumController.createAlbumNameController.clear();
                return Obx(
                  () => UpdateDetailDialog(
                    enableButton: albumController.checkUpdateButton.value,
                    showTitle: true,
                    title: "Create Album",
                    showSecondFeild: false,
                    onTap: () {
                      albumController.createAlbum();
                      Navigator.pop(context);
                    },
                    onChanged1: (p0) {
                      albumController.checkButton(false);
                    },
                    feild1: "Album Name",
                    controller1: albumController.createAlbumNameController,
                    buttonName: "Create",
                  ),
                );
              },
            );
          },
        ),
        body: Obx(() => albumController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : albumController.albumsList.isEmpty
                ? const Center(
                    child: Text(
                    "No Albums Found",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ))
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            minVerticalPadding: 8,
                            onTap: () {
                              Get.to(() => PhotoListingScreen(
                                  alubumId:
                                      albumController.albumsList[index].id ??
                                          0));
                            },
                            contentPadding: const EdgeInsets.only(left: 16),
                            style: ListTileStyle.list,
                            leading: const Icon(Icons.photo_library_outlined,
                                size: 30),
                            title: Text(
                                albumController.albumsList[index].title ?? "--",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            trailing: CommonOptionWidget(
                              onDelete: () {
                                albumController.deleteAlbum(
                                    albumController.albumsList[index].id ?? 0);
                              },
                              onEdit: () {
                                albumController.getInitText(
                                  albumController.albumsList[index].title ??
                                      "--",
                                );
                                albumController.checkButton(true);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Obx(
                                      () => UpdateDetailDialog(
                                        enableButton: albumController
                                            .checkUpdateButton.value,
                                        showSecondFeild: false,
                                        onChanged1: (p0) {
                                          albumController.checkButton(true);
                                        },
                                        onTap: () {
                                          albumController.updateAlbum(
                                              albumController
                                                      .albumsList[index].id ??
                                                  0);
                                          Navigator.pop(context);
                                        },
                                        feild1: "Album Name",
                                        controller1:
                                            albumController.albumNameController,
                                      ),
                                    );
                                  },
                                );
                              },
                            )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: albumController.albumsList.length)));
  }
}
