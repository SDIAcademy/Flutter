import 'package:flutter/material.dart';

class StepComponent extends StatefulWidget {
  @override
  _StepComponentState createState() => new _StepComponentState();
}

class _StepComponentState extends State<StepComponent> {
  int current = 1;
  void nextFunc([value = -1]){
    setState(() {
      print('value $value');
      value == -1?
                  current += 1
                 :
                  current = value;
      current %= mySteps.length;
    });
  }
  final List<Step> mySteps = [
    Step(
      title: Text("Step One"),
      content: Text("Frontend",style: TextStyle(fontSize: 20.0,color: Colors.teal)),
      isActive: true,
    ),
    Step(
      title: Text("Step 2"),
      content: Text("Backend"),
      isActive: true,
    ),
    Step(
      title: Text("Step 3"),
      content: Text("Devops"),
      isActive: true,
    ),
    Step(
      title: Text("Step 4"),
      content: Text("Deploy"),
      isActive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return  Stepper(
      steps: mySteps,
      onStepTapped: (context)=>nextFunc(context),
      currentStep: current,
      type: StepperType.vertical,
      onStepContinue: nextFunc,
    );
  }
}