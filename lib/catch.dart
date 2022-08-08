import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CatchMe extends StatefulWidget {
  const CatchMe({Key? key}) : super(key: key);

  @override
  _CatchMeState createState() => _CatchMeState();
}
List<_head> _headList = List.generate(9, (index) => _head());

class _CatchMeState extends State<CatchMe> {
  Timer? countdown;
  Timer? headChange;
  static const maxSecound = 30;
  int secound = maxSecound;

  void countDownTimer(){
    countdown = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        secound --;
      });
      if(secound ==0)timer.cancel();
    });
  }

  void headChanger(){
    headChange = Timer.periodic(Duration(milliseconds: 800), (timer) {
      _headList.clear();
      _headList = List.generate(9, (index) => _head());
      setState(() {
        _headList[Random().nextInt(9)].visibility =true;
      });
      if (secound == 0)timer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
   countDownTimer();
    headChanger();
  }

  @override
  Widget build(BuildContext context) {
    String _appBarTitle = "Catch Me";
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body:   Column(
        children: [
          Expanded(
           flex: 1,
            child: Center(
            child: Text("Secound $secound",
            style: Theme.of(context).textTheme.headline4,
            ),
          ),
          ),
          Expanded(
              flex: 5,
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 9,
                  itemBuilder: (BuildContext context, int index){
                  return _headList[index];
             }
             )
              ),
          Expanded(child: Center(
            child: Text(
              "Score ${scoreUtility.score}",
              style: Theme.of(context).textTheme.headline4,
            ),
          ))
        ],
      ),
      floatingActionButton: Visibility(
        visible: secound == 0,
        child: FloatingActionButton.extended(onPressed: (){
          scoreUtility.score = 0;
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatchMe()));
          }, label: Text("Play Again")
        ),
      ),
    );
  }
}

class _head extends StatefulWidget {
   _head({Key? key,  this.visibility = false}) : super(key: key);
  bool visibility;

  @override
  _headState createState() => _headState();
}

class _headState extends State<_head> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      if(widget.visibility) scoreUtility().addScore();
    }, child: Visibility(
        child: Image.asset("assets/2.png"),
      visible: widget.visibility,
    ),
    style: ElevatedButton.styleFrom(
    primary: Colors.transparent,
    elevation: 0,
      onPrimary: Colors.transparent,
    )
    );
  }
}

class scoreUtility{
  static int score = 0;
  void addScore(){
    score ++;
  }
}