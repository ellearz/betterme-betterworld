import 'package:betterme/appbar_view.dart';
import 'package:betterme/home_cards.dart';
import "package:flutter/material.dart";



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBarView(),
      body: const SafeArea(
      child: Padding (
        padding: EdgeInsets.only(top: 70.0),
        child: HomeCards(),
        ),
      ),
      
        );

  }
}
