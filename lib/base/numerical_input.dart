import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericalInput extends StatefulWidget {
  const NumericalInput({
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.step = 1.0,
    this.value,
    this.decimals = 0,
    this.formatText,
  });

  /// The minimum value the user can enter.
  ///
  /// Defaults to `0.0`. Must be less than or equal to [max].
  ///
  /// If min is equal to [max], the input is disabled.
  final double min;

  /// The maximum value the user can enter.
  ///
  /// Defaults to `100.0`. Must be greater than or equal to [min].
  ///
  /// If max is equal to [min], the input is disabled.
  final double max;

  /// The step size for incrementing and decrementing the value.
  ///
  /// Defaults to `1.0`.
  final double step;

  /// The current value.
  ///
  /// Defaults to `0.0`.
  final double? value;

  /// The number of decimal places used for formatting the value.
  ///
  /// Defaults to `0`.
  final int decimals;

  final String Function(String text)? formatText;

  /* bool autofocus = false
  bool? enabled
  bool readOnly = false
  TextInputType? keyboardType
  TextInputAction? textInputAction
  InputDecoration? decoration
  String? Function(String?)? validator
  Brightness? keyboardAppearance
  Icon? incrementIcon
  Icon? decrementIcon
  double? iconSize
  MaterialStateProperty<Color?>? iconColor
  bool showButtons = true
  Axis direction = Axis.horizontal
  FocusNode? focusNode
  TextDirection textDirection = TextDirection.ltr
  TextStyle? textStyle
  Widget Function(BuildContext, EditableTextState)? contextMenuBuilder
  bool? showCursor
  Color? cursorColor
  bool enableInteractiveSelection = true
  double spacing = 8
  void Function(double)? onChanged
  void Function(double)? onSubmitted
  bool Function(double)? canChange
  void Function()? beforeChange
  void Function()? afterChange
  TextAlign textAlign = TextAlign.center */

  @override
  State<NumericalInput> createState() => _NumericalInputState();
}

class _NumericalInputState extends State<NumericalInput> {
  final _controller = TextEditingController();

  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? 0.0;
    if (widget.value != null) {
      _controller.text = _format();
    }
  }

  String _format() {
    return widget.formatText?.call(_value.toStringAsFixed(widget.decimals)) ??
        _value.toStringAsFixed(widget.decimals);
  }

  void _onClickPlus() {
    setState(() {
      _value += widget.step;
    });
    _controller.text = _format();
  }

  void _onClickMinus() {
    setState(() {
      _value -= widget.step;
    });
    _controller.text = _format();
  }

  void _onChangedValue(String val) {
    if (val.isEmpty) {
      setState(() {
        _value = 0;
      });
    }
    var doubleVal = double.parse(val);
    setState(() {
      _value = doubleVal;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        IconButton(
          onPressed: _onClickMinus,
          icon: const Icon(Icons.remove),
          iconSize: 16,
          padding: const EdgeInsets.all(4.0),
          constraints: const BoxConstraints(),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: _onChangedValue,
          ),
        ),
        IconButton(
          onPressed: _onClickPlus,
          icon: const Icon(Icons.add),
          iconSize: 16,
          padding: const EdgeInsets.all(4.0),
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
