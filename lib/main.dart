import 'package:flutter/material.dart';
import 'dart:math';
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


  bool waterButton = true;
  bool hintButton = true;
  bool notificationButton = true;

  bool autoButton = true;
  bool manualButton = false;


  TextEditingController activityTimeController = TextEditingController();
  TextEditingController breakTimeController = TextEditingController();
  int activityTime = 0; 
  int breakTime = 0; 

  List<String> notifications = [];
  String text_notification = "Nada";
  bool show = false;
  String category= "Nada";


  // void startNotifications() {
  //   Timer.periodic(const Duration(seconds: 10), (timer) {
  //     setState(() {
  //       // notifications.add('Nova notificação ${timer.tick}');
  //     });
  //   });
  // }

  void removeNotification(String notification) {
    setState(() {
      notifications.remove(notification);
    });
  }


  @override
  void initState() {
    super.initState();
    // startNotifications();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // A animação foi concluída, você pode realizar alguma ação aqui
        setState(() {
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
      _animationController.reset();
      _animationController.forward();
    });
  }

  void stopAnimation() {
    setState(() {
      _animationController.reverse();
    });
  }

  @override
  StatefulWidget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    return Scaffold(
      body: 
      SingleChildScrollView(
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                                            onChanged: (value) => {
                                              setState(() {
                                                  activityTime = int.tryParse(activityTimeController.text) ?? 0;
                                              })
                                            },
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
                                            onChanged: (value) => {
                                              setState(() {
                                                  breakTime = int.tryParse(breakTimeController.text) ?? 0;
                                              })
                                            },
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
                                                      if (!manualButton) {
                                                        return Colors
                                                            .grey; 
                                                      }
                                                      return Colors
                                                          .blue; 
                                                    },
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    manualButton = !manualButton;
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
                                                      if (!autoButton) {
                                                        return Colors
                                                            .grey; 
                                                      }
                                                      return Colors
                                                          .blue; 
                                                    },
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    manualButton = !manualButton;
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

                                        Navigator.of(context).pop();
                                    },
                                    child: const Text('Salvar'),
                                  ),
                                ],
                              );
                            },
                          ).then((_) {
                              setState(() {});
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 30.0,
                        activeTrackColor: Colors.blue, // Define a cor de preenchimento transparente
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 00.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
                      ),
                      child: Transform.rotate(
                        angle: 180 * pi / 180,
                        child: 
                        Slider(
                          value: waterValue,
                          min: 0,
                          max: waterValueMax * 1000,
                          onChanged: (value) {
                            setState(() {
                              waterValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (waterValueMax == 0)
                        {
                          text_notification = 'Configure sua meta diária';
                          notifications.add(text_notification);
                          category = "Água";
                        }
                        if (waterValue == waterValueMax * 1000) {
                          waterValue = 0;
                        }
                      });
                      if (waterValueMax > 0) {
                    
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
                    }},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/gotas.png',
                            width: 30.0,
                            height: 30.0,
                          ),
                        ],
                      ),
                  ),
                ],
              ), 
                  SizedBox(
                    width: 250,
                    height: 320,
                        child: 
                          KeyedSubtree(
                            key: ValueKey(activityTime), // Use uma chave única baseada em activityTime
                            child: PomodoroTimer(
                              activityTime: activityTime,
                              breakTime: breakTime,
                              auto: autoButton,
                            ),
                          )
                  ),



                ],
              ),
  
      ]),


          
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
                          text: text_notification,
                          category: category,
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
    ),
    );
  }
}
