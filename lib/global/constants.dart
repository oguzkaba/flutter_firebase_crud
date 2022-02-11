import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
const String noEntryOnlineText =
    "There is no entry in your to-do list. "
    "You can create the first entry by clicking the plus button";
const String noEntryOfflineText =
    "   There is no entry in your to-do list. "
    "Check your internet connection to add a new entry";

const String emptyTitleErrorText = "Title can not be empty";
const String emptyContentErrorText = "Content can not be empty";

const String wrongText = "Something went wrong";

const String noChangeWarningText = "No change detected...";
