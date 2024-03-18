import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:login/auth/auth_view_model.dart';
import 'package:login/common_widgets/common_btn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class Verify extends StatefulWidget {
  final String? email;
  const Verify({
    super.key,
    this.email,
  });

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final TextEditingController pinController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  String currentText = '';

  @override
  Widget build(BuildContext context) {
    log("email from login:${widget.email}");
    final authProviderWatch = context.watch<AuthViewModel>();
    final authProvider = context.read<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Center(
                child: Text(
                  'Verify Your Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  'Enter your otp code to  verify your account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    inactiveColor: Colors.blue,
                    inactiveFillColor: Colors.white,
                    selectedColor: Colors.grey.withOpacity(0.5),
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: pinController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              CommonButton(
                btnName: authProviderWatch.state == AuthState.loading
                    ? 'PLEASE WAIT ...'
                    : 'VERIFY',
                textColor: Colors.white,
                btnColor: Colors.blue,
                onPressed: () {
                  log("pinController.text:${pinController.text}");
                  authProvider.verifyOtpLogic(
                    pinController.text,
                    widget.email!,
                    context,
                  );
                  pinController.clear();

                  // authProvider.loginLogic(
                  //   pinController.text,
                  //   context,
                  // );
                  // pinController.clear();
                  // passwordController.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
