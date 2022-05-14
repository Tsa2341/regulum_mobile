abstract class Validations {
  static bool checkEmpty(String input) {
    final value = input.trim();
    if (value.isEmpty) {
      return false;
    }

    return true;
  }

  static bool checkRange(double begin, double end, double input) {
    if (input < begin || input > end) {
      return false;
    }

    return true;
  }

  static bool checkEmail(String input) {
    final value = input.trim();
    if (!RegExp(
            r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return false;
    }

    return true;
  }

  static bool checkPassword(String input) {
    if (!RegExp(r'^(?=.*[0-9])(?=.*[A-Z])(?!.*[ \t\n\r]+)(\w){8,}$').hasMatch(input)) {
      return false;
    }

    return true;
  }

  static bool checkConfirmedPassword(String password, String input) {
    if (password != input) {
      return false;
    }

    return true;
  }
}
