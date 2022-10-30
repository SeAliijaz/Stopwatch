import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  static const String pageRoute = "";
  const StopWatchScreen({Key? key}) : super(key: key);

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  ///variable
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;

  ///for laps
  List laps = [];

  ///stop function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  ///reset function
  void reset() {
    seconds = 0;
    minutes = 0;
    hours = 0;

    digitSeconds = "00";
    digitMinutes = "00";
    digitHours = "00";

    ///Working for now
    stop();
  }

  ///laps
  void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  ///start timer
  void start() {
    started = true;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Stopwatch timer"),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              Center(
                child: Text(
                  "$digitHours:$digitMinutes:$digitSeconds",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff323F68),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lap n' ${index + 1}",
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 12.5),
                            Text(
                              "${laps[index]}",
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.lightBlue),
                      ),
                      child: Text(
                        (!started)
                            ? "Start".toUpperCase()
                            : "Pause".toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () {
                      addLaps();
                    },
                    icon: const Icon(Icons.flag, color: Colors.white),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: RawMaterialButton(
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.lightBlue),
                      ),
                      child: Text(
                        "RESET".toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        reset();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
