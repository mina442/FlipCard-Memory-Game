import 'package:flip_card2/flip_card_game.dart';
import 'package:flip_card2/models/derails.dart';
import 'package:flutter/material.dart';
import 'data.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<Widget> genratestars(int no){
  List<Widget> icons= [];
  for(int i =0 ; i< no ;i++){
    icons.insert(i, Icon(Icons.star,
    color: Colors.yellow,));
  }
  return icons;
}
List<Details>list=[
  Details("Easy", Colors.green, Colors.green[300]!,1,FlipCardGame(Level.Easy)),
  Details("Medium", Colors.orange, Colors.orange[300]!,2,FlipCardGame(Level.Medium)),
  Details("Hard", Colors.red, Colors.red[300]!,3,FlipCardGame(Level.Hard)),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
           itemCount: list.length,
          itemBuilder:(context, index) => GestureDetector(
            onTap:() { Navigator.push(context, MaterialPageRoute(builder:(context) => (list[index].goto)!,));},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:list[index].secondaryColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [BoxShadow(
                      blurRadius: 4,
                      color: Colors.black45,
                      spreadRadius: 0.5,
                      offset: Offset(3, 4)
                    )] ) ,
                  ),
                  Container(
                    height:90,
                    width:double.infinity,
                     decoration: BoxDecoration(
                          color: list[index].primaryColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.black12,
                                spreadRadius: 0.3,
                                offset: Offset(
                                  5,
                                  3,
                                ))
                          ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child:
                         Text(list[index].name,style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(1, 2),
                            ),
                            Shadow(
                               color: Colors.green,
                              blurRadius: 2,
                              offset: Offset(0.5,2),
                            )
                          ]
                        ),),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: genratestars(list[index].noOfstar),
                           )
                        ],
                      ),
                      
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
          }
  }