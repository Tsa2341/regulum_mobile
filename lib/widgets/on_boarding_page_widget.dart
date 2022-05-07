import 'dart:developer';

import 'package:flutter/material.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      log("runned inner");
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(),
        child: Container(
          width: 100,
          height: 300,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Text("Hello acreesns"),
        ),
      );
    });
  }
}
