import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'node.dart';
import 'package:audioplayers/audioplayers.dart';

List<Node> nodes = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //load data
  String file = "perec_map_24.csv";
  String csvData = await rootBundle.loadString(file);
  print(csvData);

  List<String> rows = csvData.split("\r\n");

  for (String row in rows) {
    List<String> columns = row.split(",");

    int nodeID = int.parse(columns[0]);
    int option1 = int.parse(columns[1]);
    int option2 = int.parse(columns[2]);
    int option3 = int.parse(columns[3]);
    String description = columns[4];
    String question = columns[5];
    String prompt1 = columns[6];
    String prompt2 = columns[7];
    String prompt3 = columns[8];
    int score1 = int.parse(columns[9]);
    int score2 = int.parse(columns[10]);
    String image1 = columns[11];
    String image2 = columns[12];
    String audioUrl = columns[13];

    Node myNode = Node(nodeID, option1, option2, option3, description, question,
        prompt1, prompt2, prompt3, score1, score2, image1, image2, audioUrl);
    nodes.add(myNode);
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
  playAudio() {
    if (audioUrl.isNotEmpty) {
      String localFilePath = 'assets/$audioUrl';
      audioPlayer.play(localFilePath, isLocal: true);
    }
  }

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
  late int score2;
  String image1 = "";
  String image2 = "";
  String audioUrl = "";

  @override
  void initState() {
    super.initState();
    //Place code here to initilise server objects

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        //Place Cide here you want to execute immediately after
        //The Ui is buikt
        Node current = nodes.first;
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
          score2 = current.score2;
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
      for (Node next in nodes) {
        if (next.nodeID == option1) {
          nodeID = next.nodeID;
          option1 = next.option1;
          option2 = next.option2;
          option3 = next.option3;
          description = next.description;
          question = next.question;
          prompt1 = next.prompt1;
          prompt2 = next.prompt2;
          prompt3 = next.prompt3;
          score1 = next.score1;
          score2 = next.score2;
          image1 = next.image1;
          image2 = next.image2;
          audioUrl = next.audioUrl;
          playAudio();
          break;
        }
      }
    });
  }

  void option2Handler() {
    setState(() {
      if (option2 == -1) {
        description = "NAVIGATION ENDED!";
        question = "";
      }
      for (Node next in nodes) {
        if (next.nodeID == option2) {
          nodeID = next.nodeID;
          option1 = next.option1;
          option2 = next.option2;
          option3 = next.option3;
          description = next.description;
          question = next.question;
          prompt1 = next.prompt1;
          prompt2 = next.prompt2;
          prompt3 = next.prompt3;
          score1 = next.score1;
          score2 = next.score2;
          image1 = next.image1;
          image2 = next.image2;
          audioUrl = next.audioUrl;
          playAudio();
          break;
        }
      }
    });
  }

  void option3Handler() {
    setState(() {
      if (option3 == -1) {
        description = "NAVIGATION ENDED!";
        question = "";
      }
      for (Node next in nodes) {
        if (next.nodeID == option2) {
          nodeID = next.nodeID;
          option1 = next.option1;
          option2 = next.option2;
          option3 = next.option3;
          description = next.description;
          question = next.question;
          prompt1 = next.prompt1;
          prompt2 = next.prompt2;
          prompt3 = next.prompt3;
          score1 = next.score1;
          score2 = next.score2;
          image1 = next.image1;
          image2 = next.image2;
          audioUrl = next.audioUrl;
          playAudio();
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3e87c5),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(0.0, 0.5),
                child: image1.isNotEmpty
                    ? Image.asset(
                        image1,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )
                    : SizedBox.shrink(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: image2.isNotEmpty
                    ? Image.asset(
                        image2,
                        height: 40,
                        width: MediaQuery.of(context).size.width,
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
                      fontSize: 34,
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
                        fontSize: 34,
                        color: Color(0xffffffff),
                      ),
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
                    height: 100,
                    minWidth: 200,
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
                  alignment: const Alignment(0.8, 0.95),
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
                    height: 100,
                    minWidth: 200,
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
                  alignment: const Alignment(-0.8, 0.95),
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
                    height: 100,
                    minWidth: 200,
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

                // Align(
                //   alignment: const Alignment(0.5, 0.9),
                //   child: MaterialButton(
                //     onPressed: () {
                //       option2Handler();
                //     },
                //     color: const Color(0xff3a21d9),
                //     elevation: 0,
                //     shape: const RoundedRectangleBorder(
                //       borderRadius: BorderRadius.zero,
                //     ),
                //     textColor: const Color(0xfffffdfd),
                //     height: 100,
                //     minWidth: 200,
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //     child: Text(prompt2,
                //         style: const TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w400,
                //           fontStyle: FontStyle.normal,
                //         )),
                //   ),
                // ),