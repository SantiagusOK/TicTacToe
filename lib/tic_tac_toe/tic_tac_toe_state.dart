import 'package:equatable/equatable.dart';

//Definimos los nombres de los tipos de estado que puede tener
// el cubit TicTacToeGame: first (normal, mostrando el tablero),
// failure, mostrando un error, success (mostrando una notificación "positiva")
enum TicTacToeStatus { first, failure, success }

//Las vistas se actualizarán cuando haya un cambio de estado, pero...
//¿Como sabrá si hay un cambio de estado?: Por ej. si se emiten dos veces
//seguidas un estado first con el mismo tablero y el mismo jugador, no debería
//considerarse un cambio de estado y por lo tanto la vista no debería redibujarse.
//Para determinar si dos estados son distintos, los estados de cubit heredan de la
// clase Equatable , la cual permite determinar si dos instancias de la misma clase
// deben considerarse como iguales o distintas: si algún atributo indicado
// en la lista props cambia, se considera que el estado cambió, sino no
//Por ej. si en la lista props de la clase TicTacToeFailure no tenemos al
//atributo errorMessage, si llegasemos a emitir dos estados con mensajes distintos
// se considerará que el mismo estado y por lo tanto no se actualizará la vista

// TicTacToeState es la superclase de todas las clases de estados del cubit
// la indicamos con abstact para que nos indique cuando querramos crear
// por error una instancia de ella
abstract class TicTacToeState extends Equatable {
  final TicTacToeStatus status;
  const TicTacToeState({required this.status});
  @override
  List<Object?> get props => [status];
}

// TicTacToeFirstState es la clase de todas las instancias del "estado normal"
// contiene el tablero y el jugador actual necesario para generar la vista
// (aunque por el momemto no utilizamos el jugador actual en la vista)
class TicTacToeFirstState extends TicTacToeState {
  final List<String> board;
  final String currentPlayer;

  const TicTacToeFirstState({required this.board, required this.currentPlayer})
      : super(status: TicTacToeStatus.first);

  @override
  List<Object?> get props => [status, board, currentPlayer];
}

// TicTacToeFirstState es la clase de todas las instancias del "estado de error"
class TicTacToeFailureState extends TicTacToeState {
  final String errorMessage;

  const TicTacToeFailureState({required this.errorMessage})
      : super(status: TicTacToeStatus.failure);

  @override
  List<Object?> get props => [status, errorMessage];
}

// TicTacToeFirstState es la clase de todas las instancias del "estado de
//notificación positiva", en este juego la utilizamos para indicar caundo
// ganó el jugador actual
class TicTacToeSuccessState extends TicTacToeState {
  final String notification;

  const TicTacToeSuccessState({required this.notification})
      : super(status: TicTacToeStatus.success);

  @override
  List<Object?> get props => [status, notification];
}
