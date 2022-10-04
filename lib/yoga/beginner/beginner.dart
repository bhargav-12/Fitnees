import 'dart:ui';

// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittnessapp/meal_planner/breakfast.dart';
import 'package:fittnessapp/yoga/beginner/badtime/badtime_yoga.dart';
import 'package:fittnessapp/yoga/beginner/inner_peace/inner_peace.dart';
import 'package:fittnessapp/yoga/beginner/show_flow/slow_flow.dart';
import 'package:fittnessapp/yoga/beginner/show_strech/slow_strech.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class beginner extends StatefulWidget {
  const beginner({Key? key}) : super(key: key);

  @override
  State<beginner> createState() => _beginnerState();
}

// ignore: camel_case_types
class _beginnerState extends State<beginner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Beginner',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const page(),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class page extends StatefulWidget {
  const page({Key? key}) : super(key: key);

  @override
  State<page> createState() => _pageState();
}

// ignore: camel_case_types
class _pageState extends State<page> {
  List beginnerimage = [];
  List beginnercalary = [];
  List beginnername = [];
  List begginertime = [];

  @override
  void dispose() {
    beginnerimage = [];
    beginnercalary = [];
    beginnername = [];
    begginertime = [];
    beginner();
    super.dispose();
  }

  void beginner() async {
    var snapshot;
    snapshot = await FirebaseFirestore.instance
        .collection('yoga')
        .doc('yoga_d')
        .collection('beginner')
        .get();
    List storedocs = [];
    snapshot.docs.map((DocumentSnapshot document) {
      Map a = document.data() as Map<String, dynamic>;
      storedocs.add(a);
      a['id'] = document.id;
    }).toList();

    if (mounted)
      setState(() {
        for (var i = 0; i < storedocs.length; i++) {
          beginnerimage.add(
            storedocs[i]['image'],
          );
          beginnercalary.add(storedocs[i]['calary']);
          beginnername.add(storedocs[i]['name']);
          begginertime.add(storedocs[i]['time']);
        }
        super.setState(() {});
      });
  }

  @override
  void initState() {
    beginnerimage = [];
    beginnercalary = [];
    beginnername = [];
    begginertime = [];
    beginner();
    super.initState();
  }

  List navi = [
    const bad_time(),
    const Slow_strech(),
    const inner_peace(),
    const Slow_flow(),
  ];
  List time = [
    'time :',
    'time :',
    'time :',
    'time :',
  ];
  List calary = [
    'calary :',
    'calary :',
    'calary :',
    'calary :',
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int a = 0; a < begginertime.length; a++) ...[
              InkWell(
                onTap: () => Get.to(navi[a]),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Opacity(
                        opacity: 1,
                        child: Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(beginnerimage[a].toString()),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 80, top: 70),
                          child: Text(
                            beginnername[a].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text(
                            time[a] + begginertime[a].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text(
                            calary[a] + beginnercalary[a].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
