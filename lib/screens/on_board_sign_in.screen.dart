import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:regulum/bloc/services/login_user.service.dart';
import 'package:regulum/constants/colors.dart';
import 'package:regulum/constants/themes.dart';
import 'package:regulum/screens/on_board_congratulation.screen.dart';
import 'package:regulum/screens/on_board_profile.srcreen.dart';
import 'package:regulum/utils/validations.util.dart';
import 'package:regulum/widgets/on_board_background_container.widget.dart';
import 'package:regulum/widgets/user_result_dialog.widget.dart';

class OnBoardLogin extends StatefulWidget {
  const OnBoardLogin({Key? key}) : super(key: key);

  static const route = 'on_board_login_screen';

  @override
  State<OnBoardLogin> createState() => _OnBoardLoginState();
}

class _OnBoardLoginState extends State<OnBoardLogin> {
  final Box _randomBox = Hive.box('random');
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  late final TextEditingController _emailInputController;
  late final TextEditingController _passwordInputController;

  @override
  void dispose() {
    _passwordInputController.dispose();
    _emailInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _randomBox.put("initialized", OnBoardLogin.route);

    _passwordInputController = TextEditingController();
    _emailInputController = TextEditingController();
  }

  void setShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Future<bool> _validateFields() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        "email": _emailInputController.text.toLowerCase(),
        "password": _passwordInputController.text,
      };

      bool dialogResponse = await showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext contextDialog, __, ___) {
          return UserResultDialog(
            userData: userData,
            title: "Logged in successfully",
            serviceFunction: loginUser,
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
      pageTo: OnBoardProfile.route,
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    text: "Not registered?",
                    style: Theme.of(context).textTheme.bodyText1!,
                    children: [
                      TextSpan(
                        text: "   register",
                        onEnter: (_) {
                          Navigator.of(context).pushReplacementNamed(OnBoardLogin.route);
                        },
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: RegulumColors.secondaryDark,
                            ),
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
