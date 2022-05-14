import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class OnBoardCongratulation extends StatefulWidget {
  const OnBoardCongratulation({Key? key}) : super(key: key);

  static const route = "on_board_congratulation_screen";

  @override
  State<OnBoardCongratulation> createState() => _OnBoardCongratulationState();
}

class _OnBoardCongratulationState extends State<OnBoardCongratulation> {
  Box randomBox = Hive.box("random");

  @override
  void initState() {
    super.initState();

    randomBox.put("initialized", OnBoardCongratulation.route);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
