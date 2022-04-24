import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/data/local/local_storage_controller.dart';
import 'package:flutter_firebase_crud/app/global/constants/constants.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabViewBuild(context),
    );
  }

  Widget _tabViewBuild(BuildContext context) {
    return Obx(() => PersistentTabView(
          context,
          backgroundColor: LocalStorageController.instance.darkTheme
              ? myDarkGreyColor
              : myWhiteColor,
          screens: buildScreens,
          controller: MainController.instance.tabController,
          items: [
            for (var i = 0; i < buildScreens.length; i++)
              PersistentBottomNavBarItem(
                icon: Icon(bottomNavIcon[i],
                    size: 30, color: i == 2 ? myWhiteColor : null),
                title: bottomNavTitle[i],
                activeColorPrimary: myBlueColor,
                inactiveColorPrimary: myGreyColor,
              ),
          ],
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          hideNavigationBarWhenKeyboardShows: true,
          popActionScreens: PopActionScreensType.all,
          bottomScreenMargin: 0.0,
          decoration:
              NavBarDecoration(borderRadius: BorderRadius.circular(0.0)),
          popAllScreensOnTapOfSelectedTab: true,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style15,
        ));
  }
}
