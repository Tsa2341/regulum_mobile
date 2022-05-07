import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:regulum/constants/colors.dart';
import 'package:regulum/constants/themes.dart';
import 'package:regulum/screens/on_board_profile.srcreen.dart';
import 'package:regulum/screens/on_board_sign_in.screen.dart';
import 'package:regulum/utils/validations.util.dart';
import 'package:regulum/widgets/on_board_background_container.widget.dart';

class OnBoardCredentials extends StatefulWidget {
  const OnBoardCredentials({
    Key? key,
  }) : super(key: key);

  static const route = "on_board_credentials_screen";

  @override
  State<OnBoardCredentials> createState() => _OnBoardCredentialsState();
}

class _OnBoardCredentialsState extends State<OnBoardCredentials> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordInputController;
  late final TextEditingController _confirmPasswordInputController;
  late final TextEditingController _emailInputController;

  bool showPassword = false;
  bool showConfirmPassword = false;

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

  @override
  void initState() {
    super.initState();

    _passwordInputController = TextEditingController();
    _confirmPasswordInputController = TextEditingController();
    _emailInputController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordInputController.dispose();
    _confirmPasswordInputController.dispose();
    _emailInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardBackgroundContainer(
      pageTo: OnBoardProfile.route,
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
                          errorMaxLines: 2,
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
                            return "Password must contain altleast one number, capital letter and no space!";
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
                          if (_formKey.currentState!.validate()) {
                            Box userBox = Hive.box('user');
                            userBox.put(
                              'credentials',
                              {"email": _emailInputController.text.toLowerCase(), "password": _confirmPasswordInputController.text},
                            );
                            Navigator.of(context).pushReplacementNamed(OnBoardProfile.route);
                          }
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
                          Navigator.of(context).pushReplacementNamed(OnBoardSignIn.route);
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
