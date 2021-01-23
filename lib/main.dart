import 'package:flutter/material.dart';
import 'package:level_stepper/stepper_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (BuildContext context) {

        Size size = MediaQuery.of(context).size;
        // SizeConfig.init(context, width: size.width, height: size.height, allowFontScaling: true);

        return StepperScreen();

      }),
    );
  }
}