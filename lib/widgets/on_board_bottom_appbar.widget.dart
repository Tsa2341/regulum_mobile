import 'package:flutter/material.dart';
import 'package:regulum/constants/themes.dart';

class OnBoardBottomAppBar extends StatelessWidget {
  final String pageTo;
  final Future<bool> Function()? validateFunc;

  const OnBoardBottomAppBar({
    required this.pageTo,
    this.validateFunc,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("next", style: RegulumThemes.textTheme.bodyText1),
          const SizedBox(width: 13),
          Padding(
            padding: const EdgeInsets.only(right: 11),
            child: GestureDetector(
              onTap: () {
                if (validateFunc != null) {
                  validateFunc!().then((bool value) {
                    value ? Navigator.of(context).pushReplacementNamed(pageTo) : null;
                  });
                  return;
                }

                Navigator.of(context).pushReplacementNamed(pageTo);
              },
              child: const Icon(
                Icons.arrow_circle_right_rounded,
                size: 40,
                color: Color(0xFFFFFF59),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
