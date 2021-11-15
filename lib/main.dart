// ignore_for_file: void_checks, prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var minute = 0;
  var second = 0;
  late Timer timer;
  startCountDown() {
    const secondf = Duration(seconds: 1);
    timer = Timer.periodic(secondf, (Timer timer) {
      int totalminute = minute * 60 + second;
      setState(() {
        if (totalminute == 0) {
          timer.cancel();
        } else {
          if (second == 0) minute--;
          totalminute--;
          second = (totalminute % 60);
        }
      });
    });
  }

  resetCountdown() {
    bool countdown = false;
    if (countdown = !countdown) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Countdown Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$minute:$second',
              style: Theme.of(context).textTheme.headline1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 125,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        resetCountdown();
                      });
                    },
                    child: Text(
                      'Stop',
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 125,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        startCountDown();
                      });
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 125,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  contentPadding: EdgeInsets.all(15),
                  children: [
                    Text('Set your time'),
                    DropdownButton<int>(
                      value: minute,
                      icon: Text(' Minute'),
                      items: List.generate(60, (index) {
                        return DropdownMenuItem(
                          value: index,
                          child: Text(index.toString()),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          minute = value!;
                        });
                      },
                    ),
                    DropdownButton<int>(
                        value: second,
                        onChanged: (value) {
                          setState(() {
                            second = value!;
                          });
                        },
                        icon: Text(' Second'),
                        items: List.generate(60, (index) {
                          return DropdownMenuItem(
                            child: Text(index.toString()),
                            value: index,
                          );
                        })),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            startCountDown();
                            Navigator.pop(context);
                          });
                        },
                        child: Text('start'))
                  ],
                );
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.alarm),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
