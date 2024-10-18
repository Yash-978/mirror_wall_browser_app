import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirror_wall_browser_app/utils/global.dart';

import 'Controller/searchController.dart';
import 'Screens/HomePage.dart';
import 'Screens/WebBrowser.dart';
import 'Screens/browser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      // initialRoute: '/home2',
      getPages: [
        GetPage(name: '/', page: () => CustomWebBrowser(),),
        // GetPage(name: '/home2', page: () => HomePage2(),),
        // GetPage(name: '/', page: () => CustomWebBrowser(),),
      ],
    );
  }
}
