import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainController extends GetxController {
  static MainController instance=Get.put(MainController());
  PersistentTabController tabController = PersistentTabController();
  final tabIndex = 0.obs;
  final hideNavBar = false.obs;
}
