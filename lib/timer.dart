import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week2/round_button.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:week2/app_bar.dart';


class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isTicking = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed?
        '${(controller.duration!.inHours % 60).toString().padLeft(2,'0')
        }:${(controller.duration!.inMinutes % 60).toString().padLeft(2,'0')
        }:${(controller.duration!.inSeconds % 60).toString().padLeft(2,'0')}':
        '${(count.inHours % 60).toString().padLeft(2,'0')
        }:${(count.inMinutes % 60).toString().padLeft(2,'0')
        }:${(count.inSeconds % 60).toString().padLeft(2,'0')}';
  }

  double progress = 1.0;

  void timesup(BuildContext context){
    Navigator.of(context).pop();
  }

  void notifText() {
    if (countText == '00:00:00') {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Times Up'),
          content: Text('Your timer has reached 0.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed:() => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AppBar2()),
              ),
            )
          ],
        ),
      );
    }
  }

  void notifSound(){
    if (countText == '00:00:00'){
      FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,
        duration: Duration());

    controller.addListener(() {
      notifSound();
      notifText();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      }
      else{
        setState(() {
          progress = 1.0;
          isTicking = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child : Stack(
                alignment: Alignment.center,
                children : [
                  SizedBox(
                    width: 300, height: 300,
                    child: CircularProgressIndicator(
                      color: Colors.purpleAccent,
                      backgroundColor: Colors.grey.shade200,
                      value: progress,
                      strokeWidth: 5,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      if (controller.isDismissed){
                        showModalBottomSheet(context: context,
                            builder: (context) => Container(
                              height: 300,
                              child: CupertinoTimerPicker(
                                initialTimerDuration: controller.duration!,
                                onTimerDurationChanged: (time){
                                  setState(() {
                                    controller.duration = time;
                                  });
                                },
                              ),
                            ));
                      };
                      },
                     child: AnimatedBuilder(
                     animation: controller,
                      builder: (context, child) => Text(
                        countText,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              ),
            ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    if(controller.isAnimating){
                      controller.stop();
                      setState(() {
                        isTicking = false;
                      });
                    }
                    else{
                      controller.reverse(from:
                      controller.value == 0?1.0:controller.value);
                      setState(() {
                        isTicking = true;
                      });
                    }
                  },
                  child: RoundButton(
                  icon: isTicking == true? Icons.pause :
                  Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    controller.reset();
                    setState(() {
                      isTicking = false;
                    });
                  },
                  child: RoundButton(
                  icon: Icons.stop,
                  )
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}