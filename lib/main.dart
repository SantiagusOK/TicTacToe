import 'package:ejemplos_2do_soft_9010/default_theme.dart';
import 'package:ejemplos_2do_soft_9010/memory_game/memory_game_cubit.dart';
import 'package:ejemplos_2do_soft_9010/routes.dart';
import 'package:ejemplos_2do_soft_9010/tic_tac_toe/tic_tac_toe.dart';
import 'package:flutter/material.dart';

//Cubits
MemoryGameCubit memoryGameCubit = MemoryGameCubit();
TicTacToeGame titactoeGameCubit = TicTacToeGame();
void main() async {
  runApp(const Examples2ndApp());
}

class Examples2ndApp extends StatelessWidget {
  const Examples2ndApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Frutality().add(FEInitFrutalityEvent());

    return MaterialApp.router(
        title: 'Ejemplos 2do TSDdS IES 9-010',
        theme: defaultTheme(context),
        routerConfig: examples2ndRouter);
  }
}
