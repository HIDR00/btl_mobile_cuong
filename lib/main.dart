import 'package:cuongkh1_project/controller/setting_state.dart';
import 'package:cuongkh1_project/model/city_model.dart';
import 'package:cuongkh1_project/sub_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<CityModel>(CityModelAdapter());
  await Hive.openBox('wishList');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingState()),
      ],
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SubMainScreen(),
    );
  }
}
