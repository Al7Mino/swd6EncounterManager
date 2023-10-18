import 'dart:math';
import 'package:flutter/foundation.dart';

class RollModel extends ChangeNotifier {
  /// Number of dices to roll.
  int numberDice = 1;

  /// Bonus applied to the result.
  int bonus = 0;

  /// List of wild dice results.
  final List<int> _wildDiceResults = [];

  /// List of regular dices results.
  final List<int> _dicesResults = [];

  /// List of wild dice results.
  List<int> get wildDiceResults => _wildDiceResults;

  /// List of regular dices results.
  List<int> get dicesResults => _dicesResults;

  /// The current total of the roll.
  int get total {
    var score = 0;

    if (_wildDiceResults[0] != 1 && _wildDiceResults[0] != 6) {
      score += _wildDiceResults[0];
    } else if (_wildDiceResults[0] == 1 && _wildDiceResults.length > 1) {
      score -= _wildDiceResults[1];
    } else if (_wildDiceResults[0] == 6) {
      for (var i = 0; i < _wildDiceResults.length; i++) {
        score += _wildDiceResults[i];
      }
    }

    score += _dicesResults.fold(
        0, (previousValue, element) => previousValue + element);

    score += bonus;

    return score;
  }

  /// Make a roll.
  void roll() {
    // Remove all previous results
    _wildDiceResults.clear();
    _dicesResults.clear();

    var firstDice = Random().nextInt(6) + 1;
    _wildDiceResults.add(firstDice);
    if (firstDice == 1) {
      _wildDiceResults.add(Random().nextInt(6) + 1);
    }
    while (firstDice == 6) {
      firstDice = Random().nextInt(6) + 1;
      _wildDiceResults.add(firstDice);
    }

    for (var i = 1; i < numberDice; i++) {
      _dicesResults.add(Random().nextInt(6) + 1);
    }

    notifyListeners();
  }
}
