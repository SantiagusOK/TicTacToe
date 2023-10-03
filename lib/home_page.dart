import 'package:ejemplos_2do_soft_9010/main.dart';
import 'package:ejemplos_2do_soft_9010/routes.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Ejemplos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*ElevatedButton(
                onPressed: () {
                  memoryGameCubit.initGame();
                  examples2ndRouter.goNamed(Pages.memoryGame.name);
                },
                child: const Text('Memoria')),
            ElevatedButton(
                onPressed: () {
                  examples2ndRouter.goNamed(Pages.ejLayoutBuilder.name);
                },
                child: const Text('Ej. LayoutBuilder')),*/
            ElevatedButton(
                onPressed: () {
                  // memoryGameCubit.initGame();
                  examples2ndRouter.goNamed(Pages.tictactoe.name);
                },
                child: const Text(
                  'TaTeTi',
                  style: TextStyle(fontSize: 50),
                )),
          ],
        ),
      ),
    );
  }
}
