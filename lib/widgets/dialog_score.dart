import 'package:flutter/material.dart';
import 'package:swd6_encounter_manager/models/roll_result.dart';

class ScoreDialog {
  static Future<void> builder(BuildContext context, RollResultModel result) {
    InlineSpan getResults() {
      if (result.wildDiceResults[0] != 1 && result.wildDiceResults[0] != 6) {
        return TextSpan(
          text: result.wildDiceResults.join(', '),
        );
      }
      if (result.wildDiceResults[0] == 6) {
        return TextSpan(
          text: result.wildDiceResults.join(', '),
          style: TextStyle(
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
          ),
        );
      }
      if (result.wildDiceResults[0] == 1 && result.wildDiceResults[1] == 6) {
        return TextSpan(
          style: TextStyle(
            color: Colors.red.shade900,
          ),
          children: [
            TextSpan(
              text: result.wildDiceResults[0].toString(),
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic,
              ),
            ),
            const TextSpan(text: ', '),
            TextSpan(
              text: '-${result.wildDiceResults[1].toString()}',
            ),
          ],
        );
      }
      return TextSpan(
        style: const TextStyle(
          color: Colors.deepOrange,
        ),
        children: [
          TextSpan(
            text: result.wildDiceResults[0].toString(),
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              fontStyle: FontStyle.italic,
            ),
          ),
          const TextSpan(text: ', '),
          TextSpan(
            text: '-${result.wildDiceResults[1].toString()}',
          ),
        ],
      );
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    text: result.total.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          getResults(),
                          TextSpan(
                            text: result.dicesResults.isEmpty
                                ? ''
                                : ', ${result.dicesResults.join(', ')}',
                          ),
                        ],
                      ),
                    ),
                    Text(result.bonus == 0 ? '' : ' + ${result.bonus}'),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
