import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/controller/image_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<dynamic> imagePickerBottomSheet(BuildContext context, RxString imagePath,
    ImagePickerController imagePickerController) {
  return Get.bottomSheet(
    Container(
      height: 150,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              imagePath.value =
                  await imagePickerController.pickerImage(ImageSource.camera);

              Get.back();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.background),
              child: const Icon(
                Icons.camera,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              imagePath.value =
                  await imagePickerController.pickerImage(ImageSource.gallery);
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.background),
              child: const Icon(
                Icons.image,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.background),
              child: const Icon(
                Icons.play_arrow,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
