import 'package:billeddeling/app/data/constants/animations.dart';
import 'package:billeddeling/app/data/models/user_model.dart';
import 'package:billeddeling/app/routing/routes.dart';
import 'package:billeddeling/app/services/authentication_services.dart';
import 'package:billeddeling/app/shared/widgets/custom_snackbar.dart';
import 'package:billeddeling/app/views/edit_image/edit_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/constants/colors.dart';
import '../../data/constants/fonts.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  var currentHomePageIndex = 0.obs;
  var homePagePageController = PageController(initialPage: 0);
  UserModel user = AuthenticationServices().user!;

  onPageChange(int index) {
    currentHomePageIndex.value = index;
    homePagePageController.animateToPage(
      currentHomePageIndex.value,
      duration: const Duration(
        microseconds: 200,
      ),
      curve: appAnimationCurve,
    );
  }

  Future<void> selectImageSource() {
    return showDialog(
      context: Get.context!,
      barrierColor: Colors.black54,
      builder: (context) {
        return SimpleDialog(
          elevation: 6,
          backgroundColor: white,
          title: GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Billeddeling",
                  style: semiBoldTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Please select an image source',
                  style: regularTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: const [
                  Icon(
                    Icons.storage,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Gallery',
                    style: regularTextStyle,
                  ),
                ],
              ),
              onPressed: () async {
                Get.back();
                Get.to(() => const EditImageScreen());
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: const [
                  Icon(
                    Icons.camera,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Camera',
                    style: regularTextStyle,
                  ),
                ],
              ),
              onPressed: () async {},
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: const [
                  Icon(
                    Icons.close,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Cancel',
                    style: regularTextStyle,
                  ),
                ],
              ),
              onPressed: () async {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> openProfilePopUp() {
    return showDialog(
      context: Get.context!,
      barrierColor: Colors.black54,
      builder: (context) {
        return SimpleDialog(
          elevation: 6,
          backgroundColor: white,
          title: GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: navyBlue,
                  radius: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      user.profilePicUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  user.name,
                  style: semiBoldTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  user.email ?? "",
                  style: regularTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: const [
                  Icon(
                    Icons.storage,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Logout',
                    style: regularTextStyle,
                  ),
                ],
              ),
              onPressed: () async {
                if (await AuthenticationServices().logoutUser()) {
                  Get.offAllNamed(ROUTES.getLoginRoute);
                } else {
                  showCustomSnackbar(
                      title: "Error", message: "Sorry couldn't log you out!");
                }
              },
            ),
          ],
        );
      },
    );
  }

  onSearchButtonClick() {
    Get.toNamed(ROUTES.getSearchScreenRoute);
  }
}
