import 'package:cuongkh1_project/Screen/home_screen.dart';
import 'package:cuongkh1_project/model/city_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/setting_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withOpacity(0.3),
            border: Border.all(color: Colors.grey)),
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            context.read<SettingState>().fetchListCityData(value);
          },
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.search),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 20, right: 10, top: 10),
          ),
        ),
      )),
      body: Selector<SettingState,List<CityModel>>(
        selector: (ctx, state) => state.listCity,
        builder: (context, value, child) {
          return value.isNotEmpty ? 
           ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('${value[index].lat}:${value[index].lon}');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(city: value[index])));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      Text('${value[index].name},${value[index].country}',style: TextStyle(
                        color: Colors.black
                      ),),
                    ],
                  )
                ),
              );
            },
          ) : Container();
        },
      ),
    );
  }
}
