
import 'package:flutter/cupertino.dart';
import 'data.dart';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlipCardGame extends StatefulWidget {
  final Level level1;
  const FlipCardGame(this.level1);
  @override
  State<FlipCardGame> createState() =>  _FlipCardGameState(level1);
}

class _FlipCardGameState extends State<FlipCardGame> {
  _FlipCardGameState(this.level);
  Level level;
  int previousIndex = -1;
  bool flip = false;
  bool start = false;
  bool wait = false;
  bool? isFinished;
  Timer? timer;
  int? left; 
  List<dynamic>? data;
  List<bool>? cardFlips;
 List<GlobalKey<FlipCardState>>? cardstatekeys;
  int time = 5;
 Widget getItem(int index){
return Container(
  decoration: BoxDecoration(
color: Colors.grey[100],
boxShadow: [BoxShadow(
  color: Colors.black45,
  blurRadius: 3,
  spreadRadius: 0.8,
  offset: Offset(2.0, 1)
)],
    borderRadius: BorderRadius.circular(5),
  ),
  margin: EdgeInsets.all(4.0),
  child: Image.asset(data![index]),
);
 }
 StartTimer(){
  timer =Timer.periodic(Duration(seconds: 1), (timer) {
    setState(() {
      time = time-1;
    });
   });
 }
 void restart(){
  StartTimer();
  data = getSourceArray(level);
  cardFlips = getInitialItemState(level);
  cardstatekeys = getCardStateKeys(level);
  time = 5;
  left = (data!.length ~/ 2);
  isFinished = false;
  Future.delayed(Duration(seconds: 6),(){
    setState(() {
      start = true;
      timer!.cancel();
    });
  });
 }
 @override
  void initState() {
    super.initState();
    restart();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
      return isFinished! ? Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
                  setState(() {
                    restart();
                  });
                },
            child: Container(
              height: 50,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(24),
              ),
              child: 
               Text("replay",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,fontWeight: FontWeight.w500
                ),),
              ),
          ),
        ),
        )
      :Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                Padding(padding: EdgeInsets.all(16.0)
                ,child: time > 0 ? Text("$time",style: Theme.of(context).textTheme.bodyLarge,): Text("left:$left",style: Theme.of(context).textTheme.bodyLarge,),
                ),
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.builder(
                  shrinkWrap: true,
                    itemCount: data!.length,
                     physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)
                  , itemBuilder:(context, index) =>
                   start ? FlipCard(
                    key: cardstatekeys![index],
                    onFlip: () {
                     if(!flip) {
                      flip = true;
                      previousIndex = index;
                      }else{
                        flip = false;
                        if(previousIndex != index){
                          if(data![previousIndex] != data![index]){
                            wait = true;
                            Future.delayed(Duration(milliseconds: 1500),
                            (){
                              cardstatekeys![previousIndex].currentState!.toggleCard();
                              previousIndex =index;
                              cardstatekeys![previousIndex].currentState!.toggleCard();
                              
                                Future.delayed(
                                  Duration(milliseconds: 160),
                                (){
                                  setState(() {
                                  wait = false;
                                });
                                });
            
                            });
                          }
                          else{
                            cardFlips![previousIndex]= false;
                            cardFlips![index] = false ;
                            print(cardFlips);
                            setState(() {
                              left =- 1;
                            });
                            if(cardFlips!.every((t) => t ==false)){
                              print("won");
                              Future.delayed(Duration(milliseconds: 160),
                              (){
                                setState(() {
                                   isFinished = true;
                                   start = false;
                                });
                              }
                              );
                            }
                          }
                        }
                      }
                                  setState(() {});

                    },
                  back:  getItem(index),
                    front: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 3,
                          spreadRadius: 0.8,
                          offset: Offset(2.0, 1)
                        )
                      ]
                  ), 
                      margin:EdgeInsets.all(4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/animalspics/quest.png"),
                      ),
                  ),
                  flipOnTouch: wait ? false:cardFlips![index],
                  direction: FlipDirection.HORIZONTAL,
                  ):getItem(index)
                  ),
                
             ) ]
             ),
            ),
          )
        );
  }
}