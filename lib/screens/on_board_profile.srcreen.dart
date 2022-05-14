import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:regulum/bloc/services/create_user.service.dart';
import 'package:regulum/bloc/services/update_user_service.dart';
import 'package:regulum/constants/colors.dart';
import 'package:regulum/constants/themes.dart';
import 'package:regulum/screens/on_board_credentails.screen.dart';
import 'package:regulum/screens/on_board_sign_in.screen.dart';
import 'package:regulum/utils/validations.util.dart';
import 'package:regulum/widgets/cutom_image_picker.widget.dart';
import 'package:regulum/widgets/on_board_background_container.widget.dart';
import 'package:regulum/widgets/user_result_dialog.widget.dart';

class OnBoardProfile extends StatefulWidget {
  const OnBoardProfile({Key? key}) : super(key: key);

  static const route = "on_board_profile_screen";

  @override
  State<OnBoardProfile> createState() => _OnBoardProfileState();
}

class _OnBoardProfileState extends State<OnBoardProfile> {
  String? _profileImagePath;
  final Box _randomBox = Hive.box('random');
  final Box _userBox = Hive.box("user");

  late final TextEditingController _ageInputController;
  late final TextEditingController _nationalityInputController;
  late final TextEditingController _dateInputController;
  dynamic _dropDownValue = "Male";
  late final TextEditingController _famNameInputController;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _occupationInputController;
  late final TextEditingController _givNameInputController;

  @override
  void dispose() {
    _famNameInputController.dispose();
    _givNameInputController.dispose();
    _ageInputController.dispose();
    _occupationInputController.dispose();
    _nationalityInputController.dispose();
    _dateInputController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _randomBox.put("initialized", OnBoardProfile.route);

    _famNameInputController = TextEditingController();
    _givNameInputController = TextEditingController();
    _ageInputController = TextEditingController();
    _occupationInputController = TextEditingController();
    _nationalityInputController = TextEditingController();
    _dateInputController = TextEditingController();
  }

  void _setProfileImagePath(String? image) {
    setState(() {
      _profileImagePath = image;
    });
  }

  Future<bool> _validateFields() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'family_name': _famNameInputController.text,
        'given_name': _givNameInputController.text,
        'age': _ageInputController.text,
        'nationality': _nationalityInputController.text,
        'image': _profileImagePath,
      };

      dynamic dialogResponse = await showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext contextDialog, __, ___) {
          return UserResultDialog(title: "Updated Profile", serviceFunction: updateUser, userData: userData);
        },
      );

      log(dialogResponse.toString());

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 21),
                child: Text(
                  "Additional Informations",
                  style: RegulumThemes.textTheme.headline6!.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
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
                        controller: _nationalityInputController,
                        cursorWidth: 1,
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          hintText: "Input your nationality",
                          labelText: "nationality",
                        ),
                        validator: (String? input) {
                          if (!Validations.checkEmpty(input!)) {
                            return "nationality is required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _dateInputController,
                        cursorWidth: 1,
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          hintText: "Click to choose your Birthday",
                          labelText: "Date of Birth",
                        ),
                        enableInteractiveSelection: false,
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1922),
                            lastDate: DateTime.now(),
                            useRootNavigator: false,
                            initialEntryMode: DatePickerEntryMode.input,
                          ).then((DateTime? value) {
                            _dateInputController.text = '${value!.day}/${value.month}/${value.year}';
                          });
                        },
                        validator: (String? input) {
                          if (!Validations.checkEmpty(input!)) {
                            return "Date of Birth is required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.streetAddress,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomImagePicker(_profileImagePath, _setProfileImagePath),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
