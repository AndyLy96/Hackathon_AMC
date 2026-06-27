import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:im_stepper/stepper.dart';
import 'package:project/Login.dart';

import '../../main.dart';
import '../../models/historique.dart';
import 'CreationEtape2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreationPlan1(),
    );
  }
}

class CreationPlan1 extends StatefulWidget {
  const CreationPlan1({Key? key}) : super(key: key);

  @override
  State<CreationPlan1> createState() => _CreationPlan1State();
}

class _CreationPlan1State extends State<CreationPlan1> {
  var _currentStep = 0;
  var _selectedIndex = 1;

  List<Step> _steps = [
    Step(
      title: Text('Step 1'),
      content: Text('This is the content of Step 1'),
    ),
    Step(
      title: Text('Step 2'),
      content: Text('This is the content of Step 2'),
    ),
    Step(
      title: Text('Step 3'),
      content: Text('This is the content of Step 3'),
    ),
  ];

  void _next() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Historique()),
        );
        break;
      case 1:
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CreationPlan1()),
        );
        break;
      case 2:
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'title')),
        );
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Scannez un item en premier'),
          ),
        );
        break;
      case 4:
      //NAV PAGE LOGIN
       setState(() {
         _selectedIndex = index;
       });
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => LoginScreen()),
       );
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                    color: Color(0xFF54ab79),
                    height: 225,
                    child: Image(
                        image: AssetImage(
                            './lib/images/stock-vector--d-flip-calendar-on-spring-realistic-planner-with-tear-off-pages-calendar-with-red-weekend-marks-2312994369-removebg-preview.png'))),
                Positioned(
                    top: 200,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 30, right: 30, top: 40),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Ne tardez plus et \ncrée votre plan alimentaire',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                Text(
                                  'Faites la découverte d\'une multitude d\'avenir qui pourrait vous corespondre',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: Text(
                                    'Commencez dès maintenant et créer des calendriers alimentaire fait sur mesure',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 100, right: 0, left: 0, child: CompletedStepper()),
                Positioned(bottom: 0, right: 0, left: 0, child: navBar()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container navBar() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: -20,
            blurRadius: 30,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                size: 40,
              ),
              label: 'Accueuil',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 40,
              ),
              label: 'Créer',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code,
                size: 40,
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.details,
                size: 40,
              ),
              label: 'Details',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 40),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 20.0,
          selectedItemColor: Color(0xFF1FA055),
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(
            color: Color(0xFF1FA055),
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Row CompletedStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            if (_currentStep > 0) {
              _currentStep--;
              setState(() {});
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
        ),
        Container(
            height: 100,
            width: 280,
            child: SizedBox(
              child: StepperDesEtapes(),
            )),
        IconButton(
          onPressed: () {
            if (_currentStep < 2) {
              _currentStep++;
            }
            setState(() {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreationPlan2()));
            });
          },
          icon: Icon(
            Icons.arrow_forward_ios,
            size: 25,
          ),
        ),
      ],
    );
  }

  Stepper StepperDesEtapes() {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _currentStep,
      onStepContinue: () {
        setState(() {
          if (_currentStep < 2) {
            _currentStep++;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (_currentStep > 0) {
            _currentStep--;
          }
        });
      },
      steps: [
        Step(
          content: Container(
            width: MediaQuery.of(context).size.height - 250,
          ),
          title: Text(''),
          isActive: _currentStep >= 0,
        ),
        Step(
          title: Text(''),
          content: Container(
            width: MediaQuery.of(context).size.width - 100,
          ),
          isActive: _currentStep >= 1,
        ),
        Step(
          title: Text(''),
          content: Container(
            width: MediaQuery.of(context).size.width - 250,
          ),
          isActive: _currentStep >= 2,
        ),
      ],
    );
  }
}
