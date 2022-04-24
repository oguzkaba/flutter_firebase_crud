import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';
import 'package:flutter_firebase_crud/app/modules/intro/controllers/intro_controller.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroView extends GetView<IntroController> {
  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: introSlides,
      onDonePress: controller.completeIntro,
      onSkipPress: controller.completeIntro,
      showSkipBtn: true,
      isScrollable: true,
      nextButtonStyle: myButtonStyle(myDarkGreyColor),
      doneButtonStyle: myButtonStyle(myGreenColor),
      skipButtonStyle: myButtonStyle(myRedColor),
    );
  }

  ButtonStyle myButtonStyle(Color buttonColor) {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
      overlayColor: MaterialStateProperty.all<Color>(buttonColor),
    );
  }
}
