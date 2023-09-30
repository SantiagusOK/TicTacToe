import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ejemplos_2do_soft_9010/memory_game/memory_game_domain.dart';
import 'package:ejemplos_2do_soft_9010/memory_game/memory_game_state.dart';
import 'package:flutter/material.dart';

class MemoryGameCubit extends Cubit<MemoryGameState> {
  int? firstTileSelectedIfAny;
  int? secondTileSelectedIfAny;
  int points = 0;
  final List<MaterialColor> boardTiles = [
    Colors.purple,
    Colors.orange,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.brown,
    Colors.grey
  ];

  /*final List<String> boardTiles = [
    "black",
    "orange",
    "yellow",
    "red",
    "blue",
    "green",
    "brown",
    "grey"
  ];*/
  List<MemoryGameTile> board = [];
  MemoryGameCubit()
      : super(const MemoryGameState(
          status: MemoryGameStatus.initial,
        ));

  initGame() {
    List<int> tileIndexes = [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7];
    board = (tileIndexes..shuffle())
        .map((e) => MemoryGameTile(tileIndex: e))
        .toList();
  }

  selectTile(int selectedTileIndex) {
    if (firstTileSelectedIfAny == null) {
      firstTileSelectedIfAny = selectedTileIndex;
      board[firstTileSelectedIfAny!].isUncovered = true;
      emit(MemoryGameState(
        status: MemoryGameStatus.initial,
        firstTileIndex: firstTileSelectedIfAny,
        secondTileIndex: secondTileSelectedIfAny,
      ));
    } else if (secondTileSelectedIfAny == null) {
      if (firstTileSelectedIfAny == selectedTileIndex) {
        return;
      }
      secondTileSelectedIfAny = selectedTileIndex;
      board[secondTileSelectedIfAny!].isUncovered = true;
      emit(MemoryGameState(
        status: MemoryGameStatus.initial,
        firstTileIndex: firstTileSelectedIfAny,
        secondTileIndex: secondTileSelectedIfAny,
      ));
      Timer(const Duration(seconds: 1), () {
        if (board[firstTileSelectedIfAny!].tileIndex ==
            board[secondTileSelectedIfAny!].tileIndex) {
          emit(const MemoryGameState(status: MemoryGameStatus.success));
        } else {
          board[firstTileSelectedIfAny!].isUncovered = false;
          board[secondTileSelectedIfAny!].isUncovered = false;
          emit(const MemoryGameState(status: MemoryGameStatus.failure));
        }

        firstTileSelectedIfAny = null;
        secondTileSelectedIfAny = null;
        emit(MemoryGameState(
          status: MemoryGameStatus.initial,
          firstTileIndex: firstTileSelectedIfAny,
          secondTileIndex: secondTileSelectedIfAny,
        ));
      });
    }
  }
}
