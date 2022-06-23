import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class RegisterVehicle extends StatefulWidget {
  const RegisterVehicle({Key? key}) : super(key: key);

  @override
  State<RegisterVehicle> createState() => RegisterVehicleState();
}

class RegisterVehicleState extends State<RegisterVehicle> {
  final _formKey = GlobalKey<FormState>();

  var ownerName = "";
  var vehicleModel = "";
  var plateNumber = "";

  final nameController = TextEditingController();
  final modelController = TextEditingController();
  final plateNumberController = TextEditingController();

  @override
  void dispose() {
    //clean up the controller when the widget is disposed
    nameController.dispose();
    modelController.dispose();
    plateNumberController.dispose();
  }

  clearText() {
    nameController.clear();
    modelController.clear();
    plateNumberController.clear();
  }

  // Adding Vehicles
  CollectionReference vehicle =
      FirebaseFirestore.instance.collection('vehicles');

  Future<void> addUsers() {
    return vehicle
        .add({
          'Owner Name': ownerName,
          'Vehicle Model': vehicleModel,
          'Plate Number': plateNumber
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to add user : $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xFF3551A3),
        title: const Text(
          "Register Vehicle",
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
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
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
                    controller: modelController,
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
                    controller: plateNumberController,
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
                        setState(() {
                          ownerName = nameController.text;
                          vehicleModel = modelController.text;
                          plateNumber = plateNumberController.text;
                          if (validateUserInput() == true) {
                            addUsers();
                            //clearText();
                          }
                          //addUsers();
                          clearText();
                        });
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
                      "Register Vehicle",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validateUserInput() {
    //function to check the license plate type
    String registrationInput =
        plateNumberController.text.replaceAll(RegExp(r"\s+\b|\b\s"), "");
    registrationInput = registrationInput.toUpperCase();
    int numberLength = registrationInput.length;

    //  7 digit license plate
    if (numberLength == 7) {
      if (registrationInput
          .contains(RegExp(r"^[0-9]+[0-9]+[-]+[0-9]+[0-9]+[0-9]+[0-9]"))) {
        addUsers();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                  child: Text(
                "Old License Number",
                style: TextStyle(
                  fontSize: 18.5,
                  color: Colors.blue,
                ),
              )),
              content: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '"' +
                            registrationInput +
                            '"' +
                            " is an older license number.",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
              elevation: 10,
              backgroundColor: Colors.black,
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: Text("Invalid Number")),
              content: Text(
                  '"' + registrationInput + '"' + " is not a license number."),
            );
          },
        );
      }
    } else

    //  8 digit license plate
    if (numberLength == 8) {
      String first = registrationInput.substring(0, 3);
      String second = registrationInput.substring(3, 4);
      String third = registrationInput.substring(4, 8);

      if (first.contains(RegExp(r"^[0-9]+[0-9]+[0-9]")) &&
          second.contains(RegExp(r"^[-]")) &&
          third.contains(RegExp(r"^[0-9]+[0-9]+[0-9]+[0-9]"))) {
        addUsers();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                  child: Text(
                "Old License Number",
                style: TextStyle(
                  fontSize: 18.5,
                  color: Colors.blue,
                ),
              )),
              content: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '"' +
                            registrationInput +
                            '"' +
                            " is an older license number.",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
              elevation: 10,
              backgroundColor: Colors.black,
            );
          },
        );
        // showDialog(
      } else {
        if (first.contains(RegExp(r"^[a-zA-Z]+[a-zA-Z]+[a-zA-Z]")) &&
            second.contains(RegExp(r"^[-]")) &&
            third.contains(RegExp(r"^[0-9]+[0-9]+[0-9]+[0-9]"))) {
          addUsers();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Center(
                    child: Text(
                  "Modern License Number",
                  style: TextStyle(
                    fontSize: 18.5,
                    color: Colors.blue,
                  ),
                )),
                content: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '"' +
                              registrationInput +
                              '"' +
                              " is a Modern license number.",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
                elevation: 10,
                backgroundColor: Colors.black,
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Center(child: Text("Invalid Number")),
                  content: Text('"' +
                      registrationInput +
                      '"' +
                      " is not a license number."));
            },
          );
        }
      }
    } else
    //  9 digit license plate validation
    if (numberLength == 9) {
      if (registrationInput.contains(RegExp(
          r"^[a-zA-Z]+[P]+[a-zA-Z]+[a-zA-Z]+[-]+[0-9]+[0-9]+[0-9]+[0-9]"))) {
        addUsers();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                  child: Text(
                "Modern License Number",
                style: TextStyle(
                  fontSize: 18.5,
                  color: Colors.blue,
                ),
              )),
              content: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '"' +
                            registrationInput +
                            '"' +
                            " is a Modern license number.",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
              elevation: 10,
              backgroundColor: Colors.black,
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Center(child: Text("Invalid Number")),
                content: Text('"' +
                    registrationInput +
                    '"' +
                    " is not a license number."));
          },
        );
      }
    } else
    //  10 digit vintage license plate validation
    if (numberLength == 10) {
      String first = registrationInput.substring(0, 2);
      String second = registrationInput.substring(2, 6);
      String third = registrationInput.substring(6, 10);

      if (registrationInput
          .contains(RegExp(r"^[0-9]+[0-9]+[SHRI]+[0-9]+[0-9]+[0-9]+[0-9]"))) {
        addUsers();
        second = second.replaceAll("SHRI", "ශ්‍රී");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                  child: Text(
                "Vintage License Number",
                style: TextStyle(
                  fontSize: 18.5,
                  color: Colors.blue,
                ),
              )),
              content: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '"' +
                            first +
                            second +
                            third +
                            '"' +
                            " is  a vintage registration.",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
              elevation: 10,
              backgroundColor: Colors.black,
            );
          },
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Center(child: Text("Invalid Number")),
                  content: Text('"' +
                      registrationInput +
                      '"' +
                      " is not a license number."));
            });
      }
    } else {
      // if the input doesn't satisfy any of the above it can determined as an invalid input
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Center(child: Text("Invalid Number")),
              content: Text('"' +
                  registrationInput +
                  '"' +
                  " is not a valid license number."));
        },
      );
    }
  }
}
