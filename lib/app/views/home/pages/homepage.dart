import 'package:billeddeling/app/views/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/fonts.dart';
import '../widgets/image_tile.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        IntroductionTab(),
        const SizedBox(
          height: 10,
        ),
        const AccountStatusTab(),
        const SizedBox(
          height: 5,
        ),
        const ImageBrowserTab(),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class IntroductionTab extends StatelessWidget {
  IntroductionTab({
    Key? key,
  }) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: controller.openProfilePopUp,
          child: const CircleAvatar(
            backgroundColor: navyBlue,
            radius: 25,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Hi, ",
                      style: regularTextStyle,
                    ),
                    TextSpan(
                      text: "Khondakar Afridi",
                      style: semiBoldTextStyle.copyWith(color: red),
                    )
                  ],
                ),
              ),
              Text(
                "Welcome Back!!",
                style: semiBoldTextStyle.copyWith(
                  color: black.withOpacity(.8),
                  height: .95,
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: controller.onSearchButtonClick,
          child: CircleAvatar(
            backgroundColor: red.withOpacity(.1),
            radius: 20,
            child: const Icon(
              Icons.search,
              color: navyBlue,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageBrowserTab extends StatelessWidget {
  const ImageBrowserTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "• Images",
          style: semiBoldTextStyle.copyWith(
            fontSize: 14,
            color: black,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const ImageTile();
          },
        ),
      ],
    );
  }
}

class AccountStatusTab extends StatelessWidget {
  const AccountStatusTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "• Account Status",
          style: semiBoldTextStyle.copyWith(
            fontSize: 14,
            color: black,
          ),
        ),
        SizedBox(
          height: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                "115",
                style: semiBoldTextStyle.copyWith(
                  color: red,
                  fontSize: 30,
                  height: .6,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  "You currently have this many images on Billeddeling!!",
                  style: regularTextStyle.copyWith(
                      height: 1, fontSize: 14, color: black.withOpacity(.6)),
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
