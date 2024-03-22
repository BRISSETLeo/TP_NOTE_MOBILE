import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_flutter/repository/settingsmodel.dart';
import 'dart:math';
import 'package:td2_flutter/ui/home.dart';

class Ecran3 extends StatefulWidget {
  const Ecran3({super.key});

  @override
  // ignore: library_private_types_in_public_api
  EcranBoard createState() => EcranBoard();
}

class EcranBoard extends State<Ecran3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
      ),
      body: const Center(
        child: Board(),
      ),
    );
  }
}

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<List<String>> grid = [];
  String currentPlayer = '';

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    setState(() {
      grid = List.generate(3, (_) => List.filled(3, ''));
      currentPlayer = 'X';
    });
  }

  void tapped(int row, int col) {
    if (grid[row][col] == '' && !checkWinner()) {
      setState(() {
        grid[row][col] = currentPlayer;
        if (checkWinner()) {
          context
              .read<SettingViewModel>()
              .addScore(context.read<SettingViewModel>().pseudos, 10, 1);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Winner'),
              content: Text('Player $currentPlayer wins!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    initializeGame();
                  },
                  child: const Text('Play Again'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false);
                  },
                  child: const Text('Retour'),
                )
              ],
            ),
          );
        } else if (!grid.any((row) => row.contains(''))) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Draw'),
              content: const Text('It\'s a draw!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    initializeGame();
                  },
                  child: const Text('Play Again'),
                )
              ],
            ),
          );
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
          if (currentPlayer == 'O') {
            playAI();
          }
        }
      });
    }
  }

  void playAI() {
    int bestScore = -9999;
    int moveRow = -1;
    int moveCol = -1;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[i][j] == '') {
          grid[i][j] = 'O';
          int score = minimax(grid, 0, -9999, 9999, false);
          grid[i][j] = '';
          if (score > bestScore) {
            bestScore = score;
            moveRow = i;
            moveCol = j;
          }
        }
      }
    }
    tapped(moveRow, moveCol);
  }

  int minimax(List<List<String>> grid, int depth, int alpha, int beta,
      bool isMaximizing) {
    if (checkWinner()) {
      return (isMaximizing) ? -10 + depth : 10 - depth;
    } else if (!grid.any((row) => row.contains(''))) {
      return 0;
    }
    if (isMaximizing) {
      int bestScore = -9999;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (grid[i][j] == '') {
            grid[i][j] = 'O';
            int score = minimax(grid, depth + 1, alpha, beta, false);
            grid[i][j] = '';
            bestScore = max(score, bestScore);
            alpha = max(alpha, bestScore);
            if (beta <= alpha) {
              break;
            }
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 9999;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (grid[i][j] == '') {
            grid[i][j] = 'X';
            int score = minimax(grid, depth + 1, alpha, beta, true);
            grid[i][j] = '';
            bestScore = min(score, bestScore);
            beta = min(beta, bestScore);
            if (beta <= alpha) {
              break;
            }
          }
        }
      }
      return bestScore;
    }
  }

  bool checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (grid[i][0] == currentPlayer &&
          grid[i][1] == currentPlayer &&
          grid[i][2] == currentPlayer) {
        return true;
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (grid[0][i] == currentPlayer &&
          grid[1][i] == currentPlayer &&
          grid[2][i] == currentPlayer) {
        return true;
      }
    }
    // Check diagonals
    if (grid[0][0] == currentPlayer &&
        grid[1][1] == currentPlayer &&
        grid[2][2] == currentPlayer) {
      return true;
    }
    if (grid[0][2] == currentPlayer &&
        grid[1][1] == currentPlayer &&
        grid[2][0] == currentPlayer) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (row) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (col) => GestureDetector(
              onTap: () => tapped(row, col),
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: Center(
                  child: Text(
                    grid[row][col],
                    style: const TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
