import 'package:flutter/material.dart';
import 'package:regulum/constants/themes.dart';
import 'package:regulum/screens/on_board_credentails.screen.dart';
import 'package:regulum/widgets/on_board_background_container.widget.dart';

class OnBoardHome extends StatelessWidget {
  const OnBoardHome({Key? key}) : super(key: key);

  static const route = "on_board_home_screen";

  @override
  Widget build(BuildContext context) {
    return OnBoardBackgroundContainer(
      pageTo: OnBoardCredentials.route,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/regulum-logo.jpg',
              fit: BoxFit.cover,
              width: 150,
              frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
                    clipBehavior: Clip.hardEdge,
                    child: child,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Regulum",
              style: RegulumThemes.textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w300,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
