import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(
                  top: 35, left: 23, right: 20, bottom: 10),
              child: Text('About',
                style: GoogleFonts.arima(
                    fontSize: 40, fontWeight: FontWeight.bold),
              )
          ),
          Container(
            padding: EdgeInsets.only(left: 23, right: 20, bottom: 5),
            child:
            Text('Nama : Aurelius Ondio Lamlo',
              style: GoogleFonts.tienne(fontSize: 18
                  , color: Colors.black),),
          ),
          Container(
            padding: EdgeInsets.only(left: 23, right: 20),
            child:
            Text('NIM : 825210108',
              style: GoogleFonts.tienne(fontSize: 18
                  , color: Colors.black),),
          ),
          Container(
            padding: EdgeInsets.only(left: 50, right: 20),
            height: 200,
            width: 350,
            child:  Image.asset('assets/1.png',
            fit: BoxFit.scaleDown,
            )
          ),
          Container(
              padding: EdgeInsets.only(left: 50, right: 20),
              height: 130,
              width: 350,
              child:  Image.asset('assets/4.png',
                fit: BoxFit.fitWidth,
              )
          )
        ]
    );
  }
}

