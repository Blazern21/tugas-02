import 'dart:async';
import 'package:flutter/material.dart';


class StopWatch extends StatefulWidget {


  @override
  State createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch> {
  bool isTicking = true;
  int seconds = 0;
  late Timer timer;
  int milliseconds = 0;
  final laps = <int>[];


  void _onTick(Timer timer){
    setState(() {
      milliseconds += 100;
    });
  }

  // String _secondsString() => seconds == 1 ? 'second' : 'seconds';
  String _secondsString(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  void _startTimer(){
    timer = Timer.periodic(Duration(milliseconds: 100), _onTick);

    setState(() {
      isTicking = true;
    });
  }

  void _stopTimer(){
    setState(() {
      timer.cancel();
      isTicking = false;
    });
  }

  void _resetTimer(){
    setState(() {
      timer.cancel();
      isTicking = false;
      milliseconds = 0;
      laps.clear();
    });
  }

  void _lap (){
    setState(() {
      laps.add(milliseconds);
    });
  }



  Widget build(BuildContext context){
    return DefaultTabController(length: 3,
      child : Scaffold(

      body: Column(
          children: <Widget>[
            Expanded(child: buildCounter(context)),
            Expanded(child: _buildLapDisplay()),
          ]
      ),
    )
    );
  }

  Widget buildCounter(BuildContext context) {
    return Container(
        color: Colors.lightBlueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lap ${laps.length + 1}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
            ),
            Text(
              _secondsString(milliseconds),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
                width: 20
            ),
            buildControls(),
            SizedBox(
                width: 20
            ),


          ],
        )
    );
  }

  Row buildControls() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              height : 100
          ),

          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),

            ),
            onPressed: () => _startTimer(),
            child: Text(
                'Start'
            ),
          ),

          SizedBox(
              width: 20
          ),

          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: isTicking ? _stopTimer : null,
              child: Text(
                  'Pause'
              )
          ),

          SizedBox(
              width: 20
          ),

          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () => _lap(),
              child: Text(
                  'Lap'
              )
          ),

          SizedBox(
              width: 20
          ),

          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () => _resetTimer(),
              child: Text(
                  'Reset'
              )
          )
        ]
    );


  }
  Widget _buildLapDisplay() {
    return Scrollbar (
      child: ListView.builder(
          itemCount: laps.length,
          itemBuilder: (context, index) {
            final milliseconds = laps[index];

            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 50),
              title: Text('Lap ${index + 1}'),
              trailing: Text(_secondsString(milliseconds)),
            );
          }
      ),
    );

  }
}