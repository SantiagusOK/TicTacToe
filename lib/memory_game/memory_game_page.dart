import 'package:ejemplos_2do_soft_9010/memory_game/memory_game_cubit.dart';
import 'package:ejemplos_2do_soft_9010/memory_game/memory_game_domain.dart';
import 'package:ejemplos_2do_soft_9010/memory_game/memory_game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MemoryGamePage extends StatelessWidget {
  const MemoryGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MemoryGameCubit, MemoryGameState>(
        listener: (listenerContext, state) {
      if (state.status == MemoryGameStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('¡Bien!'),
          backgroundColor: Colors.green,
        ));
      }
      if (state.status == MemoryGameStatus.failure) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('¡Lo siento!'),
          backgroundColor: Colors.red,
        ));
      }
    }, builder: (builderContext, state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Memoria"),
          ),
          body: Container(
            padding: const EdgeInsets.all(12.0),
            child: LayoutBuilder(builder: (bodyContext, constraints) {
              return Center(
                child: SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxHeight,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(4.0),
                    itemCount: 16,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.0,
                            crossAxisCount: 4,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int index) {
                      MemoryGameTile aTile =
                          context.read<MemoryGameCubit>().board[index];
                      print(
                          "$index -- ${aTile.isUncovered} // ${aTile.tileIndex}");
                      return Container(
                          decoration: BoxDecoration(
                              color: aTile.isUncovered
                                  ? Colors.red
                                  /*context
                                      .read<MemoryGameCubit>()
                                      .boardTiles[aTile.tileIndex]*/
                                  : Colors.transparent,
                              border: Border.all(color: Colors.black)),
                          child: SizedBox.expand(
                            child: ElevatedButton(
                              /*style: ElevatedButton.styleFrom(
                                backgroundColor: aTile.isUncovered
                                    ? context
                                        .read<MemoryGameCubit>()
                                        .boardTiles[aTile.tileIndex]
                                    : Colors.white,
                              ),*/
                              onPressed: () {
                                context
                                    .read<MemoryGameCubit>()
                                    .selectTile(index);
                              },
                              child: const Text(''),
                            ),
                          ));
                    },
                  ),
                ),
              );
            }),
          ));
    });
  }
}
