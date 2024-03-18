// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:login/auth/auth_repository.dart';
import 'package:login/models/comment_model.dart';
import 'package:login/models/register_provider.dart';
import 'package:login/screens/home.dart';
import 'package:login/screens/login.dart';
import 'package:login/screens/verify_account.dart';
import 'package:provider/provider.dart';

enum AuthState { idle, loading, success, error }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  List<CommentModel> _allComments = [];
  List<CommentModel> get allComment => _allComments;

  AuthState _state = AuthState.idle;
  AuthState get state => _state;

  setAuthState(AuthState state) {
    _state = state;
    notifyListeners();
  }

  setComment(List<CommentModel> comment) {
    _allComments = comment;

    notifyListeners();
  }

  void registerLogic(
    String userName,
    String userEmail,
    String userPassword,
    BuildContext context,
  ) async {
    setAuthState(AuthState.loading);
    if (userPassword.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            "Password should be minimum of 6 chars",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      setAuthState(AuthState.error);
      return;
    }

    var response = await _authRepository.signupRepo(
      userName.trim(),
      userEmail.trim(),
      userPassword.trim(),
    );

    setAuthState(AuthState.success);
    if (response!.statusCode == 200 || response.statusCode == 201) {
      print("registration successful");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            "registration successful",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      context.read<RegisterProvider>().setUsername(userName);
      Future.delayed(const Duration(microseconds: 100), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      });

      //take the use to login screen
    } else {
      setAuthState(AuthState.error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            response.data,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    notifyListeners();
  }
//

  void loginLogic(
    String userEmail,
    String userPassword,
    BuildContext context,
  ) async {
    setAuthState(AuthState.loading);

    var response = await _authRepository.signinRepo(
      userEmail.trim(),
      userPassword.trim(),
    );

    setAuthState(AuthState.success);
    if (response!.statusCode == 200 || response.statusCode == 201) {
      print("login successful");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            "Account verified successful",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      Future.delayed(const Duration(microseconds: 100), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
            (route) => false);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (BuildContext context) => ScreenTwo()),
        // );
      });

      //take the use to  screen two
    } else {
      setAuthState(AuthState.error);
      print(response.data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            response.data,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    notifyListeners();
  }

  void verifyOtpLogic(
    String otp,
    String email,
    BuildContext context,
  ) async {
    setAuthState(AuthState.loading);

    var response = await _authRepository.verifyOtpRepo(
      otp.trim(),
      email.trim(),
    );

    setAuthState(AuthState.success);
    if (response!.statusCode == 200 || response.statusCode == 201) {
      print("Login successful");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            "Account verified successful",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      Future.delayed(const Duration(microseconds: 100), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
            (route) => false);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (BuildContext context) => ScreenTwo()),
        // );
      });

      //take the use to  screen two
    } else {
      setAuthState(AuthState.error);
      print(response.data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            response.data,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
      print(response.data);
    }
    notifyListeners();
  }
//

  void resendOtpLogic(
    String email,
    BuildContext context,
  ) async {
    setAuthState(AuthState.loading);

    var response = await _authRepository.resendOtpRepo(
      email.trim(),
    );

    setAuthState(AuthState.success);
    if (response!.statusCode == 200 || response.statusCode == 201) {
      print("===== otp resnt =====");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            "Account verified successful",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      Future.delayed(const Duration(microseconds: 100), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => Verify(
                email: email,
              ),
            ),
            (route) => false);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (BuildContext context) => ScreenTwo()),
        // );
      });

      //take the use to  screen two
    } else {
      setAuthState(AuthState.error);
      print(response.data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            response.data,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    notifyListeners();
  }

//
  void logOut(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
//

  void getComments() async {
    var response = await _authRepository.getComment();

    if (response.statusCode == 200) {
      // print(response.data);
      setComment(response.data!);
    } else {
      print(response.data);
    }
    notifyListeners();
  }
//
}


/*

M V VM

View (Screen)
ViewModel(Controller/logic class)
Service (repository/interracting with the backend/database)


view-----SCREEN -> controller---logic -> auth-repository ====backend/database

response 200/201



 view-----SCREEN <--controller---logic  <---auth-repository (success, error)    <<<< backend


success = {
"name":"yusuf",
"email":"yusuf@gmail.com",
"password":"$2a$08$U8GftDpjsdQBvqN1xoVvzeXbldM2q8ZbtdIxUnf5WWSySMi1FJItK",
"isVerified":false,
"oneSignalId":"",
"phoneNumber":"",
"_id":"65a25b395fa92a1292663e4f","__v":0
}

errro =  "User with same email already exists!"
///
///
///

*/