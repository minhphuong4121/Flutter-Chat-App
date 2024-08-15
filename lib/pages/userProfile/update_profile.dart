import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/utils/widget/primary_button.dart';

class UserUpdateProfile extends StatelessWidget {
  const UserUpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 40,
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).colorScheme.background),
                        ),
                        Row(
                          children: [
                            Text(
                              "Persional Info",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Name",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "Phuong",
                              prefixIcon: Icon(Icons.person)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Email",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "example@gmail.com",
                              prefixIcon: Icon(Icons.email)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "Phone number",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "0123456789",
                              prefixIcon: Icon(Icons.phone)),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryButton(
                              btnName: "Save",
                              icon: Icons.save,
                              onTap: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
