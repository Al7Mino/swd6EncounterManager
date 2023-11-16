class RollResultModel {
  /// Number of dices rolled.
  final int _numberDice;

  /// Bonus applied to the result.
  final int _bonus;

  /// List of wild dice results.
  final List<int> _wildDiceResults;

  /// List of regular dices results.
  final List<int> _dicesResults;

  /// Number of dices rolled.
  int get numberDice => _numberDice;

  /// Bonus applied to the result.
  int get bonus => _bonus;

  /// List of wild dice results.
  List<int> get wildDiceResults => _wildDiceResults;

  /// List of regular dices results.
  List<int> get dicesResults => _dicesResults;

  RollResultModel(
    this._numberDice,
    this._bonus,
    this._wildDiceResults,
    this._dicesResults,
  );

  /// The total result of the roll.
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
      0,
      (previousValue, element) => previousValue + element,
    );

    score += _bonus;

    return score;
  }
}
