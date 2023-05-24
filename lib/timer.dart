import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';



class PomodoroTimer extends StatefulWidget {

  final int activityTime;
  final int breakTime;

  PomodoroTimer({required this.activityTime, required this.breakTime});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer>
  with TickerProviderStateMixin {
    late AnimationController _animationController;
    late Animation<double> _animation;
    late TextEditingController _workTimeController;
    late TextEditingController _breakTimeController;

  int _currentTime = 0;
  int _totalTime = 0;

  String _timerText = '';
  int _workTime = 25 * 60; // Tempo de trabalho padrão: 25 minutos (em segundos)
  int _breakTime = 5 * 60; // Tempo de intervalo padrão: 5 minutos (em segundos)

@override
void initState() {
  super.initState();
  _totalTime = widget.activityTime;
  _currentTime = widget.activityTime;
  
  _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: _totalTime),
  );

  _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController)
    ..addListener(() {
      setState(() {});
    });

  _animationController.reverse(from: 1.0);
    _workTimeController = TextEditingController(text: '25');
    _breakTimeController = TextEditingController(text: '5');
}

  @override
  void dispose() {
    _animationController.dispose();
    _workTimeController.dispose();
    _breakTimeController.dispose();
    super.dispose();
  }

  void startTimer() {
  setState(() {
    _currentTime = _totalTime;
  });

  _animationController.duration = Duration(seconds: _currentTime);
  _animationController.reset();
  _animationController.reverse(from: 1.0);
}

  void startBreakTime() {
    // int duration = _animationController.duration?.inSeconds ?? 0;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(minutes: widget.breakTime),
    );
    _animationController.reverse(from: 1.0);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // O tempo de intervalo terminou, iniciar o próximo ciclo de trabalho
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Pomodoro'),
            content: Text('Tempo de intervalo terminou!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  startTimer();
                },
                child: Text('Iniciar próximo ciclo'),
              ),
            ],
          ),
        );
      }
    });
    setState(() {
      _timerText = 'Tempo de intervalo';
    });
  }

  void setWorkTime(int minutes) {
    setState(() {
      _workTime = minutes * 60;
    });
  }

  void setBreakTime(int minutes) {
    setState(() {
      _breakTime = minutes * 60;
    });
  }


  Widget _buildCircularTimer() {
    return CircularPercentIndicator(
      radius: 200.0,
      lineWidth: 10.0,
      percent: _animation.value,
      center: Text(
        '$_currentTime',
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
                padding: const EdgeInsets.only(bottom: 50), // Adicione um espaçamento entre as notificações
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
                            onPressed: () {
                              startTimer();
                            },
                            child: Text('Iniciar Timer'),
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

