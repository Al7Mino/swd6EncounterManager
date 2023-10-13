import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:gap/gap.dart';
import 'package:swd6_encounter_manager/base/numerical_input.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  int _nbDices = 1;
  int _bonus = 0;
  int _score = 0;

  void _onChangedNbDices(value) {
    setState(() {
      _nbDices = value.round();
    });
  }

  void _onChangedBonus(value) {
    setState(() {
      _bonus = value.round();
    });
  }

  void _roll() {
    setState(() {
      _score = 0;
      for (var i = 0; i < _nbDices; i++) {
        _score += Random().nextInt(5) + 1;
      }
      _score += _bonus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /* ElevatedButton(
            onPressed: () {
              _roll();
            },
            child: const Text('Roll'),
          ),
          const MaxGap(16), */
          /* SpinBox(), */
          SizedBox(
            width: 200,
            child: NumericalInput(
              min: 1,
              value: 1,
              formatText: (text) => '$text D',
            ),
          ),
          /* SizedBox(
            width: 100,
            child: SpinBox(
              min: 1,
              max: 50,
              value: _nbDices.toDouble(),
              spacing: 0,
              /* direction: Axis.vertical, */
              /* incrementIcon: const Icon(Icons.keyboard_arrow_up),
              decrementIcon: const Icon(Icons.keyboard_arrow_down), */
              iconColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                if (states.contains(MaterialState.error)) {
                  return Colors.red;
                }
                if (states.contains(MaterialState.focused)) {
                  return Colors.blue;
                }
                return Colors.black;
              }),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8),
                suffix: Text('D'),
                label: Text('Dices'),
              ),
              onChanged: (value) => _onChangedNbDices(value),
            ),
          ), */
          /* const MaxGap(16),
          SizedBox(
            width: 50,
            child: SpinBox(
              min: 0,
              max: 2,
              value: _bonus.toDouble(),
              spacing: 0,
              direction: Axis.vertical,
              incrementIcon: const Icon(Icons.keyboard_arrow_up),
              decrementIcon: const Icon(Icons.keyboard_arrow_down),
              iconColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                if (states.contains(MaterialState.error)) {
                  return Colors.red;
                }
                if (states.contains(MaterialState.focused)) {
                  return Colors.blue;
                }
                return Colors.black;
              }),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8),
                  prefix: Text('+'),
                  label: Text('Pip')),
              onChanged: (value) => _onChangedBonus(value),
            ),
          ), */
          const MaxGap(16),
          Text('$_score')
        ],
      ),
    );
  }
}
