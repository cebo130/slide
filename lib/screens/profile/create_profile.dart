import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/date_provider.dart';
import '../../widgets/pickers/date_picker.dart';


class CreateProfile extends StatefulWidget {
   CreateProfile({required this.myDate});
  final String myDate;
  @override
  State<CreateProfile> createState() => _CreateProfileState(myDate: myDate);
}

class _CreateProfileState extends State<CreateProfile> {
  _CreateProfileState({required this.myDate});
final String myDate;
  //start/*********************************
  int _index = 0;
  bool genB = false;
  String change = "";
  // Initial Selected Value
  String genderVal = 'Gender';

  // List of items in our dropdown menu
  var genderVar = [
    'Gender',
    'Male',
    'Female',
    'LGTBQ',
    'Other',
  ];
  bool occB = false;
  // Initial Selected Value
  String occVal = 'Occupation';

  // List of items in our dropdown menu
  var occVar = [
    'Occupation',
    'Working',
    'Studying',
    'Hustling',
    'Other',
  ];
  /*start*/

  /*end*/
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Create Profile",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      // ),
      body: Column(
        children: [
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock,
                color: Colors.grey,
                size: 40,
              ),
              Text("Secure",style: TextStyle(fontSize: 30,color: Colors.grey),)
            ],
          ),
          Stepper(
            currentStep: _index,
            margin: EdgeInsets.all(90),
            physics: ScrollPhysics(),
            onStepCancel: () {
              if (_index > 0) {
                setState(() {
                  _index -= 1;
                });
              }
            },
            onStepContinue: () {
              if(genderVal==genderVar[0]){
                setState(() {
                  genB = true;
                  change = "please input Gender";
                });
              }else if(occVal==occVar[0]){
                setState(() {
                  occB = true;
                  change = "please input Occupation";
                });
              }else{
                if (_index <= 0) {
                  setState(() {
                    _index += 1;
                  });
                }
              }
            },
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            steps: <Step>[
              Step(
                title: const Text('Biography'),
                content: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            DropdownButton(

                              // Initial Value
                              value: genderVal,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: genderVar.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items,style: TextStyle(fontSize: 20,color: Colors.grey),),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  genderVal = newValue!;
                                  if(genderVal!=genderVar[0]){
                                    genB = false;
                                  }
                                });
                              },
                            ),
                            Spacer(),
                            DropdownButton(

                              // Initial Value
                              value: occVal,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: occVar.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items,style: TextStyle(fontSize: 20,color: Colors.grey),),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  occVal = newValue!;
                                  if(genderVal!=genderVar[0]){
                                    occB = false;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            BirthDayPicker(restorationId: 'main',),
                          ],
                        ),
                        genB ? Text(change,style: TextStyle(color: Colors.red),) : SizedBox.shrink(),
                        occB ? Text(change,style: TextStyle(color: Colors.red),) : SizedBox.shrink(),
                        Text("${context.watch<DatePicked>().dateShit}"),
                      ],
                    )),
              ),
              Step(
                title: Text('Preference'),
                content: Text('Content for Step 2'),
              ),
              const Step(
                title: Text('Finish'),
                content: Text('Content for Step 3'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
