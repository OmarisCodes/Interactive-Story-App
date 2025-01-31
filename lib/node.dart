import 'package:hive/hive.dart';
part 'node.g.dart';

@HiveType(typeId: 0)
class Node {
  @HiveField(0)
  int nodeID;
  @HiveField(1)
  int option1;
  @HiveField(2)
  int option2;
  @HiveField(3)
  int option3;
  @HiveField(4)
  String description;
  @HiveField(5)
  String question;
  @HiveField(6)
  String prompt1;
  @HiveField(7)
  String prompt2;
  @HiveField(8)
  String prompt3;
  @HiveField(9)
  int score1;
  @HiveField(10)
  String health;
  @HiveField(11)
  String image1;
  @HiveField(12)
  String image2;
  @HiveField(13)
  String audioUrl;

  Node(
      this.nodeID,
      this.option1,
      this.option2,
      this.option3,
      this.description,
      this.question,
      this.prompt1,
      this.prompt2,
      this.prompt3,
      this.score1,
      this.health,
      this.image1,
      this.image2,
      this.audioUrl);
}
