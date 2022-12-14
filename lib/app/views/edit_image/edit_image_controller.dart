import 'dart:typed_data';

import 'package:billeddeling/app/data/models/post_model.dart';
import 'package:billeddeling/app/services/image_services.dart';
import 'package:billeddeling/app/shared/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../home/home_controller.dart';

class EditImageScreenController extends GetxController {
  late Uint8List? image;
  late PostModel? postModel;
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  var isUploadButtonLoading = false.obs;
  var selectedDate = "Select Date: ".obs;

  Future selectDate() async {
    var eventDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1998),
      lastDate: DateTime.now(),
    );
    if (eventDate != null) {
      selectedDate.value = DateFormat.yMMMd().format(eventDate);
      dateTextEditingController.text = selectedDate.value;
    }
  }

  selectDateAsToday() {
    selectedDate.value = DateFormat.yMMMd().format(DateTime.now());
    dateTextEditingController.text = selectedDate.value;
  }

  Future onUploadButtonClick() async {
    isUploadButtonLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if (selectedDate.value != "Select Date: " &&
        titleTextEditingController.text.isNotEmpty &&
        image != null) {
      await ImageServices().uploadPost(
        image!,
        titleTextEditingController.text,
        dateTextEditingController.text,
      );

      final HomeController homeController = Get.find();
      await homeController.updateUserModel();
      Get.back();
      showCustomSnackbar(
        title: "Congratulations",
        message: "Your image is now on Billeddeling!",
      );
    } else {
      showCustomSnackbar(
        title: "Alert",
        message:
            "You need to add a title and a time stamp to the image, in order to upload it!",
        isWarning: true,
      );
    }
    isUploadButtonLoading.value = false;
  }

  Future onUpdateButtonClick() async {
    isUploadButtonLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if (selectedDate.value != "Select Date: " &&
        titleTextEditingController.text.isNotEmpty) {
      await ImageServices().updatePost(
        postModel!.postId,
        titleTextEditingController.text,
        dateTextEditingController.text,
      );
      Get.back();
      showCustomSnackbar(
        title: "Updated!",
        message: "Your post has been updated. :)",
      );
    } else {
      showCustomSnackbar(
        title: "Alert",
        message: "Title and Date cannot be empty!",
        isWarning: true,
      );
    }
    isUploadButtonLoading.value = false;
  }
}
