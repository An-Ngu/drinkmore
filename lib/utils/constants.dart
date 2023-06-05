import 'dart:math';
import 'package:drinkmore/utils/Person.dart';
import 'package:drinkmore/utils/Question.dart';
import 'package:flutter/cupertino.dart';

List<Question> questions = <Question>[

  Question("Nenne drei Dinge, die im Kühlschrank sind. Jeder, der es nicht schafft, muss trinken.",1,false),
  Question("Alle trinken die Anzahl der getragenen Jogginghosen im Raum",1,false),
  Question("Die älteste Person trinkt 2 Schlücke, alter Knacker",1,false),
  Question("Der jüngste Mitspieler trinkt 5, weil Baby",1,false),
  Question("Alle Smartphones kommen offen auf den Tisch, wer zuerst eine Nachricht erhält muss 5 trinken.",1,false),
  Question("Mitspieler mit Haustiere dürfen 2 verteilen",1,false),
  Question("Mitspieler ohne Haustiere dürfen 2 verteilen",1,false),
];
List<Question> questionsMultipleTimes = <Question>[
  Question("PERSON1, hast du schon mal Blut gespendet", 1, false),
  Question(
      "PERSON1 spiel mit PERSON2 Schnick, Schnack, Schnuck bis 3 - verlierer trinkt das Getränk auf ex",
      1,
      false),

  Question("Pantomime: PERSON1 zeigt ohne zu sprechen ein Wort oder einen Ausdruck, und die anderen müssen erraten, "
      "um was es sich handelt. Spieler die das Wort oder den Ausdruck nicht innerhalb von 10 Sekunden erraten können, müssen 2 trinken.",1,false),
  Question("Alphabet: Die Spieler nehmen abwechselnd ein Wort innerhalb eines Kategories, das mit dem nächsten Buchstaben des Alphabets beginnt. Zum Beispiel: Apfel, Birne etc.",1,false),
  Question("Jeder Spieler stellt sich der Gruppe vor und muss dabei eine Tatsache über sich teilen, die noch keiner aus der Gruppe wusste, wer es nicht schafft oder lügt, muss trinken.",1,false),
  Question("Jeder Spieler muss eine Sache nennen, die er noch nie gemacht hat und die anderen Spieler müssen raten, ob es stimmt oder lügt. Wer richtig liegt, darf 1 Schluck verteilen.",1,false),
  Question("Jeder Spieler muss eine Sache Nennen, die er besonders gut kann und die anderen Spieler müssen raten, ob das stimmt oder lügt. Wer richtig liegt, darf 1 Schluck verteilen",1,false),
  Question("PERSON, verteile einen Schluck für jeden Buchstaben in deinem Namen",1,false),
  Question("PERSON, verteile einen Schluck, wenn du heute nicht mit einer Jogginghose hier bist.",1,false),
  Question("Ich habe noch nie: Jeder Teilnehmer macht eine Aussage, die mit 'Ich habe noch nie'",1,false),
  Question('Wahr oder falsch: Eine Person macht eine Aussage und die anderen müssen entscheiden, ob sie wahr oder falsch ist. Jedes Mal, wenn sie sich irren, müssen sie einen Schluck trinken.',1,false),
  Question("Drei Wahrheiten und eine Lüge: PERSON macht vier Aussagen, von denen drei wahr und eine falsch sind. Die anderen müssen raten, welche Aussage die Lüge ist. Jedes Mal, wenn sie sich irren, müssen sie einen Schluck trinken.",1,false),
  Question("Wahr oder falsch: Mache macht eine Aussage und die anderen müssen entscheiden, ob sie wahr oder falsch ist. Jedes Mal, wenn sie sich irren, müssen sie einen Schluck trinken.",1,false),
  Question("Wahrheitsfragen: Jeder Teilnehmer stellt einer anderen Person eine persönliche Frage, die diese beantworten muss. Sonst muss die Person 3 trinken",1,false),
  Question("Komplimente: Jeder Teilnehmer muss einem anderen Teilnehmer ein Kompliment machen. Wenn jemand kein Kompliment machen kann oder will, muss er einen Schluck trinken.",1,false),
  Question("Nenne drei Dinge, die du noch nie gemacht hast. Jedes Mal, wenn jemand in der Gruppe diese Sache schon gemacht hat, muss er oder sie trinken.",1,false),
  Question("PERSONEN, wechselt die Sitzplätze im Uhrzeigersinn",1,false),
  Question("PERSONEN, ihr seid jetzt eine Gang, einer für alle, alle für einen",1,false),
  Question("PERSON1, wähle einen Trinkpartner. Die Beziehung beruht auf Gegenseitigkeit.",1,false),
  Question("Trink selber einen Shot",1,false),
  Question("7 to HEAVEN",1,false),
  Question("Zeig jeden Mitspieler das 5. letzte Bild auf dem Smartphone",1,false),
  Question("PERSON1, speichere PERSON2 mit einem grünen Herz ein.",1,false),
];

List<Question> questionsForSingles = <Question>[
  Question("PERSON1 küsse PERSON2 auf die Wange.", 1, false),
  Question("PERSON1 trinkt mit PERSON2, PERSON2 entscheidet, was getrunken wird.", 1, false),
  Question("PERSON1 trinke mit PERSON2 einen überkreuzten Shot", 1, false),
  Question("PERSON1 und PERSON2, kreiert einen zusammen einen Begrüßungshandschlag und behaltet es zukünfig bei.", 1, false),
  Question("PERSON1, tausche den Sitzplatz mit dem Mitspieler links von PERSON2", 1, false),
];

List<Question> questions2 = <Question>[];

List<Person> personen = <Person>[
  Person("Host", true, false, true),
];

List<Question> createdCustomQuestions = <Question>[];

void init() {
  getInitQuestions();
  createDrinkyDrinkyCards();
  createQuestionsForSingle();
  createQuestions();
  createdCustomQuestions.shuffle();
}

void createQuestions() {
  int counter = 2;
  for (int i = 0; i < counter; i++) {
    for (var value in questionsMultipleTimes) {
      generateQuestions(value);
    }
    }
  for (var value in questions2) {
    generateQuestions(value);
  }
}

void getInitQuestions() {
  createdCustomQuestions.clear();
  questions2.clear();

  for (var value in questionsMultipleTimes) {
    questions2.add(value);
  }
}

void createQuestionsForSingle() {
  List<Person> singleList = <Person>[];
  List<Person> ausgewaehltenZwei = <Person>[];
  personen.forEach((element) {
    if (element.isSingle) {
      singleList.add(element);
    }
  });

  singleList.shuffle();

  bool guyAvailable = false;
  bool ladyAvailable = false;

  singleList.forEach((element) {
    if (element.isMan) {
      guyAvailable = true;
    } else {
      ladyAvailable = true;
    }
  });
  if (guyAvailable && ladyAvailable) {
    Person guy = singleList.firstWhere((element) => element.isMan);
    Person lady = singleList.firstWhere((element) => !element.isMan);
    ausgewaehltenZwei.addAll([guy, lady]);
    int i = 2;

    for (int i1 = 0; i1 < i; i1++) {
      for (var question in questionsForSingles) {
        generateQuestionForSingles(question, ausgewaehltenZwei);
      }
    }

  }
}

void createDrinkyDrinkyCards() {
  addEveryoneDrinks();
  addRandomPeopleDrinks();
}

void addRandomPeopleDrinks() {
  List<Person> random = <Person>[];
  List<String> names = <String>[];

  int counter = 3;
  for (int i1 = 0; i1 < counter; i1++) {
    for (int i = 0; i < (personen.length / 2).ceil(); i++) {
      names.add(getRandomPerson(random).name);
    }
  }


  String text = names.join(", ");
  String quest = "PERSONEN - jeder trinkt 2.";
  quest = quest.replaceAll("PERSONEN", text);

  Question question = Question(quest, 1, true);
  createdCustomQuestions.add(question);
}

void addEveryoneDrinks() {
  int counter = (createdCustomQuestions.length / 4).ceil();

  for (int i = 0; i <= counter; i++) {
    createdCustomQuestions.add(Question("Alle trinken!", 2, true));
  }
}

void generateQuestionForSingles(
    Question question, List<Person> gewaehltePersonen) {
  gewaehltePersonen.shuffle();
  String text = question.text;
  Question q = Question("text", question.variant, question.special);
  q.text = text = text.replaceAll("PERSON1", gewaehltePersonen.first.name);
  q.text = text = text.replaceAll("PERSON2", gewaehltePersonen.last.name);
  createdCustomQuestions.add(q);
}

void generateQuestions(Question question) {
  if (question.text.contains("PERSON")) {
    List<Person> gewaehltePersonen = <Person>[];
    gewaehltePersonen.clear();
    String text = question.text;

    RegExp regExp = RegExp("PERSON");
    int count = regExp.allMatches(text).length;

    Question q = Question("", question.variant, question.special);
    for (int counter = 1; counter <= count; counter++) {
      q.text = text = text.replaceAll(
          "PERSON$counter", getRandomPerson(gewaehltePersonen).name);
    }
    createdCustomQuestions.add(q);
  } else {
    createdCustomQuestions.add(question);
  }
}

Person getRandomPerson(List<Person> gewaehltePersonen) {
  int random = Random().nextInt(personen.length);
  Person person = personen.elementAt(random);
  if (!gewaehltePersonen.contains(person)) {
    gewaehltePersonen.add(person);
    return person;
  }

  return getRandomPerson(gewaehltePersonen);
}
