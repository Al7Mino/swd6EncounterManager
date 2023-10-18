import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swd6_encounter_manager/models/roll.dart';
import 'package:swd6_encounter_manager/widgets/dialog_score.dart';
import 'package:swd6_encounter_manager/widgets/dice_roller.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => RollModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  void roll(BuildContext context) {
    Provider.of<RollModel>(context, listen: false).roll();
    ScoreDialog.builder(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Test app'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: DiceRoller(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {roll(context)},
        child: const Text('Roll'),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
