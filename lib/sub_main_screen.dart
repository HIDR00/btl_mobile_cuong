import 'package:cuongkh1_project/Screen/home_screen.dart';
import 'package:cuongkh1_project/controller/setting_state.dart';
import 'package:cuongkh1_project/model/city_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubMainScreen extends StatefulWidget {
  const SubMainScreen({super.key});

  @override
  State<SubMainScreen> createState() => _SubMainScreenState();
}

class _SubMainScreenState extends State<SubMainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingState>().fetchCityData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<SettingState, CityModel?>(
          selector: (ctx, state) => state.initCity,
          builder: (context, value, child) {
            if (value == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return HomeScreen(city: value);
          }),
    );
  }
}
