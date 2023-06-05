import 'dart:convert';

import 'package:animated_background/animated_background.dart';
import 'package:drinkmore/screens/basicgamescreen/components/body.dart';
import 'package:drinkmore/utils/Person.dart';
import 'package:drinkmore/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    loadPersonen();
    super.initState();
  }

  TextEditingController firstNameController = TextEditingController();
  List<Widget> screens = [
    BodyBasicGame(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
                baseColor: Colors.purpleAccent.shade100,
                spawnMaxRadius: 10,
                particleCount: 20)),
        vsync: this,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Mitspieler:"),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: showPlayer(),
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24))),
                  child: TextButton(
                      onPressed: () {
                        firstNameController.clear();
                        Person person = Person("", false, true, true);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32)),
                                title: Text("Neue Person"),
                                content: Container(
                                  height: size.height * 0.1,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: firstNameController,
                                        decoration: InputDecoration(
                                          hintText: "Name des Spielers",
                                          labelText: "Name",
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter some Text";
                                          }
                                          return null;
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        person.name = firstNameController.text;
                                        Navigator.pop(context);
                                        setState(() {
                                          personen.add(person);
                                        });
                                        storePersonen(personen);
                                      },
                                      child: Text("Hinzufügen"))
                                ],
                              );
                            });
                      },
                      child: Text("Spieler hinzufügen"))),
              TextButton(
                onPressed: () {
                  init();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BodyBasicGame()));
                },
                child: Text("Start Game"),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white54),
                        borderRadius: BorderRadius.circular(24)),
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.05,
                        horizontal: size.width * 0.2),
                    foregroundColor: Colors.orange,
                    backgroundColor: Colors.blueGrey.withOpacity(0.75)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded showPlayer() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: personen.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(personen[index].name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (personen[index].isMan) {
                          personen[index].isMan = false;
                        } else {
                          personen[index].isMan = true;
                          true;
                        }
                      });
                    },
                    icon: Icon(personen[index].isMan ? Icons.man : Icons.woman),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (personen[index].isSingle) {
                          personen[index].isSingle = false;
                        } else {
                          personen[index].isSingle = true;
                          true;
                        }
                      });
                    },
                    icon: Icon(personen[index].isSingle
                        ? Icons.favorite_border
                        : Icons.favorite),
                    color: Colors.redAccent.withOpacity(0.9),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        personen.length == 1 ? null : personen.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void storePersonen(List<Person> personen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(jsonEncode(personen));
    prefs.setString("personen", jsonEncode(personen));
  }

  Future<void> loadPersonen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> data = jsonDecode(prefs.getString('personen') ?? '{}');
    List<Person> p = [];
    print(data);
    for (Map<String, dynamic> d in data) {
      p.add(Person.fromJson(d));
    }

    setState(() {
      personen = p;
    });
  }
}
