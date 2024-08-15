import 'package:flutter/material.dart';

myTabBar(TabController tabController, BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: TabBar(
      indicatorWeight: 5,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Theme.of(context).colorScheme.primaryContainer,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
      unselectedLabelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      controller: tabController,
      tabs: const [
        Text("Chats"),
        Text("Groups"),
        Text("Calls"),
      ],
    ),
  );
}
