import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Color lightBlue = Color(0xff403b58);
  static Color darkBlue = Color.fromARGB(255, 6, 24, 38);
  static Color lightColor = Colors.white;
  String Player_x = "✖️";
  String Player_y = "⭕";
  late String curr;
  late List<String> grid;
  @override
  void initState() {
    curr = Player_x;
    grid = ["", "", "", "", "", "", "", "", ""];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "TIC-TAC-TOE ⭕✖️",
            style: TextStyle(
                color: lightColor, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          elevation: 5,
          shadowColor: Color.fromARGB(255, 195, 194, 237),
          backgroundColor: Colors.black),
      body: Column(children: [
        SizedBox(
          height: 50,
        ),
        Container(
          height: 120,
          width: 340,
          child: Card(
            shadowColor: Color.fromARGB(255, 216, 215, 255),
            elevation: 10,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Text("Player $curr's turn",
                  style: TextStyle(
                      color: lightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 45)),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Center(
          child: Container(
            height: 390,
            width: 390,
            child: Card(
              elevation: 15,
              shadowColor: Color.fromARGB(255, 195, 194, 237),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.all(20),
              color: lightBlue,
              child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: 9,
                  itemBuilder: ((context, index) {
                    return _box(index);
                  })),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _box(int index) {
    return InkWell(
        onTap: () {
          if (grid[index].isNotEmpty) return;
          setState(() {
            grid[index] = curr;
            checkForWinner();
            if (curr == Player_x)
              curr = Player_y;
            else
              curr = Player_x;
          });
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black,
            ),
            child: Center(
                child: Text(
              grid[index].toString(),
              style: TextStyle(
                  fontSize: 50, color: Color.fromARGB(255, 189, 241, 105)),
            ))));
  }

  checkForWinner() {
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var x in winningList) {
      String pt1 = grid[x[0]];
      String pt2 = grid[x[1]];
      String pt3 = grid[x[2]];
      if (pt1.isNotEmpty) {
        if (pt1 == pt2 && pt1 == pt3) {
          // if (curr == Player_x)
          //   curr = Player_y;
          // else
          //   curr = Player_x;
          AwesomeDialog(
              borderSide: BorderSide(color: Colors.blue),
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              btnOkText: "Restart",
              title: "Player ${curr} Won!",
              btnOkOnPress: () {
                Restart();
              })
            ..show();
        }
      }
    }
    checkForDraw();
  }

  checkForDraw() {
    bool draw = true;
    for (var i in grid) {
      if (i.isEmpty) {
        draw = false;
        return;
      }
    }
    if (draw) {
      AwesomeDialog(
          borderSide: BorderSide(color: Colors.blue),
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          btnOkText: "Restart",
          title: "It's a Draw!",
          btnOkOnPress: () {
            Restart();
          })
        ..show();
    }
    // showDialog(
    //     context: context,
    //     builder: ((ctx) => ResultBox("It's a DRAW!!!", Restart)));
  }

  Restart() {
    setState(() {
      curr = Player_x;
      grid = ["", "", "", "", "", "", "", "", ""];
    });
    // Navigator.pop(context);
  }
}
