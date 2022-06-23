import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_registration/pages/update_registration.dart';

import 'home_page.dart';

class AllVehicle extends StatefulWidget {
  const AllVehicle({Key? key}) : super(key: key);

  @override
  State<AllVehicle> createState() => AllVehicleState();
}

class AllVehicleState extends State<AllVehicle> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('vehicles').snapshots();

  //for deleting user
  CollectionReference vehicle =
      FirebaseFirestore.instance.collection('vehicles');
  Future<void> deleteUser(id) {
    //   print("User Deleted $id");
    return vehicle
        .doc(id)
        .delete()
        .then((value) => print('User deleted'))
        .catchError((error) => print('Failed to delete user :$error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
            //print(document.id);
          }).toList();

          return Scaffold(
            //App Bar
            appBar: AppBar(
              backgroundColor: const Color(0xFF3551A3),
              title: const Text(
                "All Registered Vehicles",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.home_rounded),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
              ),
              leadingWidth: 80, // default is 56
            ),
            body: Center(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 0.5,
                            right: 0.5,
                          ),
                          child: ListTile(
                            title: Text(
                              snapshot
                                  .data!.docChanges[index].doc['Owner Name'],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data!.docChanges[index]
                                      .doc['Vehicle Model'] +
                                  "       " +
                                  snapshot.data!.docChanges[index]
                                      .doc['Plate Number'],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateRegistration(
                                        id: storedocs[index]['id']),
                                  ),
                                )
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFF3551A3),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  {deleteUser(storedocs[index]['id'])},
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xFF3551A3),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
