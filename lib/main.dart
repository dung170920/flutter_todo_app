import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/data/services/storage/services.dart';
import 'package:todo/app/modules/home/binding.dart';
import 'package:todo/app/modules/home/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(
    () => StorageService().init(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: blue,
        ),
        fontFamily: 'Inter',
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          // filled: true,
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: blue)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!)),
          hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
        ),
      ),
      home: const HomeScreen(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
