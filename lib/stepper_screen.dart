import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StepperScreen extends StatefulWidget {

  @override
  _StepperScreenState createState() => _StepperScreenState();

}

class _StepperScreenState extends State<StepperScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    Map<String, bool> levelStates = {"level 1" : true, "level 2": false, "level 3": false};

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [

            SizedBox(height: 60,),

            Container(
              child: Row(children: [

                Column(
                  children: [

                    // circleState(mainSize: 10, innerSize: 7),

                    checkedState(),

                    Container(
                      color: Colors.green,
                      height: 170,
                      width: 3,
                    ),

                ],),

                SizedBox(width: 10,),

                Container(
                  height: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Level 1"),
                      SizedBox(height: 10,),
                      Text("BANK TRANSFERS", style: TextStyle(color: Colors.black87, fontSize: 12)),
                      SizedBox(height: 5,),
                      Text("₦ 200,000", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black54),),
                      SizedBox(height: 10,),
                      stateToCheck(childDesc: Text("Complete your profile", style: TextStyle(color: Colors.black45),), state: true),
                      stateToCheck(childDesc: Text("Verify BVN", style: TextStyle(color: Colors.black45),), state: true),
                      stateToCheck(childDesc: Text("Verify phone number", style: TextStyle(color: Colors.black45),), state: true),
                      SizedBox(height: 5,),
                      activateLevelButton(levelState: levelStates["level 1"], isNextState: true, levelButtonDes: "Verify identity"),
                  ],),
                ),

              ],),
            ),

            Container(
              child: Row(
                children: [

                Column(
                  children: [

                    circleState(mainSize: 10, innerSize: 7, isNext: true),

                    Container(
                      color: Colors.black26,
                      height: 140,
                      width: 3,
                    ),

                  ],),

                SizedBox(width: 10,),

                Container(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Level 2"),
                      SizedBox(height: 10,),
                      Text("BANK TRANSFERS", style: TextStyle(color: Colors.black87, fontSize: 12)),
                      SizedBox(height: 5,),
                      Text("₦ 1,000,000", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black54),),
                      SizedBox(height: 10,),
                      stateToCheck(childDesc: Text("Verify identity", style: TextStyle(color: Colors.black45),), state: true),
                      SizedBox(height: 5,),
                      activateLevelButton(levelState: levelStates["level 2"], isNextState: true, levelButtonDes: "Verify identity"),
                    ],),
                ),

              ],),
            ),

            Container(
              child: Row(
                children: [

                Column(
                  children: [

                    circleState(mainSize: 10, innerSize: 7, isNext: false),

                    Container(
                      // color: Colors.green,
                      height: 150,
                      width: 3,
                    ),

                  ],),

                SizedBox(width: 10,),

                Container(
                  height: 170,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Level 3"),
                      SizedBox(height: 10,),
                      Text("BANK TRANSFERS", style: TextStyle(color: Colors.black87, fontSize: 12)),
                      SizedBox(height: 5,),
                      Text("₦ 10,000,000", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black54),),
                      SizedBox(height: 10,),
                      stateToCheck(childDesc: Text("Verify residential address", style: TextStyle(color: Colors.black45),)),
                      SizedBox(height: 5,),
                      activateLevelButton(levelState: levelStates["level 3"], isNextState: false, levelButtonDes: "Verify residential address"),
                    ],
                  ),
                ),
              ],),
            ),
          ],
        ),
      ),
    );
  }


 //widget views handlers...
  Widget circleState({double mainSize, double innerSize, bool isNext}) {
    return CircleAvatar(
      radius: mainSize ?? 7,
      backgroundColor: isNext == null || isNext == true ? Colors.green : Colors.black26,
      child: CircleAvatar(
        radius: innerSize ?? 5,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget activateLevelButton({bool levelState, bool isNextState, String levelButtonDes}) {
    return levelState == false && isNextState == true ? updateButton(updateActionText: levelButtonDes) : Expanded(child: SizedBox(height: 10,));
  }

  Widget checkedState({double size}) {
    return checked(size: size);
  }

  Widget stateToCheck({bool state, Widget childDesc}) {
    return Row(
      children: [
        state == null || state == false ? circleState() : checkedState(size: 15),
        SizedBox(width: 6,),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: childDesc,
        ),
      ],
    );
  }

  Widget updateButton({String updateActionText}) {

    return Container(
      decoration: blackContainerDecoration,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 21, right: 21),
        child: Text(updateActionText, style: TextStyle(color: Colors.white),),
      ),
    );

  }

  static BoxDecoration blackContainerDecoration = BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(28),
  );

  static SvgPicture checked({double size}) {
    return SvgPicture.asset(
    'assets/check_icon.svg', height: size ?? 20, width: size ?? 20, fit: BoxFit.contain,
    );
  }

}
