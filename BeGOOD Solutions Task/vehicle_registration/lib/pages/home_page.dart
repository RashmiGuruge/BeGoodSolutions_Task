import 'package:flutter/material.dart';
import 'package:vehicle_registration/pages/register_vehicles.dart';
import 'package:vehicle_registration/pages/view_all.dart';

import 'check_plate_type.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 90),
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
              const SizedBox(
                height: 17,
              ),
              MaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                minWidth: double.infinity,
                height: 40,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckPlateType()));
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
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                minWidth: double.infinity,
                height: 40,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterVehicle()));
                },
                //defining the shape
                color: const Color(0xEEFFFFFF),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xFFFFFFFF),
                    ),
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  "Vehicle Registrations",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                minWidth: double.infinity,
                height: 40,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllVehicle()));
                },
                //defining the shape
                color: const Color(0xEEFFFFFF),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xFFFFFFFF),
                    ),
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  "View All Registered Vehicle",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Logo.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
