import 'dart:async';
import 'package:covid_tracker/screens/countries_list.dart';
import 'package:covid_tracker/screens/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
       //   context, MaterialPageRoute(builder: (context) => WorldStateScreen()));

         context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
    });
  }

  void dispose(){
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(child: Image.asset('images/virus.png')),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Center(
                    child: Transform.rotate(
                        angle: _controller.value * 2.0 * math.pi, child: child),
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'COVID-19\nTracker App',textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
