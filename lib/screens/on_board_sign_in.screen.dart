import 'package:flutter/material.dart';
import 'package:regulum/screens/on_board_congratulation.screen.dart';
import 'package:regulum/widgets/on_board_background_container.widget.dart';

class OnBoardSignIn extends StatelessWidget {
  const OnBoardSignIn({Key? key}) : super(key: key);

  static const route = 'on_board_signin_screen';

  @override
  Widget build(BuildContext context) {
    return OnBoardBackgroundContainer(
      child: Container(),
      pageTo: OnBoardCongratulation.route,
    );
  }
}
