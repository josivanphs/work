// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';


class PomodoroTimer extends StatefulWidget {

  final int activityTime;
  final int breakTime;
  final bool auto;

  PomodoroTimer({required this.activityTime, required this.breakTime, required this.auto});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer>
  with TickerProviderStateMixin {
    late AnimationController _animationController;
    late Animation<double> _animation;
    late TextEditingController _workTimeController;
    late TextEditingController _breakTimeController;
  Timer _timer = Timer(Duration.zero, () {});
  int _currentTime = 0;
  int _totalTime = 0;
  int _currentTimeBreak = 0;
  int _totalTimeBreak = 0;
  int _currentTimeRemaining = 0;
  int _elapsedSeconds = 0;
  bool _isActivityTime = true;
  // ignore: unused_field
  String _timerText = '';
// Tempo de trabalho padrão: 25 minutos (em segundos)
// Tempo de intervalo padrão: 5 minutos (em segundos)

@override
void initState() {
  super.initState();


  _totalTime = widget.activityTime;
  _currentTime = widget.activityTime;
  _totalTimeBreak = widget.breakTime;
  _currentTimeBreak = widget.breakTime;
  _currentTimeRemaining = widget.activityTime;

  
  _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: _totalTime),
  );

  _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController)
    ..addListener(() {
    });

  // _animationController.reverse(from: 1.0);
}


  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }


  int calculateTimeRemaining() {
    if (_isActivityTime) {
      return widget.activityTime - _elapsedSeconds;
    } else {
      return widget.breakTime - _elapsedSeconds;
    }
  }

  void startTimer() {

  _currentTimeRemaining = widget.activityTime;
  _currentTime = _totalTime;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _isActivityTime = true;
        if (_currentTimeRemaining > 0) {
          _currentTimeRemaining = calculateTimeRemaining(); // Atualize o tempo restante aqui
          _elapsedSeconds++; // Atualize os segundos decorridos
        }
      });
  });


  _animationController.duration = Duration(seconds: _currentTime);
  _animationController.reset();
  _animationController.reverse(from: 1.0).whenComplete(() {
    // A animação terminou, chame a função startBreakTime()
    if (widget.auto) {
      startBreakTime();
    }
  });
  }

  void stopTimer() {
    _timer.cancel();
  }

  void startBreakTime() {
      setState(() {
        _currentTimeRemaining = widget.breakTime;
        _isActivityTime = false;
        _elapsedSeconds = 0;
      });
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            if (_currentTimeRemaining > 0) {
              _currentTimeRemaining = calculateTimeRemaining(); // Atualize o tempo restante aqui
              _elapsedSeconds++; // Atualize os segundos decorridos
            }
          });
      });


      _animationController.duration = Duration(seconds: _currentTimeBreak);
      _animationController.reset();
      _animationController.reverse(from: 1.0);
  }

  void setWorkTime(int minutes) {
    setState(() {
    });
  }

  void setBreakTime(int minutes) {
    setState(() {
    });
  }


  Widget _buildCircularTimer() {
    return CircularPercentIndicator(
      radius: 200.0,
      lineWidth: 10.0,
      percent: _animation.value,
      center: Text(
        '$_currentTimeRemaining',
        style: TextStyle(fontSize: 48.0),
      ),
      progressColor: Colors.blue,
    );
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 1), // Adicione um espaçamento entre as notificações
                child: 
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: 
                          _buildCircularTimer(),  
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: 150,
                        height: 30,
                        child:
                          ElevatedButton(
                            onPressed: (widget.auto) ? null : () {
                              if (_isActivityTime) {
                                startTimer();
                              } else {
                                startBreakTime();
                              }
                            },
                            child: Text((_isActivityTime) ? 'Iniciar Atividade' : 'Iniciar Intervalo'),
                          ),
                      )
                    ],
                  ),
              ),
            ],
          ),
        ),
      );
    }
  }

