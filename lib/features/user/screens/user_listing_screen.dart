import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/common_appbar.dart';
import 'package:myapp/common/common_option_widget.dart';
import 'package:myapp/common/update_detail_dialog.dart';
import 'package:myapp/features/albums/screens/album_listing_screen.dart';
import 'package:myapp/features/content_delivery/screens/content_delivery_screen.dart';
import 'package:myapp/features/user/controller/user_controller.dart';
import 'package:myapp/features/user/widgets/create_user_dialog.dart';

class UserListingScreen extends StatelessWidget {
  const UserListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return Scaffold(
        appBar: CommonAppbar(
          title: "Users",
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const ContentDeliveryScreen());
                },
                icon: const Icon(
                  Icons.local_shipping_outlined,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  userController.clearFeilds();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CreateUserDialog();
                    },
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: Obx(() => userController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : userController.usersList.isEmpty
                ? const Center(
                    child: Text(
                    "No Users Found",
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
                              Get.to(() => AlbumListingScreen(
                                    userId:
                                        userController.usersList[index].id ?? 0,
                                  ));
                            },
                            contentPadding: const EdgeInsets.only(left: 8),
                            style: ListTileStyle.list,
                            leading: const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blueGrey,
                              foregroundColor: Colors.white,
                              child: Icon(Icons.person_3, size: 30),
                            ),
                            title: Text(
                                userController.usersList[index].name ?? "--",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            subtitle: Text(
                                userController.usersList[index].username ??
                                    "--",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                            trailing: CommonOptionWidget(
                              onEdit: () {
                                userController.getInitText(
                                  userController.usersList[index].name ?? "--",
                                  userController.usersList[index].username ??
                                      "--",
                                );
                                userController.checkUpdateButton();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Obx(
                                      () => UpdateDetailDialog(
                                        onTap: () {
                                          userController.updateUser(
                                              userController
                                                      .usersList[index].id ??
                                                  0);
                                          Navigator.pop(context);
                                        },
                                        onChanged1: (v) {
                                          userController.checkUpdateButton();
                                        },
                                        onChanged2: (p0) {
                                          userController.checkUpdateButton();
                                        },
                                        feild1: "Namw",
                                        feild2: "Username",
                                        controller1:
                                            userController.updateNameController,
                                        controller2: userController
                                            .updateUsernameController,
                                        enableButton:
                                            userController.updateBtn.value,
                                      ),
                                    );
                                  },
                                );
                              },
                              onDelete: () {
                                userController.deleteUser(
                                    userController.usersList[index].id ?? 0);
                              },
                            )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: userController.usersList.length)));
  }
}
