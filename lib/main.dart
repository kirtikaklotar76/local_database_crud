import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_crud_demo/helpers/db_helper.dart';
import 'package:local_crud_demo/views/screens/home_page.dart';

import 'controllers/db_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDb();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DbController dbController = Get.put(DbController());
    dbController.init();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
      ],
    );
  }
}
