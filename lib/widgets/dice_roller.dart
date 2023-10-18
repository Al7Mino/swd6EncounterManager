import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:swd6_encounter_manager/models/roll.dart';
import 'package:swd6_encounter_manager/widgets/base/numerical_input.dart';

class DiceRoller extends StatelessWidget {
  const DiceRoller({super.key});

  void _onChangedNbDices(RollModel roll, double value) {
    roll.numberDice = value.round();
  }

  void _onChangedBonus(RollModel roll, double value) {
    roll.bonus = value.round();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Consumer<RollModel>(
              builder: (context, roll, child) {
                return NumericalInput(
                  min: 1,
                  value: 1,
                  formatText: (text) => '$text D',
                  onChanged: (value) => _onChangedNbDices(roll, value),
                );
              },
            ),
          ),
          const MaxGap(16),
          SizedBox(
            width: 150,
            child: Consumer<RollModel>(
              builder: (context, roll, child) {
                return NumericalInput(
                  min: 0,
                  max: 2,
                  value: 0,
                  onChanged: (value) => _onChangedBonus(roll, value),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
