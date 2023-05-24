// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math' show Random;

class NotificationBar extends StatefulWidget {
  final String text;
  final VoidCallback onDismissed;



  NotificationBar({required this.text, required this.onDismissed});

  @override
  _NotificationBarState createState() => _NotificationBarState();
}


class _NotificationBarState extends State<NotificationBar> 
with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  // Map<String, dynamic> jsonData = {};



  @override
  void initState() {
    super.initState();
    // _loadJsonData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(_animationController);
    _animationController.forward();
  }

    Map<String, dynamic> jsonData = 
    {
        "video": [
          "https://www.youtube.com/shorts/KdhDgllx8HQ",
          "https://www.youtube.com/shorts/EYz1gKGJTak",
          "https://www.youtube.com/shorts/jROabDqZNdg"
        ],
        "dicas": [
          "Dica 1: Não negligencie exercícios rápidos para o seu corpo",
          "Dica 2: Descansar também faz parte da atividade",
          "Dica 3: Tente beber água de forma distribuída durante o dia"
        ],
        "alertas": [
          "Alerta : Você está a muito tempo trabalhando, dê um descanso!",
          "Alerta : O dia vai acabar e você está longe de bater a sua meta diária",
          "Alerta : Você está a muito tempo sem beber água"
        ]
    };


    String toJson() {
    return jsonEncode(jsonData);
    }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  StatefulWidget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
                  // if (jsonData.isNotEmpty) {
                    List<String> alertas = List<String>.from(jsonData['alertas']);
                    int randomIndex = Random().nextInt(alertas.length);
                    String alertaAleatorio = alertas[randomIndex];
                    return AlertDialog(
                      title: const Text('Detalhes da Notificação'),
                      content: Text(alertaAleatorio),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Fechar'),
                      ),
                    ],
                  );
                // } else {
                //   return AlertDialog(
                //     title: const Text('Carregando'),
                //     content: CircularProgressIndicator(),
                //   );
                // }
              },
            );
          },
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}




