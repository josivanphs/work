// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math' show Random;

class NotificationBar extends StatefulWidget {
  final String text;
  final VoidCallback onDismissed;
  final String category;




  NotificationBar({required this.text, required this.onDismissed, required this.category});

  @override
  _NotificationBarState createState() => _NotificationBarState();
}


class _NotificationBarState extends State<NotificationBar> 
with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  // Map<String, dynamic> jsonData = {};
  String text_final = "Nada";


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
          "Alerta : Você está a muito tempo sem beber água",
          "Alerta : Você precisa colocar a sua meta diária de água nas configurações"
        ]
    };


    String toJson() {
    return jsonEncode(jsonData);
    }

  Color _getCategoryColor(String category) {
    if (category == 'Água' || category == 'Alerta') {
      return Colors.blue; // Retorna azul para a categoria "agua"
    } else if (category == 'Dica') {
      return Colors.green; // Retorna verde para a categoria "dica"
    } else if (category == 'Alerta') {
      return Colors.red; // Retorna vermelho para a categoria "alerta"
    }
    return Colors.grey; // Retorna cinza para qualquer outra categoria desconhecida
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
                    if(widget.category == "Água")
                    {
                      text_final = jsonData['alertas'][3];
                    }
                    else
                    {
                      List<String> alertas = List<String>.from(jsonData['alertas']);
                      int randomIndex = Random().nextInt(alertas.length);
                      text_final = alertas[randomIndex];

                    }


                    return AlertDialog(
                      title: Text(widget.text),
                      content: Text(text_final),
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
            color: _getCategoryColor(widget.category),
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




