import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:swd6_encounter_manager/models/roll_result.dart';

class RollModel extends ChangeNotifier {
  /// Number of dices to roll.
  int numberDice = 1;

  /// Bonus applied to the result.
  int bonus = 0;

  /// Make a roll.
  RollResultModel roll() {
    // Remove all previous results
    List<int> wildDiceResults = [];
    List<int> dicesResults = [];

    var firstDice = Random().nextInt(6) + 1;
    wildDiceResults.add(firstDice);
    if (firstDice == 1) {
      wildDiceResults.add(Random().nextInt(6) + 1);
    }
    while (firstDice == 6) {
      firstDice = Random().nextInt(6) + 1;
      wildDiceResults.add(firstDice);
    }

    for (var i = 1; i < numberDice; i++) {
      dicesResults.add(Random().nextInt(6) + 1);
    }

    RollResultModel result =
        RollResultModel(numberDice, bonus, wildDiceResults, dicesResults);

    return result;
  }
}
