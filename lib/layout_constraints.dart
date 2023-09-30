import 'dart:math';

import 'package:flutter/material.dart';

class LayoutConstraintsExamplePage extends StatelessWidget {
  const LayoutConstraintsExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Ejemplo de LayoutBuilder')),
        body: LayoutBuilder(builder: (context, constrains) {
          double ancho = constrains.maxWidth;
          double alto = constrains.maxHeight;
          double anchoRojo = max(100, ancho * 0.4);
          double anchoVerde = ancho - anchoRojo;
          return Center(
            child: SizedBox(
              width: ancho,
              height: constrains.maxHeight,
              child: Row(
                children: [
                  Container(
                      color: Colors.red,
                      child: SizedBox(
                        width: anchoRojo,
                        height: alto,
                      )),
                  Container(
                    color: Colors.green,
                    child: SizedBox(
                      width: anchoVerde,
                      height: alto,
                    ),
                  )
                ],
              ),
            ),
          );
          // return Center(
          //     child: Text(
          //   "Ancho: ${ancho.toString()}",
          //   style: Theme.of(context).textTheme.displayLarge,
          // ));
        }));
  }
}
