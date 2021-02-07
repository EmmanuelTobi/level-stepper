import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:level_stepper/level_doc_stepper.dart';

class StepperScreen extends StatefulWidget {

  @override
  _StepperScreenState createState() => _StepperScreenState();

}

class _StepperScreenState extends State<StepperScreen> {

  var level_one = Size.zero;
  var level_two = Size.zero;
  var level_three = Size.zero;

  double initLevelHeight = 70.0;
  double buttonHeight = 50;

  final ValueNotifier<double> levelOneSizeValueListener = new ValueNotifier(0.0);
  final ValueNotifier<double> levelTwoSizeValueListener = new ValueNotifier(0.0);
  final ValueNotifier<double> levelThreeSizeValueListener = new ValueNotifier(0.0);

  DocVerification docVerification;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    docVerification = DocVerification.fromJson(DocVerification().level_data);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [

            SizedBox(height: 60,),

            levelDocView(docVerification),

          ],
        ),
      ),
    );
  }

  Widget levelDocView(DocVerification docVerification) {

    int value = 0;
    var totalStateLevel = [];

    docVerification.levelData.forEach((element) {

      element.docs.asMap().forEach((key, value) {

        if(value.isCompleted == false) {

          totalStateLevel.add(true);

        }
      });

    });

    print(totalStateLevel.length);

    return Column(
      children: docVerification.levelData.map((e) {

        value++;

        var stateLevel = e.docs.where((element) => element.isCompleted == false);

        return docTypes(
          docsList: e.docs,
          totalDoc: e.docs.length,
          levelName: e.name,
          nextVerificationIndex: (docVerification.levelData.length - totalStateLevel.length) + 1,
          position: value,
          totalLevelDoc: docVerification.levelData.length,
          activateButtonDes: stateLevel.length != 0 ? stateLevel.toList()[0].docName : "",
          levelReward: "200, 000",
          levelSubDesc: "Something",
        );
      }).toList(),
    );

  }


  Widget docTypes({
    List<Docs> docsList,
    int totalDoc,
    String levelName,
    String levelSubDesc,
    String levelReward,
    int totalLevelDoc,
    int position,
    int nextVerificationIndex,
    String activateButtonDes}) {

    final ValueNotifier<double> levelOneSizeValueListener = new ValueNotifier(0.0);

    print("nextVerificationIndex: " + nextVerificationIndex.toString());
    print("position: " + position.toString());

    return ValueListenableBuilder(
        valueListenable: levelThreeSizeValueListener,
        builder: (context, double value, child) {

          print(value.toString());

          return MeasureSize(
            onChange: (size) {

              levelThreeSizeValueListener.value = size.height;
              print(levelThreeSizeValueListener.value);

            },
            child: Container(
              height: totalDoc <= 2 ? initLevelHeight * 3 : (initLevelHeight * totalDoc),
              child: Row(
                children: [

                  Column(
                    children: [

                      position <= nextVerificationIndex - 1 ? checkedState() : circleState(mainSize: 10, innerSize: 7, isNext: position == nextVerificationIndex),

                      if(totalLevelDoc != position) ... [

                        Container(
                          color: position <= nextVerificationIndex - 1 ? Colors.green : Colors.grey,
                          height: value - 20,
                          width: 3,
                        ),

                      ] else ... [

                      ],

                    ],),

                  SizedBox(width: 10,),

                  Container(
                    height: value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(levelName),
                        SizedBox(height: 10,),
                        Text(levelSubDesc, style: TextStyle(color: Colors.black87, fontSize: 12)),
                        SizedBox(height: 5,),
                        Text(levelReward, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black54),),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: docsList.map((e) {
                            return stateToCheck(state: e.isCompleted, docDesc: e.docName);
                          }).toList(),),
                        SizedBox(height: 10,),
                        position == nextVerificationIndex ? activateLevelButton(levelButtonDes: activateButtonDes) : SizedBox(height: 1,),
                      ],
                    ),
                  ),
                ],),
            ),
          );

    });
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

  Widget activateLevelButton({String levelButtonDes}) {
    return updateButton(updateActionText: levelButtonDes);
  }

  Widget checkedState({double size}) {
    return checked(size: size);
  }

  Widget stateToCheck({bool state, String docDesc}) {
    return Column(
      children: [
        SizedBox(height: 6,),
        Row(
          children: [
            state == null || state == false ? circleState() : checkedState(size: 15),
            SizedBox(width: 6,),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text(docDesc, style: TextStyle(color: Colors.black45),),
            ),
          ],
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

typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size oldSize;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key key,
    @required this.onChange,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}
