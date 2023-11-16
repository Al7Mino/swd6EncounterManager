import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EncounterPage extends StatefulWidget {
  const EncounterPage({super.key});

  @override
  State<EncounterPage> createState() => _EncounterPageState();
}

class _EncounterPageState extends State<EncounterPage> {
  final List<int> _items = List<int>.generate(10, (int index) => index);

  void reorderItems(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    setState(() {
      final int item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    final List<Widget> listItems = <Widget>[
      for (int index = 0; index < _items.length; index += 1)
        Container(
          key: Key('$index'),
          color: index.isOdd ? oddItemColor : evenItemColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Platform.isAndroid || Platform.isFuchsia || Platform.isIOS
                    ? Row(
                        children: [
                          ReorderableDragStartListener(
                            key: ValueKey<int>(_items[index]),
                            index: index,
                            child: const Icon(
                              Icons.drag_handle,
                              size: 20.0,
                            ),
                          ),
                          const Gap(8.0),
                        ],
                      )
                    : const Gap(0.0),
                Text('Test ${_items[index]}'),
              ],
            ),
          ),
        ),
    ];

    return ReorderableListView(
      onReorder: reorderItems,
      children: listItems,
    );
  }
}
