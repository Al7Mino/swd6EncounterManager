import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swd6_encounter_manager/custom_icons.dart';
import 'package:swd6_encounter_manager/models/roll.dart';
import 'package:swd6_encounter_manager/pages/home.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
    Provider.of<RollModel>(context, listen: false).roll();
    ScoreDialog.builder(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (screenIndex) {
      case 0:
        page = const HomePage();
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
        title: Text(widget.title),
      ),
      drawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: const [
          NavigationDrawerDestination(
            icon: Icon(CustomIcons.crossed_swords),
            label: Text('Encounters'),
          ),
          NavigationDrawerDestination(
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
