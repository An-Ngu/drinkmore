import 'package:animated_background/animated_background.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:drinkmore/screens/basicgamescreen/constants.dart';
import 'package:drinkmore/utils/Question.dart';
import 'package:drinkmore/utils/constants.dart';
import 'package:flutter/material.dart';

class BodyBasicGame extends StatefulWidget {
  String url =
      "https://www.nicepng.com/png/detail/629-6297572_pink-glitter-star-png-clipart-star-polygons-in.png";

  BodyBasicGame({Key? key}) : super(key: key);

  @override
  State<BodyBasicGame> createState() => _BodyBasicGameState();
}

class _BodyBasicGameState extends State<BodyBasicGame>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
                image: Image.network(widget.url),
                baseColor: Colors.lightBlueAccent.shade100,
                spawnMaxRadius: 50,
                particleCount: 10)),
        vsync: this,
        child: SafeArea(
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                    child: PageView.builder(
                  itemCount: createdCustomQuestions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return card(
                        size, context, createdCustomQuestions.elementAt(index));
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack card(Size size, BuildContext context, Question question) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: size.height * 0.85,
            width: size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.orangeAccent.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 7))
                ],
                image: DecorationImage(
                    opacity: 0.8,
                    image: NetworkImage(
                        backgroundImages.elementAt(question.variant - 1)),
                    fit: BoxFit.cover)),

            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(24),
            //     border: Border.all(color: Colors.black26),
            //     color: Colors.orange.withOpacity(0.5)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  question.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontFamily: "Schyler"),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.backspace_outlined)),
        ),
      ],
    );
  }
}
