import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app/modules/add_todo/views/add_todo_view.dart';
import 'package:flutter_firebase_crud/app/modules/history/views/history_view.dart';
import 'package:flutter_firebase_crud/app/modules/home/views/home_view.dart';
import 'package:flutter_firebase_crud/app/modules/profile/views/profile_view.dart';
import 'package:flutter_firebase_crud/app/modules/reports/views/reports_view.dart';
import 'package:get/get.dart';
import 'package:intro_slider/slide_object.dart';

///
///Firebase Database
///
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
late CollectionReference collectionReference;

///
///Constant variables
///
//Color

const Color myWhiteColor = Color(0xffffffff);
const Color myBlueColor = Color(0xFF0F6299);
const Color myDarkGreyColor = Color(0xff2c2c2c);
const Color myGreyColor = Color(0xFFBEBEBE);
const Color myCardColor = Color(0xFFE9E9E9);
const Color myRedColor = Color(0xFFAA2929);
const Color myGreenColor = Color(0xFF29AA79);

///Warning Text
///
const String noEntryOnlineText = "There is no entry in your to-do list. "
    "You can create the first entry by clicking the plus button";
const String noEntryOfflineText = "   There is no entry in your to-do list. "
    "Check your internet connection to add a new entry";

const String emptyTitleErrorText = "Title can not be empty";
const String emptyContentErrorText = "Content can not be empty";

const String wrongText = "Something went wrong";

const String noChangeWarningText = "No change detected...";

///Slide
///
const List<String> introImageList = [
  "assets/images/intro/intro_1.jpg",
  "assets/images/intro/intro_2.jpg"
];

final List<Slide> introSlides = [
  Slide(
    title: "TODO-Intro 1",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        " Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    pathImage: introImageList[0],
    heightImage: Get.height / 2,
    backgroundColor: myWhiteColor,
    styleTitle: TextStyle(color: myDarkGreyColor, fontSize: 30),
    styleDescription: TextStyle(color: myDarkGreyColor, fontSize: 16),
  ),
  Slide(
    title: "TODO-Intro 1",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        " Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    pathImage: introImageList[1],
    heightImage: Get.height / 2,
    backgroundColor: myWhiteColor,
    styleTitle: TextStyle(color: myDarkGreyColor, fontSize: 30),
    styleDescription: TextStyle(color: myDarkGreyColor, fontSize: 16),
  ),
];

///BottomNavigationBar
///
final List<Widget> buildScreens = [
  HomeView(),
  HistoryView(),
  AddTodoView(),
  ReportsView(),
  ProfileView(),
];

final List<IconData> bottomNavIcon = [
  Icons.home,
  Icons.history,
  Icons.add,
  Icons.assessment_outlined,
  Icons.person
];

final List<String> bottomNavTitle = [
  "Home",
  "History",
  "Add",
  "Report",
  "Profile"
];

/// To-do
///
final List<String> todoCategories = [
  "Sport",
  "Payment",
  "Home",
  "Family",
  "Bank",
  "Special",
  "Business",
  "Other"
];
