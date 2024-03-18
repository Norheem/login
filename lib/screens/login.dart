import 'package:flutter/material.dart';
import 'package:login/auth/auth_view_model.dart';
import 'package:login/common_widgets/common_btn.dart';
import 'package:login/common_widgets/common_textfield.dart';
import 'package:login/models/register_provider.dart';
import 'package:login/screens/register.dart';
import 'package:login/screens/verify_account.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final String? userIputName;
  Login({
    super.key,
    this.userIputName,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<RegisterProvider>();
    final providerRead = context.read<RegisterProvider>();
    final authProvider = context.read<AuthViewModel>();
    final authProviderWatch = context.watch<AuthViewModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Login to your account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  elevation: 10,
                  child: Container(
                    width: 360,
                    height: 60,
                    color: Colors.white,
                    child: CommonTextField(
                      label: 'Email',
                      controller: emailController,
                      prefix: const Icon(Icons.mail_outline_outlined),
                      hint: '',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  elevation: 10,
                  child: Container(
                    width: 360,
                    height: 60,
                    color: Colors.white,
                    child: CommonTextField(
                      hint: '',
                      controller: passwordController,
                      label: 'Enter Password',
                      visibility: providerWatch.isVisibility,
                      prefix: const Icon(Icons.lock_open_outlined),
                      suffix: IconButton(
                          onPressed: () {
                            providerRead.togglePassword();
                          },
                          icon: Icon(
                            providerWatch.isVisibility
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  child: const Text(
                    'Account not verified? Verify now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Verify(
                          email: emailController.text,
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  child: const Text(
                    'Request for new otp',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    authProvider.resendOtpLogic(
                      emailController.text,
                      context,
                    );
                  }),
              const SizedBox(
                height: 20,
              ),

              CommonButton(
                btnName: authProviderWatch.state == AuthState.loading
                    ? 'PLEASE WAIT ...'
                    : 'LOGIN',
                textColor: Colors.white,
                btnColor: Colors.blue,
                onPressed: () {
                  authProvider.loginLogic(
                    emailController.text,
                    passwordController.text,
                    context,
                  );

                  passwordController.clear();
                },
              ),

              // GestureDetector(
              //   child: Container(
              //     width: 320,
              //     height: 50,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       color: Colors.blue,
              //     ),
              //     child: const Center(
              //       child: Text(
              //         'Login',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const Home(),
              //       ),
              //     );
              //   },
              // ),
              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: 700,
                height: 200,
                child: Image.asset('assets/base.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
