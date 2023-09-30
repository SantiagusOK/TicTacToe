import 'package:equatable/equatable.dart';

enum MemoryGameStatus { initial, success, failure }

class MemoryGameState extends Equatable {
  final MemoryGameStatus status;
  final String? error;
  final int? firstTileIndex;
  final int? secondTileIndex;

  const MemoryGameState(
      {required this.status,
      this.error,
      this.firstTileIndex,
      this.secondTileIndex});

  @override
  List<Object?> get props => [status, error, firstTileIndex, secondTileIndex];

  MemoryGameState copyWith({
    MemoryGameStatus? status,
    String? error,
  }) {
    return MemoryGameState(
      status: status ?? this.status,
      error: error,
    );
  }
}
