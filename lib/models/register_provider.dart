import 'package:flutter/material.dart';
import 'package:login/screens/home.dart';
import 'package:login/screens/login.dart';

enum RegisterState { idle, loading, success, error }

class RegisterProvider extends ChangeNotifier {
  String _username = '';
  String get username => _username;

  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  RegisterState _state = RegisterState.idle;
  RegisterState get state => _state;

  bool _isVisibility = true;
  bool get isVisibility => _isVisibility;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  setRegisterState(RegisterState state) {
    _state = state;
    notifyListeners();
  }

  void togglePassword() {
    _isVisibility = !_isVisibility;
    notifyListeners();
  }

  void register(
    String userName,
    String userEmail,
    String userPassword,
    BuildContext context,
  ) {
    setRegisterState(RegisterState.loading);
    _username = userName.trim();
    _email = userEmail.trim();
    _password = userPassword.trim();

    Future.delayed(const Duration(seconds: 3), () {
      if (userPassword.length >= 6) {
        setRegisterState(RegisterState.success);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        setRegisterState(RegisterState.error);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.grey,
            content: Text(
              "Password not valid ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    });
    notifyListeners();
  }

  // void save(String usernameInput, String emailInput, String passwordInput,
  //     String confirmPasswordInput, context) {
  //   setRegisterState(RegisterState.loading);

  //   if (usernameInput.length < 4) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.grey,
  //         content: Text(
  //           'Username must have at least 4 characters',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(color: Colors.red),
  //         ),
  //       ),
  //     );
  //   } else if (passwordInput != confirmPasswordInput) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.grey,
  //         content: Text(
  //           'Password and Confirm Password do not match',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(color: Colors.red),
  //         ),
  //       ),
  //     );
  //   } else if (passwordInput.length < 6) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.grey,
  //         content: Text(
  //           'Password must have at least 6 characters',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(color: Colors.red),
  //         ),
  //       ),
  //     );
  //   }

  //   Future.delayed(const Duration(seconds: 4), () {
  //     _username = usernameInput.trim();

  //     _email = emailInput.trim();

  //     _password = passwordInput.trim();

  //     setRegisterState(RegisterState.success);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Login(),
  //       ),
  //     );
  //   });
  //   notifyListeners();
  // }

  void login(String emailInput, String passwordInput, context) {
    setRegisterState(RegisterState.loading);

    Future.delayed(const Duration(seconds: 3), () {
      if (_email == emailInput.trim() && password == passwordInput.trim()) {
        setRegisterState(RegisterState.success);
        // _username = username;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.grey,
            content: Text(
              "Invalid email or password",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        setRegisterState(RegisterState.error);
      }
    });

    notifyListeners();
  }
}
