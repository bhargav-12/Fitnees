import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittnessapp/yoga/expert/badtime/badtime_yoga.dart';
import 'package:fittnessapp/yoga/expert/inner_peace/inner_peace.dart';
import 'package:fittnessapp/yoga/expert/slow_flow/slow_flow.dart';
import 'package:fittnessapp/yoga/expert/slow_strech/slow_strech.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class expert extends StatefulWidget {
  const expert({Key? key}) : super(key: key);

  @override
  State<expert> createState() => _expertState();
}

// ignore: camel_case_types
class _expertState extends State<expert> {
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
                'Expert',
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
  List expertimage = [];
  List expertcalary = [];
  List expertname = [];
  List experttime = [];

  @override
  void dispose() {
    expertimage = [];
    expertcalary = [];
    expertname = [];
    experttime = [];
    beginner();
    super.dispose();
  }

  void beginner() async {
    var snapshot;
    snapshot = await FirebaseFirestore.instance
        .collection('yoga')
        .doc('yoga_d')
        .collection('expert')
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
          expertimage.add(
            storedocs[i]['image'],
          );
          expertcalary.add(storedocs[i]['calary']);
          expertname.add(storedocs[i]['name']);
          experttime.add(storedocs[i]['time']);
        }
        super.setState(() {});
      });
  }

  @override
  void initState() {
    expertimage = [];
    expertcalary = [];
    expertname = [];
    experttime = [];
    beginner();
    super.initState();
  }

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

  List navi = [
    const bad_time2(),
    const Slow_strech2(),
    const inner_peace2(),
    const Slow_flow2(),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int a = 0; a < expertimage.length; a++) ...[
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return navi[a];
                    }),
                  );
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(expertimage[a].toString()),
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 80, top: 70),
                          child: Text(
                            expertname[a].toString(),
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
                            time[a] + experttime[a].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text(
                            calary[a] + expertcalary[a].toString(),
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
