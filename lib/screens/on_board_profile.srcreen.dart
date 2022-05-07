import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:regulum/constants/themes.dart';
import 'package:regulum/screens/on_board_congratulation.screen.dart';
import 'package:regulum/screens/on_board_credentails.screen.dart';
import 'package:regulum/utils/validations.util.dart';
import 'package:regulum/widgets/on_board_background_container.widget.dart';

class OnBoardProfile extends StatefulWidget {
  const OnBoardProfile({Key? key}) : super(key: key);

  static const route = "on_board_profile_screen";

  @override
  State<OnBoardProfile> createState() => _OnBoardProfileState();
}

class _OnBoardProfileState extends State<OnBoardProfile> {
  final _formKey = GlobalKey<FormState>();
  dynamic _dropDownValue = "Male";

  late final TextEditingController _famNameInputController;
  late final TextEditingController _givNameInputController;
  late final TextEditingController _ageInputController;
  late final TextEditingController _genderInputController;
  late final TextEditingController _countryInputController;
  late final TextEditingController _dateInputController;

  @override
  void initState() {
    super.initState();

    _famNameInputController = TextEditingController();
    _givNameInputController = TextEditingController();
    _ageInputController = TextEditingController();
    _genderInputController = TextEditingController();
    _countryInputController = TextEditingController();
    _dateInputController = TextEditingController();
  }

  @override
  void dispose() {
    _famNameInputController.dispose();
    _givNameInputController.dispose();
    _ageInputController.dispose();
    _genderInputController.dispose();
    _countryInputController.dispose();
    _dateInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardBackgroundContainer(
      pageTo: OnBoardCredentials.route,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 21),
                child: Text(
                  "Additional Informations",
                  style: RegulumThemes.textTheme.headline6!.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 23),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _famNameInputController,
                        cursorWidth: 1,
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          hintText: "Input your Family name",
                          labelText: "Family Name",
                        ),
                        validator: (String? input) {
                          if (!Validations.checkEmpty(input!)) {
                            return "Family Name is required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _givNameInputController,
                        cursorWidth: 1,
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          hintText: "Input your Given name",
                          labelText: "Given Name",
                        ),
                        validator: (String? input) {
                          if (!Validations.checkEmpty(input!)) {
                            return "Given Name is required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _ageInputController,
                              cursorWidth: 1,
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                hintText: "Input your age",
                                labelText: "Age",
                              ),
                              validator: (String? input) {
                                if (!Validations.checkEmpty(input!)) {
                                  return "Age is required";
                                }
                                if (!Validations.checkRange(0, 100, double.parse(input))) {
                                  return "Age id Invalid";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton(
                            value: _dropDownValue,
                            onChanged: (dynamic newValue) {
                              setState(() {
                                _dropDownValue = newValue!;
                              });
                            },
                            dropdownColor: Theme.of(context).colorScheme.secondary,
                            focusColor: Theme.of(context).colorScheme.secondary,
                            style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black),
                            underline: Divider(
                              color: Theme.of(context).colorScheme.secondary,
                              thickness: 2,
                            ),
                            items: <String>["Male", "Female"].map<DropdownMenuItem<String>>(
                              (value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _famNameInputController,
                        cursorWidth: 1,
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          hintText: "Input your Family name",
                          labelText: "Family Name",
                        ),
                        validator: (String? input) {
                          if (!Validations.checkEmpty(input!)) {
                            return "Family Name is required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
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
