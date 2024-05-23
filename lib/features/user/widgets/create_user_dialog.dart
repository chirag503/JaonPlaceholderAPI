import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/common/update_detail_dialog.dart';
import 'package:myapp/features/user/controller/user_controller.dart';

class CreateUserDialog extends StatelessWidget {
  const CreateUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      actionsPadding: const EdgeInsets.only(right: 14, bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Create User",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 15,
            ),
            DetailCard(
              title: "Name",
              hintText: "Enter the name",
              controller: userController.nameController,
              onChanged: (v) {
                userController.checkUserCreateButton();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DetailCard(
              title: "Username",
              hintText: "Enter the username",
              controller: userController.usernameController,
              onChanged: (v) {
                userController.checkUserCreateButton();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DetailCard(
              title: "Email",
              hintText: "Enter the email address",
              controller: userController.emailController,
              onChanged: (v) {
                userController.checkUserCreateButton();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DetailCard(
              maxLength: 10,
              hintText: "Enter the phone number",
              title: "Phone",
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: userController.phoneController,
              onChanged: (v) {
                userController.checkUserCreateButton();
              },
            ),
          ],
        ),
      ),
      actions: [
        Obx(() => GestureDetector(
              onTap: userController.isEnable.value
                  ? () {
                      userController.createUser();
                      Navigator.pop(context);
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                    color: userController.isEnable.value
                        ? Colors.black
                        : Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Text(
                  "Create User",
                  style: TextStyle(
                      fontSize: 15,
                      color: userController.isEnable.value
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ))
      ],
    );
  }
}
