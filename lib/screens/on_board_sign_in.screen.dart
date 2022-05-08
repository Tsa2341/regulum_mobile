import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:regulum/screens/on_board_congratulation.screen.dart';
import 'package:regulum/widgets/on_board_background_container.widget.dart';

class OnBoardSignIn extends StatefulWidget {
  const OnBoardSignIn({Key? key}) : super(key: key);

  static const route = 'on_board_signin_screen';

  @override
  State<OnBoardSignIn> createState() => _OnBoardSignInState();
}

class _OnBoardSignInState extends State<OnBoardSignIn> {
  Box randomBox = Hive.box("random");

  @override
  void initState() {
    super.initState();

    randomBox.put("initialized", 4);
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardBackgroundContainer(
      child: Container(),
      pageTo: OnBoardCongratulation.route,
    );
  }
}
