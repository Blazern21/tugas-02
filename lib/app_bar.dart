import 'package:flutter/material.dart';
import 'package:week2/stopwatch.dart';
import 'package:week2/about.dart';
import 'package:week2/timer.dart';

class AppBar2 extends StatefulWidget {

  @override
  State createState() => AppBarrrState();
}

class AppBarrrState extends State<AppBar2> {

  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
      child: Scaffold(

        appBar: AppBar(
          title: Text("AppBar"),
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {}),
          actions: [
            IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {}),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.timer_outlined), text: "Stopwatch",),
              Tab(icon: Icon(Icons.timer_10), text: "Timer",),
              Tab(icon: Icon(Icons.account_circle_rounded), text: "About",)
            ],
          ),
          elevation: 10,
        ),
        body: TabBarView(
          children: [
            StopWatch(),
            CountdownPage(),
            about(),

          ],
        ),
      ),
    );
  }
}

