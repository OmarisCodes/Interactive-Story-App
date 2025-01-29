import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'node.dart';

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
    String description = columns[3];
    String question = columns[4];
    String prompt1 = columns[5];
    String prompt2 = columns[6];
    int score1 = int.parse(columns[7]);
    int score2 = int.parse(columns[8]);

    Node myNode = Node(nodeID, option1, option2, description, question, prompt1,
        prompt2, score1, score2);
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
  late int nodeID;
  late int option1;
  late int option2;
  String description = "";
  String question = "";
  String prompt1 = "";
  String prompt2 = "";
  late int score1;
  late int score2;

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
          description = current.description;
          question = current.question;
          prompt1 = current.prompt1;
          prompt2 = current.prompt2;
          score1 = current.score1;
          score2 = current.score2;
        }
      });
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
                alignment: const Alignment(0.0, -0.9),
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
              Align(
                alignment: const Alignment(0.0, -0.7),
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
              Align(
                alignment: const Alignment(-0.5, 0.0),
                child: MaterialButton(
                  onPressed: () {},
                  color: const Color(0xff3a21d9),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 40,
                  minWidth: 140,
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
            ],
          ),
        ),
      ),
    );
  }
}
