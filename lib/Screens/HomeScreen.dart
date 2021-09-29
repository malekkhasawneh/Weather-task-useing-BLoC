import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_task/Screens/LoginScreen.dart';

import 'GetWeatherInfoApi.dart';
import 'UserProfile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder(
            future: getCityWeather(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text('Can\'t View Data Now'),
                );
              else if (snapshot.hasData) {
                final Weather weatherInfo = snapshot.data as Weather;
                return ListView.builder(
                    itemCount: weatherInfo.weather!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            height: 445,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
                                image: DecorationImage(
                                  image: AssetImage("images/petra.jpg"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                              height: 445,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(150, 0, 0, 0),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
                              )),
                          Center(
                              child: Stack(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfile()),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.settings,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      )),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(right: 15, top: 10),
                                      child: IconButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.logout,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      )),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 100,
                                      ),
                                      child: Text(
                                        weatherInfo.name!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        '${_date.toString().split(' ')[0]}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: weatherInfo.weather![index].main ==
                                              'Clear'
                                          ? Icon(
                                              Icons.wb_sunny,
                                              size: 120,
                                              color: Colors.yellow,
                                            )
                                          : Icon(
                                              Icons.cloud,
                                              size: 120,
                                              color: Colors.white,
                                            ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 17, left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${(weatherInfo.main!.temp! - 273.15).round()}°',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 45),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Max',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      '${(weatherInfo.main!.tempMax! - 273.15).round()}°',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  ' | ',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Min',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      '${(weatherInfo.main!.tempMin! - 273.15).round()}°',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 470),
                              child: Column(
                                children: [
                                  Container(
                                    width: size.width * 0.73,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, left: 15),
                                      child: Text(
                                        'Weather : ${weatherInfo.weather![index].main}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Container(
                                      width: size.width * 0.73,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 15, left: 15),
                                        child: Text(
                                          'Description : ${weatherInfo.weather![index].description}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Container(
                                      width: size.width * 0.73,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 15, left: 15),
                                        child: Text(
                                          'Wind Speed : ${weatherInfo.wind!.speed}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
