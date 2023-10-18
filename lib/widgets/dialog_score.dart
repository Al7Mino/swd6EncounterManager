import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swd6_encounter_manager/models/roll.dart';

class ScoreDialog {
  static Future<void> builder(BuildContext context) {
    InlineSpan getResults(RollModel roll) {
      if (roll.wildDiceResults[0] != 1 && roll.wildDiceResults[0] != 6) {
        return TextSpan(
          text: roll.wildDiceResults.join(', '),
        );
      }
      if (roll.wildDiceResults[0] == 6) {
        return TextSpan(
          text: roll.wildDiceResults.join(', '),
          style: TextStyle(
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
          ),
        );
      }
      if (roll.wildDiceResults[0] == 1 && roll.wildDiceResults[1] == 6) {
        return TextSpan(
          style: TextStyle(
            color: Colors.red.shade900,
          ),
          children: [
            TextSpan(
              text: roll.wildDiceResults[0].toString(),
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic,
              ),
            ),
            const TextSpan(text: ', '),
            TextSpan(
              text: '-${roll.wildDiceResults[1].toString()}',
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
            text: roll.wildDiceResults[0].toString(),
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              fontStyle: FontStyle.italic,
            ),
          ),
          const TextSpan(text: ', '),
          TextSpan(
            text: '-${roll.wildDiceResults[1].toString()}',
          ),
        ],
      );
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Consumer<RollModel>(
              builder: (context, roll, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: roll.total.toString(),
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
                              getResults(roll),
                              TextSpan(
                                text: roll.dicesResults.isEmpty
                                    ? ''
                                    : ', ${roll.dicesResults.join(', ')}',
                              ),
                            ],
                          ),
                        ),
                        Text(roll.bonus == 0 ? '' : ' + ${roll.bonus}'),
                      ],
                    ),
                  ],
                );
              },
            )
          ],
        );
      },
    );
  }
}
