import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'notifications.dart';
import 'timer.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double sliderValue = 0.0;
  double waterValue = 0.0;
  double waterValueMax = 0.0;
  double timer = 0;

  bool isCountingDown = false;
  bool waterButton = false;
  bool hintButton = false;
  bool notificationButton = false;

  bool autoButton = false;
  bool manualButton = true;


  TextEditingController activityTimeController = TextEditingController();
  TextEditingController breakTimeController = TextEditingController();
  int activityTime = 25; 
  int breakTime = 5; 

  List<String> notifications = [];

  void startNotifications() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        notifications.add('Nova notificação ${timer.tick}');
      });
    });
  }

  void removeNotification(String notification) {
    setState(() {
      notifications.remove(notification);
    });
  }


  @override
  void initState() {
    super.initState();
    startNotifications();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // A animação foi concluída, você pode realizar alguma ação aqui
        setState(() {
          isCountingDown = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void startAnimation() {
    setState(() {
      isCountingDown = true;
      _animationController.reset();
      _animationController.forward();
    });
  }

  void stopAnimation() {
    setState(() {
      isCountingDown = false;
      _animationController.reverse();
    });
  }

  @override
  StatefulWidget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/topo1.png',
                  fit: BoxFit.cover,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          size: 40,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Configuraçoes',
                                  style: TextStyle(
                                      fontFamily: 'Baloo',
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal),
                                ),
                                content: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Horarios',
                                            style: TextStyle(
                                                fontFamily: 'Baloo',
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          TextField(
                                            controller: activityTimeController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Tempo de Atividade',
                                            ),
                                            style: const TextStyle(
                                                fontFamily: 'Baloo',
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(height: 10,),
                                          TextField(
                                            controller: breakTimeController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Tempo de Intervalo',
                                              
                                            ),
                                            style: const TextStyle(
                                                fontFamily: 'Baloo',
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        
                                          const Text(
                                            'Botao Iniciar',
                                            style: TextStyle(
                                                fontFamily: 'Baloo',
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .resolveWith<Color>(
                                                    (Set<MaterialState>
                                                        states) {
                                                      if (manualButton) {
                                                        return Colors
                                                            .grey; // Cor cinza para true
                                                      }
                                                      return Colors
                                                          .blue; // Cor azul para false
                                                    },
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    manualButton =
                                                        !manualButton;
                                                    autoButton = !autoButton;
                                                  });
                                                },
                                                child: const Text('Manual'),
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .resolveWith<Color>(
                                                    (Set<MaterialState>
                                                        states) {
                                                      if (autoButton) {
                                                        return Colors
                                                            .grey; // Cor cinza para true
                                                      }
                                                      return Colors
                                                          .blue; // Cor azul para false
                                                    },
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    manualButton =
                                                        !manualButton;
                                                    autoButton = !autoButton;
                                                  });
                                                },
                                                child: const Text('Auto'),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                waterButton = !waterButton;
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                        'Controle da Água'),
                                                    Switch(
                                                      value: waterButton,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          waterButton = value;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                TextField(
                                                  enabled: waterButton,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        'Quantidade de Água Diária...',
                                                  ),
                                                  onChanged: (value) => {
                                                    setState(() {
                                                      waterValueMax =
                                                          double.parse(value);
                                                    })
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                hintButton = !hintButton;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('Receber Dicas'),
                                                Switch(
                                                  value: hintButton,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      hintButton = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                notificationButton =
                                                    !notificationButton;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('Notificaçoes'),
                                                Switch(
                                                  value: notificationButton,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      notificationButton =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        activityTime = int.tryParse(activityTimeController.text) ?? 25;
                                        breakTime = int.tryParse(breakTimeController.text) ?? 5;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Salvar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),





          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 30.0,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 20.0),
                    ),
                    child: Transform.rotate(
                      // Gire o Slider em 90 graus no sentido anti-horário
                      angle: 90 * pi / 180,
                      child: Slider(
                        value: waterValue,
                        min: 0,
                        max: waterValueMax * 1000,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (waterValue < 100) {
                          waterValue += 0;
                        }
                        if (waterValue == waterValueMax * 1000) {
                          waterValue = 0;
                        }
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Configuraçoes',
                            ),
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              // Ação do botão
                                              setState(() {
                                                waterValue += 180;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(
                                                  16.0), // Ajuste o tamanho do botão conforme necessário
                                            ),
                                            child: const Icon(Icons.add),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Ação do botão
                                              setState(() {
                                                waterValue += 300;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(
                                                  16.0), // Ajuste o tamanho do botão conforme necessário
                                            ),
                                            child: const Icon(Icons.add),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Ação do botão
                                              waterValue += 500;
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(
                                                  16.0), // Ajuste o tamanho do botão conforme necessário
                                            ),
                                            child: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                      TextField(
                                        enabled: waterButton,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText:
                                              'Quantidade de Água Ingerida...',
                                        ),
                                        onChanged: (value) => {
                                          setState(() {
                                            waterValue = double.parse(value);
                                          })
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Adicionar'),
                              ),
                            ],
                          );
                        },
                      ).then((_) {
                        setState(() {});
                      });
                    },
                    child:
                        Text((waterValue < waterValueMax) ? 'Água' : 'Zerar'),
                  ),
                ],
              ),


              Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 300,
                        child: PomodoroTimer(
                          activityTime: activityTime,
                          breakTime: breakTime,
                        ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (isCountingDown) {
                  //       stopAnimation();
                  //     } else {
                  //       startAnimation();
                  //     }
                  //   },
                  //   child: Text(
                  //     isCountingDown ? 'Parar' : 'Iniciar',
                  //     style: const TextStyle(
                  //         fontFamily: 'Baloo',
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.normal),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),


          
          const SizedBox(height: 10),

          
          SingleChildScrollView(
            child: Container(
              height: 200, // Defina a altura máxima desejada
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5), // Adicione um espaçamento entre as notificações
                    child: Dismissible(
                      key: Key(notification),
                      direction: DismissDirection.horizontal, // Defina a direção de deslize permitida
                      onDismissed: (direction) {
                        setState(() {
                          notifications.removeAt(index); // Remova a notificação da lista
                        });
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Notificação removida')),
                        // );
                      },
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd ||
                            direction == DismissDirection.endToStart) {
                          return true; // Confirma a remoção da notificação
                        }
                        return false; // Cancela a remoção da notificação
                      },
                      // background: Container(
                      //   color: Colors.red,
                      //   child: Icon(Icons.delete, color: Colors.white),
                      //   alignment: Alignment.centerLeft,
                      //   padding: EdgeInsets.only(left: 16),
                      // ),
                      child: SizedBox(
                        width: 200, // Defina a largura desejada para cada notificação
                        height: 30, // Defina a altura desejada para cada notificação
                        child: NotificationBar(
                          text: notification,
                          onDismissed: () => removeNotification(notification),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),




        ],
      ),
    );
  }
}
