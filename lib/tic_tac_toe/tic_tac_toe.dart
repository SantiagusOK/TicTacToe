import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:ejemplos_2do_soft_9010/tic_tac_toe/tic_tac_toe_state.dart';

// Definimos la clase TicTacToeGame como una subclase de Cubit
// esta parametrizado con TicTacToeState, el cual es la superclase
// de todos los tipos de estado que puede emitir este Cubit
class TicTacToeGame extends Cubit<TicTacToeState> {
  // Genero un booleano al azar, si es true comienza X, si es false comienza O
  late String currentPlayer;
  late List<String> board;
  int? movingFrom;
  int saveMovingFrom = 0;
  String saveCurrentPlayer = '';
  TicTacToeGame()
      : super(const TicTacToeFirstState(
            board: ['', '', '', '', '', '', '', '', ''], currentPlayer: 'X')) {
    _initGame();
  }

  _initGame() {
    // Se ejecuta cada vez que se inicia un nuevo juego
    // Genero un booleano al azar, si es true comienza X, si es false comienza O
    currentPlayer = Random().nextBool() ? 'X' : 'O';
    board = ['', '', '', '', '', '', '', '', ''];
    emit(TicTacToeFirstState(board: board, currentPlayer: currentPlayer));
  }

  bool _moventPlayer(int positionPlayer, int chosenBox, List board) {
    List listPosibleMoves = [
      [3, 4, 1],
      [0, 3, 4, 5, 2],
      [1, 4, 5],
      [0, 1, 4, 6, 7],
      [0, 1, 2, 3, 5, 6, 7, 8],
      [2, 1, 4, 7, 8],
      [3, 4, 7],
      [6, 3, 4, 5, 8],
      [7, 4, 5]
    ];
    List lista = listPosibleMoves[positionPlayer];
    if (board[chosenBox] == 'X' ||
        board[chosenBox] == 'O' ||
        board[chosenBox] == '[X]' ||
        board[chosenBox] == '[O]') {
      return false;
    }
    if (lista.contains(chosenBox)) {
      return true;
    } else {
      return false;
    }
  }

  bool _allTheChipsHaveBeenPlaced() {
    // Devuelve true si ya se colocaron las 6 fichas sobre el tablero
    // , es decir, si board tiene 6 celdas cuyo valor no sea un String vacio ('')
    // Este método comienza con un guión bajo porque es privado, y es privado porque
    // es de utilidad solo para uno o más métodos de esta clase y no para otra clase
    return (board.fold(
            0, (value, element) => value + (element == '' ? 0 : 1)) ==
        6);
  }

  String _opponentPlayer() {
    //Devuelve el jugador oponente al jugador actual
    return currentPlayer == 'X' ? 'O' : 'X';
  }

  bool _checkIfPlayerWins(String aPlayer) {
    //Devuelve true si el jugador pasado por argumento tiene sus fichas
    // en alguna de las 8 secuencias posibles
    return [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [6, 4, 2]
    ].any((secuence) =>
        secuence.every((secuenceIndex) => board[secuenceIndex] == aPlayer));
  }

  selectCell(int pos) {
    bool boardChanged = false;
    if (_allTheChipsHaveBeenPlaced()) {
      //Si ya han sido colocadas las 6 fichas...
      emit(TicTacToeFirstState(board: board, currentPlayer: currentPlayer));
      if (board[pos] == currentPlayer) {
        // Si el jugador ha seleccionado una celda donde hay una ficha suya
        // (la ficha a mover), se guarda en movingFrom la posición de esta celda
        movingFrom = pos;
        saveMovingFrom = pos;
        board[pos] = currentPlayer == 'X' ? '[X]' : '[O]';
        saveCurrentPlayer = currentPlayer;
        currentPlayer = 'continua $saveCurrentPlayer';
      } else if (board[pos] == _opponentPlayer()) {
        //Si la celda esta ocupada con una ficha del oponente, generamos un estado de error
        emit(const TicTacToeFailureState(
            errorMessage: 'Debes seleccionar una ficha propia'));
      } else {
        //Si la celda esta vacía...
        if (movingFrom == null) {
          //... pero no hay una ficha para mover seleccionada..
          //... generamos un estado de error
          emit(const TicTacToeFailureState(
              errorMessage:
                  'Primero debe seleccionar la ficha que desea mover'));
        } else if (_moventPlayer(saveMovingFrom, pos, board)) {
          //... y ya se había seleccionado la ficha a mover...
          //... se saca la ficha de la celda de donde la estamos moviendo
          currentPlayer = saveCurrentPlayer;
          board[movingFrom!] = '';
          movingFrom = null;
          //... ponemos la ficha en la nueva celda...
          board[pos] = currentPlayer;
          //... indicamos que el tablero cambió

          boardChanged = true;
        } else {
          emit(const TicTacToeFailureState(
              errorMessage: 'No se puede mover la ficha a esta casilla'));
        }
      }
    } else {
      //Si aún se estan colocando las 6 fichas...
      if (board[pos] == '') {
        //Si la celda esta vacía...
        //... colocamos la ficha del jugador actual en la celda seleccionada
        board[pos] = currentPlayer;
        //... indicamos que el tablero cambió
        boardChanged = true;
      } else {
        //Si la celda esta ocupada, generamos un estado de error
        // con el mensaje correspondiente para que la vista lo muestre...
        emit(
            const TicTacToeFailureState(errorMessage: 'La celda esta ocupada'));
      }
    }
    // ...damos el turno al oponente
    // Si el tablero cambió...
    if (boardChanged) {
      // Verificamos que con ese cambio no haya ganado el jugador actual..
      if (_checkIfPlayerWins(currentPlayer)) {
        // Si ganó..
        // Generamos un estado que lo indique
        emit(TicTacToeSuccessState(notification: 'Ganó $currentPlayer'));
        // Damos 5 segundos para que la vista avise que el jugador ganó..
        Timer(const Duration(seconds: 5), () {
          // y luego reeestablecemos el juego...
          _initGame();
        });
      } else {
        // Si aun no ganó le damos el turno al oponente..
        currentPlayer = _opponentPlayer();
      }
    }

    //... emitimos este estado para que la vista lo refleje
    emit(TicTacToeFirstState(board: board, currentPlayer: currentPlayer));
  }
}
