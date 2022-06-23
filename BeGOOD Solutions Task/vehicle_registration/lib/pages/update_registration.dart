import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class UpdateRegistration extends StatefulWidget {
  final String id;
  const UpdateRegistration({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateRegistration> createState() => UpdateRegisterVehicleState();
}

class UpdateRegisterVehicleState extends State<UpdateRegistration> {
  final _formKey = GlobalKey<FormState>();

  // updating Vehicles
  CollectionReference vehicle =
      FirebaseFirestore.instance.collection('vehicles');

  Future<void> updateUser(id, name, model, number) {
    return vehicle
        .doc(id)
        .update({
          'Owner Name': name,
          'Vehicle Model': model,
          'Plate Number': number
        })
        .then((value) => print('User update'))
        .catchError((error) => print('Failed to update user : $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //App Bar
        appBar: AppBar(
          backgroundColor: const Color(0xFF3551A3),
          title: const Text(
            "Update Registered Vehicles",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.home_rounded),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          leadingWidth: 80, // default is 56
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.2, 0.9],
                colors: [
                  Color(0xFF3551A3),
                  Color(0xFF80ADE1),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  //Getting specific data by Id
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection('vehicles')
                        .doc(widget.id)
                        .get(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        print("something went wrong");
                      }
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // }
                      var data = snapshot.data!.data();
                      var name = data!['Owner Name'];
                      var model = data['Vehicle Model'];
                      var number = data['Plate Number'];

                      return Column(
                        children: [
                          TextFormField(
                            initialValue: name,
                            onChanged: (value) => name = value,
                            //controller: nameController,
                            decoration: const InputDecoration(
                              labelText: "Owner Name",
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter owner name";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            initialValue: model,
                            onChanged: (value) => model = value,
                            //controller: modelController,
                            decoration: const InputDecoration(
                              labelText: "Vehicle Model",
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter vehicle model";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            initialValue: number,
                            onChanged: (value) => number = value,
                            //controller: plateNumberController,
                            decoration: const InputDecoration(
                              labelText: "License Plate Number",
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter License Plate Number";
                              }
                              return null;
                            },
                          ),
                          const Text(
                              "***Note : If the license contains 'ශ්‍රී' please type it as 'SHRI'.***"),
                          const SizedBox(
                            height: 25,
                          ),
                          MaterialButton(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            minWidth: double.infinity,
                            height: 40,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                updateUser(widget.id, name, model, number);
                                Navigator.pop(context);
                              }
                            },
                            //defining the shape
                            color: const Color(0xEEFFFFFF),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color(0xFFFFFFFF),
                                ),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Update Vehicle Details",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )),
            ),
          ),
        ));
  }
}
