import 'package:ejemplos_2do_soft_9010/home_page.dart';
import 'package:ejemplos_2do_soft_9010/layout_constraints.dart';
import 'package:ejemplos_2do_soft_9010/main.dart';
import 'package:ejemplos_2do_soft_9010/memory_game/memory_game_cubit.dart';
import 'package:ejemplos_2do_soft_9010/memory_game/memory_game_page.dart';
import 'package:ejemplos_2do_soft_9010/tic_tac_toe/tic_tac_toe.dart';
import 'package:ejemplos_2do_soft_9010/tic_tac_toe/tic_tac_toe_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum Pages { menu, memoryGame, ejLayoutBuilder, tictactoe }

GoRouter examples2ndRouter =
    GoRouter(debugLogDiagnostics: true, initialLocation: '/', routes: [
  GoRoute(
      name: Pages.menu.name,
      path: '/',
      builder: (context, state) {
        return const MenuPage();
      },
      routes: [
        GoRoute(
          name: Pages.memoryGame.name,
          path: 'memory',
          builder: (context, state) {
            return BlocProvider<MemoryGameCubit>.value(
                value: memoryGameCubit, child: const MemoryGamePage());
          },
        ),
        GoRoute(
          name: Pages.ejLayoutBuilder.name,
          path: 'ejLayoutBuilder',
          builder: (context, state) {
            return const LayoutConstraintsExamplePage();
          },
        ),
        GoRoute(
          name: Pages.tictactoe.name,
          path: 'tictactoe',
          builder: (context, state) {
            //Acá indicamos que debe crearse una nueva instancia del widget (la pantalla)  TicTacToePage
            // y que esta estará observando a titactoeGameCubit, el cual es una instancia
            // de TicTacToeGame (el cual es una subclase de Cubit)
            return BlocProvider<TicTacToeGame>.value(
                value: titactoeGameCubit, child: const TicTacToePage());
          },
        )
      ])
]);
