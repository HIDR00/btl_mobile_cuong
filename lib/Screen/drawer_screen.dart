import 'package:cuongkh1_project/Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/city_model.dart';
import '../services/constants.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<CityModel> wishList = [];
  var box = Hive.box("wishList");

  @override
  void initState() {
    super.initState();
    wishList = box.get('id').cast<CityModel>() ?? [];
  }

  bool checkFavorite(CityModel city, List<CityModel> listFavoriteCity) {
    return listFavoriteCity.any((favoriteCity) => favoriteCity.lat == city.lat && favoriteCity.lon == city.lon);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('WishList'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: wishList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(city: wishList[index],)));
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: Constants().ColorPrimary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        wishList[index].name,
                        style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (checkFavorite(wishList[index], wishList)) {
                            wishList.remove(wishList[index]);
                          } else {
                            wishList.add(wishList[index]);
                          }
                        });
                        box.put('id', wishList);
                      },
                      child: Container(
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: checkFavorite(wishList[index], wishList)
                            ? const Icon(Icons.favorite, color: Colors.pink, size: 35)
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                                size: 35,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
