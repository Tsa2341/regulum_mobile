import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regulum/constants/colors.dart';
import 'package:regulum/constants/themes.dart';

class UserResultDialog extends StatefulWidget {
  const UserResultDialog({
    required this.userData,
    required this.serviceFunction,
    required this.title,
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> userData;
  final dynamic Function(Map<String, dynamic>) serviceFunction;
  final String title;

  @override
  State<UserResultDialog> createState() => _UserResultDialogState();
}

class _UserResultDialogState extends State<UserResultDialog> {
  dynamic willPop = false; // controls (enable or disable) mobile back button
  dynamic _registerUserResponse;

  void _setRegisterUserResponse(Map<String, dynamic> userData) async {
    try {
      _registerUserResponse = await widget.serviceFunction(userData);
      log(" in _setRegisterResponse $_registerUserResponse");
      willPop = _registerUserResponse['status'] == true ? false : true;
    } catch (e) {
      _registerUserResponse = e;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _setRegisterUserResponse(widget.userData);
  }

  @override
  Widget build(BuildContext context) {
    if (_registerUserResponse != null) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context, rootNavigator: true).pop(_registerUserResponse['status'] == true ? true : false);
      });
    }

    return WillPopScope(
      onWillPop: () async => willPop,
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
        child: Center(
          child: Container(
            width: 277,
            height: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: RegulumColors.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: _registerUserResponse == null
                ? const SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 7,
                      color: RegulumColors.secondary,
                      backgroundColor: Colors.black45,
                    ),
                  )
                : ListView(
                    shrinkWrap: true,
                    children: [
                      Center(
                        child: FittedBox(
                          child: Text(
                            _registerUserResponse['status'] == true ? widget.title : "Error!",
                            style: RegulumThemes.textTheme.headline6?.copyWith(
                              color: _registerUserResponse['status'] == true ? RegulumColors.secondaryDark : RegulumColors.error,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          _registerUserResponse['status'] != true ? 'assets/images/error_image.jpg' : 'assets/images/success_image.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                        child: Text(
                          _registerUserResponse['message'].toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
