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

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  Map data = {};
  late  Animation<Offset> sliding= Tween<Offset>(begin: Offset(0, 10) , end: Offset(0,-0.5)).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease));

  late AnimationController controller= AnimationController(vsync: this , duration: Duration(milliseconds: 400));
  late Animation<double> scaling  = Tween<double>(begin: 0 , end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.ease));
  bool isClicked = false;
  final TextEditingController searchtext = TextEditingController();

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    print('inna pidicho $data');
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:Color(0xffedecec) ,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,70,0,0),
            child: Column(
              children: <Widget>[
                SlideTransition(
                  position: sliding,
                  child: ScaleTransition(
                    scale: scaling,
                    child: SizedBox(
                      width: 300,
                      child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(20),
                        child: TextField(
                          controller: searchtext,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              border: InputBorder.none,

                              hintText: 'Search' ,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () async{
                                   dynamic result = await Navigator.pushNamed(context, '/searchloading' , arguments: {'address' : searchtext.text});

                                  print(result);
                                  setState(data = result);
                                  // print(ata);
                                },
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
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
                SizedBox(height: 20),

                Lottie.asset('assets/${data['animation']}'),
                SizedBox(height: 10),

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
                    color: Color(0xff74b572),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 80,
                        height: 60,

                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff565656),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0)
                              )
                            )
                          ),
                            onPressed: () async{
                              dynamic result = await Navigator.pushNamed(context, '/');

                              setState(() {
                                data = result;
                              });


                            },

                            child: Icon(Icons.location_on,
                            color: Colors.white,)),
                      ),
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff74b572),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                            onPressed: (){

                              setState(() {
                                isClicked = !isClicked;

                                if(isClicked==true)
                                  {
                                    controller.forward();
                                  }

                                else
                                  {
                                    controller.reverse();
                                  }
                              });
                            },

                            child: Icon(Icons.search ,

                              size: 40,
                              color: Colors.white,

                            )),
                      ),
                      SizedBox(
                        width: 80,
                        height: 60,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff565656),
                                shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)
                        )
                      )

                            ),
                            onPressed: (){

                            },

                            child: Icon(Icons.sunny,
                            color: Colors.white,
                            )

                        ),
                      ),


                    ],
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
