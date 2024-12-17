import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoo_app/firebase_options.dart';
import 'package:todoo_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await FirebaseFirestore.instance.disableNetwork();

  runApp(const MyApp());
}

