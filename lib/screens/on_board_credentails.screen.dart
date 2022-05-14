import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:regulum/bloc/services/create_user.service.dart';
import 'package:regulum/bloc/user.bloc.dart';
import 'package:regulum/constants/colors.dart';
import 'package:regulum/constants/themes.dart';
import 'package:regulum/screens/on_board_profile.srcreen.dart';
import 'package:regulum/screens/on_board_sign_in.screen.dart';
import 'package:regulum/utils/validations.util.dart';
import 'package:regulum/widgets/on_board_background_container.widget.dart';
import 'package:regulum/widgets/user_result_dialog.widget.dart';

class OnBoardCredentials extends StatefulWidget {
  const OnBoardCredentials({
    Key? key,
  }) : super(key: key);

  static const route = "on_board_credentials_screen";

  @override
  State<OnBoardCredentials> createState() => _OnBoardCredentialsState();
}

class _OnBoardCredentialsState extends State<OnBoardCredentials> {
  final Box _randomBox = Hive.box('random');
  final _formKey = GlobalKey<FormState>();
  bool showConfirmPassword = false;
  bool showPassword = false;

  late final TextEditingController _confirmPasswordInputController;
  late final TextEditingController _emailInputController;
  late final TextEditingController _passwordInputController;

  @override
  void dispose() {
    _passwordInputController.dispose();
    _confirmPasswordInputController.dispose();
    _emailInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _randomBox.put("initialized", OnBoardCredentials.route);

    _passwordInputController = TextEditingController();
    _confirmPasswordInputController = TextEditingController();
    _emailInputController = TextEditingController();
  }

  void setShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void setShowConfirmPassword() {
    setState(() {
      showConfirmPassword = !showConfirmPassword;
    });
  }

  Future<bool> _validateFields() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        "email": _emailInputController.text.toLowerCase(),
        "password": _confirmPasswordInputController.text,
      };

      bool dialogResponse = await showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext contextDialog, __, ___) {
          return UserResultDialog(
            userData: userData,
            title: "Registered successfully",
            serviceFunction: createUser,
          );
        },
      ) as bool;

      if (dialogResponse) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardBackgroundContainer(
      pageTo: OnBoardLogin.route,
      validateFunc: _validateFields,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 21),
                child: Text(
                  "Sign up to get started",
                  style: RegulumThemes.textTheme.headline6!.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/images/signup_image.jpg",
                  fit: BoxFit.cover,
                  frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: child,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailInputController,
                        cursorWidth: 1,
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          hintText: "Input your email here",
                          labelText: "Email",
                        ),
                        validator: (String? input) {
                          if (!Validations.checkEmpty(input!)) {
                            return "Email is required!";
                          }
                          if (!Validations.checkEmail(input)) {
                            return "Invalid Email address!";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordInputController,
                        cursorWidth: 1,
                        obscureText: showPassword ? false : true,
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: "Altleast one number, capital letter and no space",
                          labelText: "Password",
                          hintStyle: const TextStyle(fontSize: 10),
                          errorMaxLines: 3,
                          suffix: GestureDetector(
                            onTap: setShowPassword,
                            child: Text(showPassword ? "Hide" : "Show"),
                          ),
                        ),
                        validator: (String? input) {
                          if (!Validations.checkEmpty(input!)) {
                            return "Password is required";
                          }
                          if (!Validations.checkPassword(input)) {
                            return "Password must contain altleast one number, capital letter, no space and no special characters!";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordInputController,
                        cursorWidth: 1,
                        obscureText: showConfirmPassword ? false : true,
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: "Password must match",
                          labelText: "Confirm Password",
                          suffix: GestureDetector(
                            onTap: setShowConfirmPassword,
                            child: Text(showConfirmPassword ? "Hide" : "Show"),
                          ),
                        ),
                        validator: (String? input) {
                          if (!Validations.checkEmpty(input!)) {
                            return "Confirm Password is required";
                          }
                          if (!Validations.checkConfirmedPassword(_passwordInputController.text, input)) {
                            return "Password must match";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.visiblePassword,
                        onFieldSubmitted: (String? input) {
                          _validateFields().then((bool value) {
                            value ? Navigator.of(context).pushReplacementNamed(OnBoardProfile.route) : null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    text: "Already registered?",
                    style: Theme.of(context).textTheme.bodyText1!,
                    children: [
                      TextSpan(
                        text: "   sign in",
                        onEnter: (_) {
                          Navigator.of(context).pushReplacementNamed(OnBoardLogin.route);
                        },
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: RegulumColors.secondaryDark),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
