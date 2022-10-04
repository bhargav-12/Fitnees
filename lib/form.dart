import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittnessapp/workout_tracker/fullbody/exercises1.dart';
import 'package:flutter/material.dart';

class formpage extends StatefulWidget {
  const formpage({super.key});

  @override
  State<formpage> createState() => _formpageState();
}

class _formpageState extends State<formpage> {
  final _formkey = GlobalKey<FormState>();

  String? exercisename;
  String? gifurl = '';
  double totalset = 0;
  double totaltime = 0;
  String? id = "";

  final exercisenameController = TextEditingController();
  final gifurlcontroller = TextEditingController();
  final totalsetcontroller = TextEditingController();
  final totaltimecontroller = TextEditingController();
  final idcontroller = TextEditingController();

  void dispose() {
    exercisenameController.dispose();
    gifurlcontroller.dispose();
    totalsetcontroller.dispose();
    totaltimecontroller.dispose();
    idcontroller.dispose();
    super.dispose();
  }

  cleartext() {
    exercisenameController.clear();
    gifurlcontroller.clear();
    totalsetcontroller.clear();
    totaltimecontroller.clear();
    idcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    var yoga = FirebaseFirestore.instance.collection('yoga');

    Future<void> adduser(id, exercisename, gifurl, totalset, totaltime) {
      print("User Added");
      return yoga
          .doc('yoga_time')
          .collection('night_yoga')
          .doc('night_yoga')
          .collection('1')
          .doc(idcontroller.text)
          .set({
            'exercise_name': exercisename,
            'gif_url': gifurlcontroller.text,
            'total_set': totalset,
            'total_time': totaltime,
          })
          .then((value) => print('user added'))
          .catchError((error) => print('failed to add user:$error'));
    }

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: TextFormField(
                    autofocus: false,
                    autocorrect: false,
                    style: TextStyle(fontSize: 15),
                    cursorColor: Colors.black,
                    controller: exercisenameController,
                    onChanged: (value) => exercisename = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                      filled: true,
                      contentPadding: const EdgeInsets.all(5),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      hintText: "Enter Exercise name :",
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please Enter Quality';
                    //   }
                    // },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: TextFormField(
                    autofocus: false,
                    autocorrect: false,
                    style: TextStyle(fontSize: 15),
                    cursorColor: Colors.black,
                    controller: gifurlcontroller,
                    onChanged: (value) => gifurl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                      filled: true,
                      contentPadding: const EdgeInsets.all(5),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      hintText: "Enter Gif :",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter gif';
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: TextFormField(
                    autofocus: false,
                    autocorrect: false,
                    style: TextStyle(fontSize: 15),
                    cursorColor: Colors.black,
                    controller: totalsetcontroller,
                    // onChanged: (value) => totalset,
                    keyboardType: TextInputType.number,
                    onChanged: (s) {
                      if (double.tryParse(s) != null)
                        setState(() {
                          totalset = double.parse(s);
                        });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                      filled: true,
                      contentPadding: const EdgeInsets.all(5),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      hintText: "Enter Totalset :",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Totalset';
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: TextFormField(
                    autofocus: false,
                    autocorrect: false,
                    style: TextStyle(fontSize: 15),
                    cursorColor: Colors.black,
                    controller: totaltimecontroller,
                    // onChanged: (value) => totaltime,
                    onChanged: (s) {
                      if (double.tryParse(s) != null)
                        setState(() {
                          totaltime = double.parse(s);
                        });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                      filled: true,
                      contentPadding: const EdgeInsets.all(5),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      hintText: "Enter Totaltime :",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter totaltime';
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: TextFormField(
                    autofocus: false,
                    autocorrect: false,
                    style: TextStyle(fontSize: 15),
                    cursorColor: Colors.black,
                    controller: idcontroller,
                    onChanged: (value) => id,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                      filled: true,
                      contentPadding: const EdgeInsets.all(5),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      hintText: "Enter id :",
                    ),
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    if (_formkey.currentState!.validate()) {
                      adduser(id, exercisename, gifurl, totalset, totaltime);
                      id = idcontroller.text;
                      exercisename = exercisenameController.text;
                      gifurl = gifurlcontroller.text;
                      // totalset = totalsetcontroller ;
                      // totaltime = totaltimecontroller ;
                      Navigator.pop(context);
                    }
                  });
                },
                child: Text("add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
