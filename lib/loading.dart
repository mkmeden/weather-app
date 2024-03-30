import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/weather_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/loading.dart';



class Services{

  Future<Map<String, dynamic>> callWeather() async{


    Weather instance = Weather();
    String animation = 'clouds.json';

    //getting location coordinates

    Position position = await instance.getLocation();

    //getting city name
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    //api call
    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=bf90ee2799377574cd0ad9d22d608ad2'));
    Map data = jsonDecode(response.body);

    //initialising  the variables

    instance.locality = data['name'];
    instance.temperature = double.parse((data['main']['temp'] - 273.15).toStringAsFixed(2));
    instance.weatherType = data['weather'][0]['main'];

    switch (instance.weatherType){

      case 'Clouds':{
        animation = 'clouds.json';
      }
      case 'Thunderstorm':{
        animation = 'thunder.json';
      }

      case 'Clear':{
        animation = 'clear.json';
      }

      case 'Rain':{
        animation = 'rain.json';
      }

      case 'Snow' : {
        animation = 'snow.json';
      }
    }


    print(data);
    print('${instance.locality} and ${instance.temperature} and ${instance.weatherType}');

    return {
      'locality' : instance.locality ,
      'temperature' : instance.temperature,
      'weatherType' : instance.weatherType,
      'animation' : animation,
    };

  }

  //
  // Future<Map<String , dynamic>> locationfromaddress(String address) async
  // {
  //   List<Location> locations = await locationFromAddress(address);
  //   print(locations[0]);
  //   Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${locations[0]}&lon=${locations[1]}&appid=bf90ee2799377574cd0ad9d22d608ad2'));
  //   Map data = jsonDecode(response.body);
  //
  //   //initialising  the variables
  //   Weather instance = Weather();
  //   String animation = 'clouds.json';
  //
  //   instance.locality = data['name'];
  //   instance.temperature = double.parse((data['main']['temp'] - 273.15).toStringAsFixed(2));
  //   instance.weatherType = data['weather'][0]['main'];
  //
  //   switch (instance.weatherType){
  //
  //     case 'Clouds':{
  //       animation = 'clouds.json';
  //     }
  //     case 'Thunderstorm':{
  //       animation = 'thunder.json';
  //     }
  //
  //     case 'Clear':{
  //       animation = 'clear.json';
  //     }
  //
  //     case 'Rain':{
  //       animation = 'rain.json';
  //     }
  //
  //     case 'Snow' : {
  //       animation = 'snow.json';
  //     }
  //   }
  //
  //   //
  //   print(data);
  //   print('${instance.locality} and ${instance.temperature} and ${instance.weatherType}');
  //
  //   return {
  //     'locality' : instance.locality ,
  //     'temperature' : instance.temperature,
  //     'weatherType' : instance.weatherType,
  //     'animation' : animation,
  //   };
  //
  //
  // }

}

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  @override

  void weatherDataCaller () async{
    Services O1 = Services();
    Map<String , dynamic> data = await O1.callWeather();
    print(data['locality']);
    Navigator.pushReplacementNamed(context, '/home' , arguments: {
      'locality' : data['locality'] ,
      'temperature' : data['temperature'],
      'weatherType' :data['weatherType'],
      'animation' : data['animation'],
    });
  }

  void initState()  {
    // TODO: implement initState
    super.initState();
    weatherDataCaller();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color(0xffedecec) ,

      body:Center(
        child: Lottie.asset('assets/handloading.json'),
      )
    );
  }
}
