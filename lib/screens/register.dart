import 'package:flutter/material.dart';
import 'package:login/auth/auth_view_model.dart';
import 'package:login/common_widgets/common_btn.dart';
import 'package:login/common_widgets/common_textfield.dart';
import 'package:login/models/register_provider.dart';
import 'package:login/screens/login.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<RegisterProvider>();
    final providerRead = context.read<RegisterProvider>();
    final authViewModelRead = context.read<AuthViewModel>();
    final authViewModelWatch = context.watch<AuthViewModel>();

    // void submit() {
    //   if (_formKey.currentState?.validate() ?? false) {
    //     _formKey.currentState?.save();
    //     providerRead.save(
    //       usernameController.text,
    //       emailController.text,
    //       passwordController.text,
    //       confirmPasswordController.text,
    //       context,
    //     );
    //   }
    // }

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Sign Up',
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
                    'Create an account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
                        key: const ValueKey('Username'),
                        label: 'Username',
                        controller: nameController,
                        prefix: const Icon(Icons.person),
                        hint: '',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return '*This name is required';
                          }
                          return null;
                        },
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
                        key: const ValueKey('Email'),
                        label: 'Email',
                        controller: emailController,
                        prefix: const Icon(Icons.mail_outline_outlined),
                        hint: '',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return '*This email is required';
                          }
                          return null;
                        },
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
                        label: 'Password',
                        visibility: providerWatch.isVisibility,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return '*This password is required';
                          }
                          return null;
                        },
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
                        controller: confirmPasswordController,
                        label: 'Confirm Password',
                        visibility: providerWatch.isVisibility,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return '*Please confirm your password';
                          }
                          if (val != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CommonButton(
                    btnName: authViewModelWatch.state == AuthState.loading
                        ? 'PLEASE WAIT ...'
                        : 'SIGN UP',
                    textColor: Colors.white,
                    btnColor: Colors.blue,

                    // const Color.fromARGB(234, 248, 186, 93),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authViewModelRead.registerLogic(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          context,
                        );

                        passwordController.clear();
                        confirmPasswordController.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have a account?',
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
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
