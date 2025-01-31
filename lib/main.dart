import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'node.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

late Box<Node> box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NodeAdapter());
  box = await Hive.openBox<Node>('perec_map_24.csv');

  //load data
  String file = "perec_map_24.csv";
  String csvData = await rootBundle.loadString(file);
  print(csvData);

  List<String> rows = csvData.split("\r\n");

  for (String row in rows) {
    List<String> itemInRow = row.split(",");

    Node node = Node(
      int.parse(itemInRow[0]),
      int.parse(itemInRow[1]),
      int.parse(itemInRow[2]),
      int.parse(itemInRow[3]),
      itemInRow[4],
      itemInRow[5],
      itemInRow[6],
      itemInRow[7],
      itemInRow[8],
      int.parse(itemInRow[9]),
      itemInRow[10],
      itemInRow[11],
      itemInRow[12],
      itemInRow[13],
    );

    int key = int.parse(itemInRow[0]);
    box.put(key, node);
  }

  runApp(
    const MaterialApp(
      home: MyFlutterFramework(),
    ),
  );
}

class MyFlutterFramework extends StatefulWidget {
  const MyFlutterFramework({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyFlutterInterface();
  }
}

class MyFlutterInterface extends State<MyFlutterFramework> {
  final audioPlayer = AudioPlayer();
  late int nodeID;
  late int option1;
  late int option2;
  late int option3;
  String description = "";
  String question = "";
  String prompt1 = "";
  String prompt2 = "";
  String prompt3 = "";
  late int score1;
  String health = "";
  String image1 = "";
  String image2 = "";
  String audioUrl = "";

  playAudio() {
    if (audioUrl.isNotEmpty) {
      String localFilePath = 'assets/$audioUrl';
      audioPlayer.play(localFilePath, isLocal: true);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        Node? current = box.get(1);
        if (current != null) {
          nodeID = current.nodeID;
          option1 = current.option1;
          option2 = current.option2;
          option3 = current.option3;
          description = current.description;
          question = current.question;
          prompt1 = current.prompt1;
          prompt2 = current.prompt2;
          prompt3 = current.prompt3;
          score1 = current.score1;
          health = current.health;
          image1 = current.image1;
          image2 = current.image2;
          audioUrl = current.audioUrl;
        }
      });
    });
  }

  void option1Handler() {
    setState(() {
      if (option1 == -1) {
        description = "NAVIGATION ENDED!";
        question = "";
      }
      Node? nextNode = box.get(option1);
      if (nextNode != null) {
        nodeID = nextNode.nodeID;
        option1 = nextNode.option1;
        option2 = nextNode.option2;
        option3 = nextNode.option3;
        description = nextNode.description;
        question = nextNode.question;
        prompt1 = nextNode.prompt1;
        prompt2 = nextNode.prompt2;
        prompt3 = nextNode.prompt3;
        score1 = nextNode.score1;
        health = nextNode.health;
        image1 = nextNode.image1;
        image2 = nextNode.image2;
        audioUrl = nextNode.audioUrl;
        playAudio();
      }
    });
  }

  void option2Handler() {
    setState(() {
      if (option2 == -1) {
        description = "NAVIGATION ENDED!";
        question = "";
      }
      Node? nextNode = box.get(option2);
      if (nextNode != null) {
        nodeID = nextNode.nodeID;
        option1 = nextNode.option1;
        option2 = nextNode.option2;
        option3 = nextNode.option3;
        description = nextNode.description;
        question = nextNode.question;
        prompt1 = nextNode.prompt1;
        prompt2 = nextNode.prompt2;
        prompt3 = nextNode.prompt3;
        score1 = nextNode.score1;
        health = nextNode.health;
        image1 = nextNode.image1;
        image2 = nextNode.image2;
        audioUrl = nextNode.audioUrl;
        playAudio();
      }
    });
  }

  void option3Handler() {
    setState(() {
      if (option3 == -1) {
        description = "NAVIGATION ENDED!";
        question = "";
      }
      Node? nextNode = box.get(option3);
      if (nextNode != null) {
        nodeID = nextNode.nodeID;
        option1 = nextNode.option1;
        option2 = nextNode.option2;
        option3 = nextNode.option3;
        description = nextNode.description;
        question = nextNode.question;
        prompt1 = nextNode.prompt1;
        prompt2 = nextNode.prompt2;
        prompt3 = nextNode.prompt3;
        score1 = nextNode.score1;
        health = nextNode.health;
        image1 = nextNode.image1;
        image2 = nextNode.image2;
        audioUrl = nextNode.audioUrl;
        playAudio();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(0.0, 0.0),
                child: image1.isNotEmpty
                    ? Image.asset(
                        image1,
                        height: MediaQuery.of(context).size.height,
                        width: 1400,
                        fit: BoxFit.cover,
                      )
                    : SizedBox.shrink(),
              ),
              if (image2 != "-1")
                Align(
                  alignment: const Alignment(0.0, 0.7),
                  child: image2.isNotEmpty
                      ? Image.asset(
                          image2,
                          height: 40,
                          width: 400,
                          fit: BoxFit.cover,
                        )
                      : SizedBox.shrink(),
                ),
              Align(
                alignment: const Alignment(0.0, -0.9),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
              if (question != "-1")
                Align(
                  alignment: const Alignment(0.0, -0.7),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      question,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              if (health != "-1")
                Align(
                  alignment: const Alignment(0.0, 0.7),
                  child: Text(
                    health,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              if (option1 != -1)
                Align(
                  alignment: const Alignment(0.0, 0.95),
                  child: MaterialButton(
                    onPressed: () {
                      option1Handler();
                    },
                    color: const Color.fromARGB(255, 0, 0, 0),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    textColor: const Color(0xfffffdfd),
                    height: 80,
                    minWidth: 160,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(prompt1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                ),
              if (option2 != -1)
                Align(
                  alignment: const Alignment(0.5, 0.95),
                  child: MaterialButton(
                    onPressed: () {
                      option2Handler();
                    },
                    color: const Color.fromARGB(255, 0, 0, 0),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    textColor: const Color(0xfffffdfd),
                    height: 80,
                    minWidth: 160,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(prompt2,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                ),
              if (option3 != -1)
                Align(
                  alignment: const Alignment(-0.5, 0.95),
                  child: MaterialButton(
                    onPressed: () {
                      option3Handler();
                    },
                    color: const Color.fromARGB(255, 0, 0, 0),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    textColor: const Color(0xfffffdfd),
                    height: 80,
                    minWidth: 160,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(prompt3,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
