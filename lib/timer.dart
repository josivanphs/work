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
  int _currentTimeRemainingBreak = 0;

  int _elapsedSeconds = 0;
  bool _isActivityTime = true;
  // ignore: unused_field
  String _timerText = '';
  bool isCountingDown = false;
  bool loop = true;

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
  _currentTimeRemainingBreak = widget.breakTime;


  
  _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: _totalTime),
  );

  _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController)
    ..addListener(() {
    });
}



  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }


  int calculateTimeRemaining() {
    if (_isActivityTime) {
      return widget.activityTime - _elapsedSeconds -1;
    } else {
      return widget.breakTime - _elapsedSeconds -1;
    }
  }


  void timer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    setState(() {
      if (_isActivityTime) {

        if (_currentTimeRemaining > 0) {
          _currentTimeRemaining = calculateTimeRemaining(); // Atualize o tempo restante aqui
          _elapsedSeconds++; // Atualize os segundos decorridos
        }
      }
      else {
        if (_currentTimeRemainingBreak > 0) {
          _currentTimeRemainingBreak = calculateTimeRemaining(); // Atualize o tempo restante aqui
          _elapsedSeconds++; // Atualize os segundos decorridos
        }
      }
    });

  // _animationController.reverse(from: 1.0);
  });

  }



  void startTimer() {
      setState(() {
        _currentTimeRemaining = widget.activityTime;
        _isActivityTime = true;
        _elapsedSeconds = 0;
      });
  _animationController.duration = Duration(seconds: widget.activityTime);
  // _animationController.reset();
  _animationController.reverse(from: 1.0).whenComplete(() async {
    // A animação terminou, chame a função startBreakTime()
    await Future.delayed(Duration(seconds: 1));

    if (widget.auto) {

      startBreakTime();
    }
  });
  }

  void stopTimer() {
    _timer.cancel();
    _currentTimeRemaining = 0;
    _elapsedSeconds = 0;
    _animationController.reset();
    _animationController.stop();
  }

  void startBreakTime() {
      setState(() {
        _currentTimeRemainingBreak = widget.breakTime;
        _isActivityTime = false;
        _elapsedSeconds = 0;
        
      });
      _animationController.duration = Duration(seconds: widget.breakTime);
      // _animationController.reset();
      _animationController.reverse(from: 1.0).whenComplete(() async {
        await Future.delayed(Duration(seconds: 1));
    // A animação terminou, chame a função startBreakTime()
        if (widget.auto) {

          startTimer();
        }
    });
    }


  Widget _buildCircularTimer() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return CircularPercentIndicator(
          radius: 200.0,
          lineWidth: 30.0,
          percent: _animation.value,
          center: Text(
            _isActivityTime ? '$_currentTimeRemaining' : '$_currentTimeRemainingBreak',
            style: TextStyle(fontSize: 48.0),
          ),
          progressColor: _isActivityTime ? Colors.blue : Colors.green,
        );
      }
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
                            },
                            child: Text((_isActivityTime) ? 'Iniciar Atividade' : 'Iniciar Intervalo'),
                          ),
                      ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!isCountingDown)
                          {
                            startTimer();
                            timer();
                          }
                          else{
                            stopTimer();
                          }
                          setState(() {
                            isCountingDown = !isCountingDown;
                          });
                        },
                        child: Text(
                          isCountingDown ? 'Parar' : 'Iniciar',
                          style: const TextStyle(
                              fontFamily: 'Baloo',
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),),
                    ],
                  ),
              ),
            ],
          ),
        ),
      );
    }
  }

