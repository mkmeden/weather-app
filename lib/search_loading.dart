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



  Future<Map<String , dynamic>> locationfromaddress(String address) async
  {
    List<Location> locations = await locationFromAddress(address);
    // print('lattitude hehe :${locations[0]}');
    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${locations[0].latitude}&lon=${locations[0].longitude}&appid=bf90ee2799377574cd0ad9d22d608ad2'));
    Map data = jsonDecode(response.body);
    print('api data $data');

    Weather instance = Weather();
    String animation = 'clouds.json';

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

    return {
      'locality' : instance.locality ,
      'temperature' : instance.temperature,
      'weatherType' : instance.weatherType,
      'animation' : animation,
    };


  }

}

class SearchLoading extends StatefulWidget {
  const SearchLoading({super.key});

  @override
  State<SearchLoading> createState() => _SearchLoadingState();
}

class _SearchLoadingState extends State<SearchLoading> {

   late dynamic data ;


  @override

  void weatherDataCaller () async{
    print(data['address']);

// print(' from searchloading ${args['address']}' );
// print(args['address']);
    Services O1 = Services();

    Map<String , dynamic> args = await O1.locationfromaddress(data['address']);
    print('final function data $args');
    Navigator.pushReplacementNamed(context, '/home' , arguments: {
      'locality' : args['locality'] ,
      'temperature' : args['temperature'],
      'weatherType' :args['weatherType'],
      'animation' : args['animation'],
    });
  }


  void initState()  {
    // TODO: implement initState
    super.initState();
    // print(args);

  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments??{} as Map<String , dynamic>;
    data = args;
    weatherDataCaller();
    // Navigator.pushReplacementNamed(context, '/home' );


    return Scaffold(
        backgroundColor:Color(0xffedecec) ,

        body:Center(
          child: Lottie.asset('assets/handloading.json'),
        )
    );
  }
}


