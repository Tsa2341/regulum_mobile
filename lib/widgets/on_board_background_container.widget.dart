import 'package:flutter/material.dart';
import 'package:regulum/constants/themes.dart';
import 'package:regulum/widgets/on_board_bottom_appbar.widget.dart';

class OnBoardBackgroundContainer extends StatelessWidget {
  const OnBoardBackgroundContainer({
    Key? key,
    required this.child,
    required this.pageTo,
    this.validateFunc,
  }) : super(key: key);

  final Widget child;
  final String pageTo;
  final Future<bool> Function()? validateFunc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTextStyle(
        style: DefaultTextStyle.of(context).style,
        child: Scaffold(
          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight - 20,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.35), blurRadius: 20, offset: Offset(0, 10)),
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.07), blurRadius: 4, offset: Offset(0, 4)),
                ],
                color: RegulumThemes.ligthTheme.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: child,
            ),
          ),
          bottomNavigationBar: Hero(
            tag: "Bottom_navigation_bar",
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: Material(
                  child: OnBoardBottomAppBar(
                pageTo: pageTo,
                validateFunc: validateFunc,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
