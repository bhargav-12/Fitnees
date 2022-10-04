import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fittnessapp/createaccount/create_account.dart';
import 'package:fittnessapp/form.dart';
import 'package:fittnessapp/profile/profile.dart';
import 'package:fittnessapp/yoga/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'dashboard/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: ((context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: Scaffold(
                body: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return Yoga();
                    } else {
                      return loginpage();
                    }
                  },
                ),
              ),
            ),
          );
        }));
  }
}
