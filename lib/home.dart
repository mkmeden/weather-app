import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/weather_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/loading.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    print(data['animation']);
    return Scaffold(
      backgroundColor:Color(0xffd9d9d9) ,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,70,0,0),
            child: Column(
              children: <Widget>[
                Icon(
                    Icons.location_on,
                  color: Color(0xffa8a8a8),
                  size: 35,
                ),
                Text(
                    '${data['locality']?.toUpperCase()}',
                style:GoogleFonts.leagueGothic(
                  fontSize: 30,
                  color: Color(0xff6c6c6c),
                ),

                ),
                SizedBox(height: 100),

                Lottie.asset('assets/${data['animation']}'),
                SizedBox(height: 70),

                Text(
                  '${data['weatherType']}',
                  style: GoogleFonts.leagueGothic(
                    fontSize : 40,
                    color: Color(0xd8363636)
                  ),

                ),

                Text('${data['temperature']}°C',
                  style: GoogleFonts.leagueGothic(
                    fontSize: 50,
                    color: Color(0xd8363636),
                  ),
                )

              ],
            ),
          )
        )
          ),

        );
  }
}
