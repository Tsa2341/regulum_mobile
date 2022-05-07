import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';

import 'package:regulum/constants/themes.dart';
import 'package:regulum/utils/custom_scroll_physic.dart';

class ListWheelScrollXWidget extends StatelessWidget {
  const ListWheelScrollXWidget({
    required this.pages,
    required this.allowScroll,
    this.height = 506,
    this.scrollController,
    Key? key,
  }) : super(key: key);

  final bool allowScroll;
  final double height;
  final List<Widget> pages;
  final FixedExtentScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("rotated box 1");
      },
      child: RotatedBox(
        quarterTurns: -1,
        child: GestureDetector(
          onTap: () {
            log("Wheell scrollinside clicked");
          },
          child: ClickableListWheelScrollView(
            scrollController: scrollController as FixedExtentScrollController,
            itemHeight: MediaQuery.of(context).size.width - 50,
            itemCount: pages.length,
            scrollOnTap: false,
            onItemTapCallback: (index) {
              log("Page $index inside clickable wheel scroll runned");
            },
            child: ListWheelScrollView(
              controller: scrollController,
              clipBehavior: Clip.none,
              diameterRatio: 2,
              perspective: 0.002,
              physics: allowScroll
                  ? const AlwaysScrollableScrollPhysics(parent: CustomScrollPhysic(parent: ScrollPhysics()))
                  : const NeverScrollableScrollPhysics(),
              itemExtent: MediaQuery.of(context).size.width - 50,
              children: pages.map((page) {
                return GestureDetector(
                  onTap: () {
                    log("page inside wheel runned");
                  },
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Center(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: height,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.35), blurRadius: 20, offset: Offset(0, 10)),
                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.07), blurRadius: 4, offset: Offset(0, 4)),
                          ],
                          color: RegulumThemes.ligthTheme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: page,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
