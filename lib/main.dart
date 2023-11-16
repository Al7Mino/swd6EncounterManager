import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swd6_encounter_manager/custom_icons.dart';
import 'package:swd6_encounter_manager/models/roll.dart';
import 'package:swd6_encounter_manager/pages/encounter.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int screenIndex = 0;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void roll(BuildContext context) {
    var result = Provider.of<RollModel>(context, listen: false).roll();
    ScoreDialog.builder(context, result);
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    String title = '';
    switch (screenIndex) {
      case 0:
        page = const EncounterPage();
        title = 'Encounter';
        break;
      case 1:
        page = const Placeholder();
        break;
      default:
        throw UnimplementedError('No widget for $screenIndex');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      drawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'SWD6 Encounter Manager',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const NavigationDrawerDestination(
            icon: Icon(CustomIcons.crossed_swords),
            label: Text('Encounter'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(CustomIcons.dice),
            label: Text('Dice'),
          ),
        ],
      ),
      body: page,
      bottomNavigationBar: const BottomAppBar(
        child: DiceRoller(),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        tooltip: 'Roll',
        onPressed: () => {roll(context)},
        child: const Icon(
          CustomIcons.dice_d6,
          size: 18,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
