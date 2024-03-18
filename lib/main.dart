import 'package:flutter/material.dart';
import 'package:login/auth/auth_view_model.dart';
import 'package:login/models/register_provider.dart';
import 'package:login/screens/welcome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MaterialApp(
        home: Welcome(),
      ),
    ),
  );
}
