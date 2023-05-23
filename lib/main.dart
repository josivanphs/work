import 'package:flutter/material.dart';
import 'dart:math';

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
      home: MyHomePage(),
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

  @override
  void initState() {
    super.initState();

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
    var math;
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
                                          const TextField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Tempo de Atividade',
                                            ),
                                            style: TextStyle(
                                                fontFamily: 'Baloo',
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(height: 10,),
                                          const TextField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Tempo de Intervalo',
                                              
                                            ),
                                            style: TextStyle(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 97),
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
                                            child: Icon(Icons.add),
                                            style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(
                                                  16.0), // Ajuste o tamanho do botão conforme necessário
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Ação do botão
                                              setState(() {
                                                waterValue += 300;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Icon(Icons.add),
                                            style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(
                                                  16.0), // Ajuste o tamanho do botão conforme necessário
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Ação do botão
                                              waterValue += 500;
                                              Navigator.of(context).pop();
                                            },
                                            child: Icon(Icons.add),
                                            style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(
                                                  16.0), // Ajuste o tamanho do botão conforme necessário
                                            ),
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return CircularProgressIndicator(
                            strokeWidth: 100,
                            value: isCountingDown ? _animation.value : 0.0,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                            backgroundColor: Colors.grey[200],
                          );
                        },
                      ),
                      const Text(
                        '60 seg',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isCountingDown) {
                        stopAnimation();
                      } else {
                        startAnimation();
                      }
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
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Digite algo...',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
