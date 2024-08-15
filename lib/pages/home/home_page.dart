import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/config/string.dart';
import 'package:flutter_my_chat_app/controller/contact_controller.dart';
import 'package:flutter_my_chat_app/controller/image_picker.dart';
import 'package:flutter_my_chat_app/controller/profile_controller.dart';
import 'package:flutter_my_chat_app/controller/status_controller.dart';
import 'package:flutter_my_chat_app/pages/call/call_history/call_history_page.dart';
import 'package:flutter_my_chat_app/pages/group/group_page.dart';
import 'package:flutter_my_chat_app/pages/home/widget/chat_list.dart';
import 'package:flutter_my_chat_app/pages/home/widget/tabBar.dart';
import 'package:flutter_my_chat_app/pages/profile/profile_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    TabController tabController = TabController(length: 3, vsync: this);
    ContactController contactController = Get.put(ContactController());
    StatusController statusController = Get.put(StatusController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text(
            AppString.appName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          leading: SvgPicture.asset(
            AssetsImage.appIconSVG,
            width: 10,
          ),
          actions: [
            IconButton(
              onPressed: () {
                contactController.getChatRoomList();
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () async {
                // Get.toNamed("/profilePage");
                await profileController.getUserDetails();
                Get.to(() => ProfilePage());
              },
              icon: const Icon(Icons.more_vert),
            )
          ],
          bottom: myTabBar(tabController, context),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/contactPage");
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            controller: tabController,
            children: const [
              ChatList(),
              GroupPage(),
              CallHistoryPage(),
            ],
          ),
        ));
  }
}
