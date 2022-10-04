import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittnessapp/yoga/intermediat/badtime/badtime_yoga.dart';
import 'package:fittnessapp/yoga/intermediat/inner_peace/inner_peace.dart';
import 'package:fittnessapp/yoga/intermediat/show_flow/slow_flow.dart';
import 'package:fittnessapp/yoga/intermediat/show_strech/slow_strech.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class Intermediat extends StatefulWidget {
  const Intermediat({Key? key}) : super(key: key);

  @override
  State<Intermediat> createState() => _IntermediatState();
}

// ignore: camel_case_types
class _IntermediatState extends State<Intermediat> {
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
                'Intermediat',
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
  List intermediatimage = [];
  List intermediatcalary = [];
  List intermediatname = [];
  List intermediattime = [];

  @override
  void dispose() {
    intermediatimage = [];
    intermediatcalary = [];
    intermediatname = [];
    intermediattime = [];
    beginner();
    super.dispose();
  }

  void beginner() async {
    var snapshot;
    snapshot = await FirebaseFirestore.instance
        .collection('yoga')
        .doc('yoga_d')
        .collection('intermediat')
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
          intermediatimage.add(
            storedocs[i]['image'],
          );
          intermediatcalary.add(storedocs[i]['calary']);
          intermediatname.add(storedocs[i]['name']);
          intermediattime.add(storedocs[i]['time']);
        }
        super.setState(() {});
      });
  }

  @override
  void initState() {
    intermediatimage = [];
    intermediatcalary = [];
    intermediatname = [];
    intermediattime = [];
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
    const bad_time1(),
    const Slow_strech1(),
    const inner_peace1(),
    const Slow_flow1(),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int a = 0; a < intermediatcalary.length; a++) ...[
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
                      child: Opacity(
                        opacity: 1,
                        child: Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage(intermediatimage[a].toString()),
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
                            intermediatname[a].toString(),
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
                            time[a] + intermediattime[a].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text(
                            calary[a] + intermediatcalary[a].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
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
