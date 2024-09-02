import 'package:flutter/material.dart';

class AppBarView extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarView({super.key})
  :preferredSize = Size.fromHeight(56.0);

  @override
  State<AppBarView> createState() => _AppBarViewState();
}

class _AppBarViewState extends State<AppBarView> {

  
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () {
              print("avatar is tapped");
            },
            borderRadius: BorderRadius.circular(50),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/logoB.png'),
            ),
          ),
        ),
        title: Center(
          child: Padding(padding: const EdgeInsets.only(top: 10.0),
          child: Image.asset("assets/logoB.png"),),
        ),
        actions: [
          InkWell(
            onTap: () {
              print("tree pressed");
            },
            child: const Icon(Icons.local_florist_outlined),
          )
        ],
      );
  }
}