import 'package:flutter/material.dart';

import 'home_page.dart';

class CheckPlateType extends StatefulWidget {
  const CheckPlateType({Key? key}) : super(key: key);

  @override
  State<CheckPlateType> createState() => CheckPlateTypeState();
}

class CheckPlateTypeState extends State<CheckPlateType> {
  TextEditingController controllerPlateNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xFF3551A3),
        title: const Text(
          "Vehicle License Plate Type",
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
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
        //margin: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.2, 0.9],
            colors: [
              Color(0xFF4560B8),
              Color(0xFF80ADE1),
            ],
          ),
        ),
        child: Column(
          children: [
            TextFormField(
              controller: controllerPlateNumber,
              decoration: const InputDecoration(
                labelText: "Enter License Plate Number",
                labelStyle: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                "***Note : If the license contains 'ශ්‍රී' please type it as 'SHRI'.***"),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              minWidth: double.infinity,
              height: 40,
              onPressed: () {
                checkPlateType();
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
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
                "Check Plate Number Type",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  //function to check the license plate type
  checkPlateType() {
    String licenseNumber =
        controllerPlateNumber.text.replaceAll(RegExp(r"\s+\b|\b\s"), "");
    licenseNumber = licenseNumber.toUpperCase();
    int numberLength = licenseNumber.length;

    //  7 digit license plate
    if (numberLength == 7) {
      if (licenseNumber
          .contains(RegExp(r"^[0-9]+[0-9]+[-]+[0-9]+[0-9]+[0-9]+[0-9]"))) {
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
                            licenseNumber +
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
              backgroundColor: Colors.white,
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: Text("Invalid Number")),
              content:
                  Text('"' + licenseNumber + '"' + " is not a license number."),
            );
          },
        );
      }
    } else

    //  8 digit license plate
    if (numberLength == 8) {
      String first = licenseNumber.substring(0, 3);
      String second = licenseNumber.substring(3, 4);
      String third = licenseNumber.substring(4, 8);

      if (first.contains(RegExp(r"^[0-9]+[0-9]+[0-9]")) &&
          second.contains(RegExp(r"^[-]")) &&
          third.contains(RegExp(r"^[0-9]+[0-9]+[0-9]+[0-9]"))) {
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
                            licenseNumber +
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
              backgroundColor: Colors.white,
            );
          },
        );
        // showDialog(
      } else {
        if (first.contains(RegExp(r"^[a-zA-Z]+[a-zA-Z]+[a-zA-Z]")) &&
            second.contains(RegExp(r"^[-]")) &&
            third.contains(RegExp(r"^[0-9]+[0-9]+[0-9]+[0-9]"))) {
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
                              licenseNumber +
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
                backgroundColor: Colors.white,
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
                      '"' + licenseNumber + '"' + " is not a license number."));
            },
          );
        }
      }
    } else
    //  9 digit license plate validation
    if (numberLength == 9) {
      if (licenseNumber.contains(RegExp(
          r"^[a-zA-Z]+[P]+[a-zA-Z]+[a-zA-Z]+[-]+[0-9]+[0-9]+[0-9]+[0-9]"))) {
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
                            licenseNumber +
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
              backgroundColor: Colors.white,
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
                    '"' + licenseNumber + '"' + " is not a license number."));
          },
        );
      }
    } else
    //  10 digit vintage license plate validation
    if (numberLength == 10) {
      String first = licenseNumber.substring(0, 2);
      String second = licenseNumber.substring(2, 6);
      String third = licenseNumber.substring(6, 10);

      if (licenseNumber
          .contains(RegExp(r"^[0-9]+[0-9]+[SHRI]+[0-9]+[0-9]+[0-9]+[0-9]"))) {
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
              backgroundColor: Colors.white,
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
                      '"' + licenseNumber + '"' + " is not a license number."));
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
                  licenseNumber +
                  '"' +
                  " is not a valid license number."));
        },
      );
    }
  }
}
