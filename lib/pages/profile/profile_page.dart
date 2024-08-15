import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/controller/auth_controller.dart';
import 'package:flutter_my_chat_app/controller/image_picker.dart';
import 'package:flutter_my_chat_app/controller/profile_controller.dart';
import 'package:flutter_my_chat_app/utils/widget/primary_button.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController nameController = TextEditingController(
      text: profileController.currentUser.value.name,
    );
    TextEditingController emailController =
        TextEditingController(text: profileController.currentUser.value.email);
    TextEditingController phoneController = TextEditingController(
        text: profileController.currentUser.value.phoneNumber);
    TextEditingController aboutController =
        TextEditingController(text: profileController.currentUser.value.about);
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              authController.logoutUser();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => isEdit.value
                            ? InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  imagePath.value = await imagePickerController
                                      .pickerImage(ImageSource.gallery);

                                  print("Image Picked" + imagePath.value);
                                },
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: imagePath.value == "" ||
                                          imagePath.value.isEmpty
                                      ? const Icon(Icons.add)
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          child: Image.file(
                                            File(imagePath.value),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              )
                            : Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: profileController.currentUser.value
                                                .profileImage ==
                                            null ||
                                        profileController.currentUser.value
                                                .profileImage ==
                                            ""
                                    ? const Icon(Icons.image)
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: profileController
                                              .currentUser.value.profileImage!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => TextField(
                      controller: nameController,
                      enabled: isEdit.value,
                      decoration: InputDecoration(
                          filled: isEdit.value,
                          labelText: "Name",
                          prefixIcon: const Icon(
                            Icons.person,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => TextField(
                      controller: aboutController,
                      enabled: isEdit.value,
                      decoration: InputDecoration(
                          filled: isEdit.value,
                          labelText: "About",
                          prefixIcon: const Icon(
                            Icons.info,
                          )),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    enabled: false,
                    decoration: InputDecoration(
                        filled: isEdit.value,
                        labelText: "Email",
                        prefixIcon: const Icon(
                          Icons.email,
                        )),
                  ),
                  Obx(
                    () => TextField(
                      controller: phoneController,
                      enabled: isEdit.value,
                      decoration: InputDecoration(
                          filled: isEdit.value,
                          labelText: "Number",
                          prefixIcon: const Icon(
                            Icons.phone,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => isEdit.value
                            ? profileController.isLoading.value
                                ? const CircularProgressIndicator()
                                : PrimaryButton(
                                    btnName: "Save",
                                    icon: Icons.save,
                                    onTap: () async {
                                      await profileController.updateProfile(
                                        imagePath.value != "" ||
                                                imagePath.value.isNotEmpty
                                            ? imagePath.value
                                            : "",
                                        nameController.text,
                                        aboutController.text,
                                        phoneController.text,
                                      );
                                      isEdit.value = false;
                                    },
                                  )
                            : PrimaryButton(
                                btnName: "Edit",
                                icon: Icons.edit,
                                onTap: () {
                                  isEdit.value = true;
                                },
                              ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
