import 'package:flutter_my_chat_app/pages/auth/auth_page.dart';
import 'package:flutter_my_chat_app/pages/chat/chat_page.dart';
import 'package:flutter_my_chat_app/pages/contact/contact_page.dart';
import 'package:flutter_my_chat_app/pages/home/home_page.dart';
import 'package:flutter_my_chat_app/pages/userProfile/userProfile_page.dart';
import 'package:flutter_my_chat_app/pages/userProfile/update_profile.dart';
import 'package:get/get.dart';

var pagePath = [
  GetPage(
    name: "/authPage",
    page: () => AuthPage(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: "/homePage",
    page: () => HomePage(),
    transition: Transition.leftToRight,
  ),
  // GetPage(
  //   name: "/chatPage",
  //   page: () => ChatPage(),
  //   transition: Transition.leftToRight,
  // ),
  GetPage(
    name: "/contactPage",
    page: () => ContactPage(),
    transition: Transition.leftToRight,
  ),
  // GetPage(
  //   name: "/updateProfilePage",
  //   page: () => UserUpdateProfile(),
  //   transition: Transition.leftToRight,
  // ),
];
