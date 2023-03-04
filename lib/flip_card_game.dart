
import 'package:flutter/cupertino.dart';
import 'data.dart';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlipCardGame extends StatefulWidget {
  final Level level;
  const FlipCardGame(
    this.level
    );
  @override
  State<FlipCardGame> createState() =>  _FlipCardGameState(
    level
    );
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
  int? tries; 
int? target; 
  int? score;
  List<dynamic>? data;
  List<bool>? cardFlips;
 List<GlobalKey<FlipCardState>>? cardstatekeys;
  int time = 5;
//  Widget getItem(int index){
// return Container(
// //   decoration: BoxDecoration(
// // color: Colors.grey[100],
// // boxShadow: [BoxShadow(
// //   color: Colors.black45,
// //   blurRadius: 3,
// //   spreadRadius: 0.8,
// //   offset: Offset(2.0, 1)
// // )],
// //     borderRadius: BorderRadius.circular(5),
// //   ),
// //   margin: EdgeInsets.all(4.0),
// //   child: Image.asset(
//                       child:
//Container(
//                       width: 200,
//                       height: 200,
//                         decoration: BoxDecoration(
//                       color:Color(0xff292a3e),
//                       borderRadius: BorderRadius.circular(10),
//                       image:DecorationImage(image: AssetImage (data![index]),
// )))
// );
//  }
 StartTimer(){
  timer =Timer.periodic(Duration(seconds: 1), (timer) {
    setState(() {
      time = time-1;
    });
   });
 }
 void restart(){
  time = 5;
  data = getSourceArray(level);
  StartTimer();
  cardFlips = getInitialItemState(level);
  cardstatekeys = getCardStateKeys(level);
  left = (data!.length ~/ 2);
  target = (data!.length *100 ~/ 2);

  tries = 0;
  score = 0;
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
        

        appBar: AppBar(
          backgroundColor: Color(0xff292a3e),
          title: Text(' ${level.name} level'),
        elevation:0 ,
        ),
              backgroundColor: Color(0xff292a3e),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               if(level != Level.Easy) GestureDetector(
            onTap: () {
              if(level == Level.Medium)setState(() {
                    Navigator.push(context, MaterialPageRoute(
                builder:(context) => FlipCardGame(Level.Easy)));
                  });
                  else if(level == Level.Hard){
                    Navigator.push(context, MaterialPageRoute(
                      builder:(context) => FlipCardGame(Level.Medium)));
                }},
            child: Container(
              height: 50,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(24),
              ),
              child: 
               Text("previous",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,fontWeight: FontWeight.w500
                ),),
              ),
          ),
              SizedBox(height: 20,),
              GestureDetector(
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
              SizedBox(height: 20,),
               if(level != Level.Hard)GestureDetector(
            onTap: () {
              if(level == Level.Easy)setState(() {
                    Navigator.push(context, MaterialPageRoute(
                builder:(context) => FlipCardGame(Level.Medium)));
                  });
                  else if(level == Level.Medium){
                    Navigator.push(context, MaterialPageRoute(
                      builder:(context) => FlipCardGame(Level.Hard)));
                }},
            child: Container(
              height: 50,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(24),
              ),
              child: 
               Text("next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,fontWeight: FontWeight.w500
                ),),
              ),
          ),
            ],
          ),
        ),
        )
      :Scaffold(
        
        appBar: AppBar(
          backgroundColor: Color(0xff292a3e),
          title: Text(' ${level.name} level'),
        elevation:0 ,
        ),
              backgroundColor: Color(0xff292a3e),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                Padding(padding: EdgeInsets.all(16.0)
                ,child: time > 0 ? Text("$time",style:TextStyle(color: Colors.white),): 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("left:$left",style: TextStyle(color: Colors.white)),
                    SizedBox(width: 20,),
                     Text("score:$score",style: TextStyle(color: Colors.white)),
 SizedBox(width: 20,),
                     Text("tries:$tries",style: TextStyle(color: Colors.white)),
 SizedBox(width: 20,),
                     Text("target:$target",style: TextStyle(color: Colors.white)),

                  ],
                
                ),
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
                            wait = false;
                            Future.delayed(Duration(milliseconds: 1500),
                            (){
                              cardstatekeys![previousIndex].currentState!.toggleCard();
                              previousIndex =index;
                              cardstatekeys![previousIndex].currentState!.toggleCard();
                                if(score !> 0)
                                setState(() {
                              score = score!-100;
                            });
                            setState(() {
                               tries = tries!+1;});
                              
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
                              left = left!-1;
                              score = score!+100;
                              tries = tries!+1;

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
                  back: Container(
                      width: 309,
                      height: 474,
                        decoration: BoxDecoration(
                      color:Color(0xff292a3e),
                      borderRadius: BorderRadius.circular(10),
                      image:DecorationImage(image: AssetImage ("assets/face.png"),
)),
child: Center(
  child: Image.asset(data![index],width: 85,height: 85,)),
),
                  //  getItem(index),
                    front: Container(
                      width: 309,
                      height: 474,
                      child: Container(
                        decoration: BoxDecoration(
                      color:Color(0xff292a3e),
                      borderRadius: BorderRadius.circular(10),
                      image:DecorationImage(image: AssetImage("assets/back.png")),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black45,
                      //     blurRadius: 3,
                      //     spreadRadius: 0.8,
                      //     offset: Offset(2.0, 1)
                      //   )
                      // ]
                  ), 
                      margin:EdgeInsets.all(4.0),
                        // child: 
                        ),
                  ),
                  flipOnTouch: wait ? false:cardFlips![index],
                  direction: FlipDirection.HORIZONTAL,
                  )
                  :Container(
                      width: 309,
                      height: 474,
                        decoration: BoxDecoration(
                      color:Color(0xff292a3e),
                      borderRadius: BorderRadius.circular(10),
                      image:DecorationImage(image: AssetImage ("assets/face.png"),
)),
child: Center(
  child: Image.asset(data![index],width: 85,height: 85,)),
),
                  // getItem(index)
                  ),
                
             ) ]
             ),
            ),
          )
        );
  }
}