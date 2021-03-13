import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

int m_time = 240;
var readyness_times = <String,int>{
  "M":0,
  "MW":0,
  "W":0,
  "WD":0,
};

void updateTimes()
{
  int i = 0;
  readyness_times.forEach((key, value)
  {
    readyness_times[key] = m_time + i;
    i = i+15;
  });
}

void main()
{
  updateTimes();
  MaterialApp willis = new MaterialApp(
    home:Willis(),
  );
  runApp(willis);
}

class Willis extends StatefulWidget
{
  @override
  _WillisState createState() => _WillisState();
}

class _WillisState extends State<Willis>
{
  void Inc()
  {
    setState(() {m_time += 10;});
    updateTimes();
  }

  void Dec()
  {
    setState(() {m_time -= 10;});
    updateTimes();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Row
          (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              onPressed: () => Dec(),
              child: Container(
                alignment: Alignment.center,
                child: Text("-10",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text("${m_time}"),
            OutlinedButton(
              onPressed: () => Inc(),
              child: Container(
                alignment: Alignment.center,
                child: Text("+10",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Timers(),
    );
  }
}

class Timers extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Col(),
        Col(),
      ],
    );
  }
}

class Col extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MiniTimer(),
        MiniTimer(),
        MiniTimer(),
      ],
    );
  }
}

class MiniTimer extends StatefulWidget
{
  @override
  _MiniTimerState createState() => _MiniTimerState();
}

class _MiniTimerState extends State<MiniTimer>
{
  int my_time = 0;
  Timer timer;

  _MiniTimerState()
  {
    timer = Timer.periodic(Duration(seconds: 1), (timer)
    {
      setState(()
      {
        if (this.my_time > 0)
          this.my_time--;
      });
    });
  }

  void StartTimer(int time)
  {
    setState(()
    {
      my_time = time;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("${this.my_time}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildLvlButton("M"),
              buildLvlButton("MW"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildLvlButton("W"),
              buildLvlButton("WD"),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(20.0),
    );
  }

  Widget buildLvlButton(String lvl)
  {
    return OutlinedButton(
      onPressed: () => this.StartTimer(readyness_times[lvl]),
      child: Container(
        alignment: Alignment.center,
        child: Text(lvl,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
