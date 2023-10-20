import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericalInput extends StatefulWidget {
  const NumericalInput({
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.step = 1.0,
    this.value = 0.0,
    this.decimals = 0,
    this.decoration = const InputDecoration(
      isDense: true,
    ),
    this.formatText,
    this.onChanged,
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

  /// The decoration to show around the text field.
  ///
  /// It can be configured to show an icon, label, hint text, and error text.
  ///
  /// See [TextField.decoration]
  final InputDecoration? decoration;

  /// Callback function to format the text displayed in [TextField]
  final String Function(String text)? formatText;

  /// Called when the user initiates a change to the TextField's value: when they have inserted or deleted text, or press the increase or decrease buttons.
  final void Function(double value)? onChanged;

  @override
  State<NumericalInput> createState() => _NumericalInputState();
}

class _NumericalInputState extends State<NumericalInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  double _value = 0.0;

  String _format() {
    return widget.formatText?.call(_value.toStringAsFixed(widget.decimals)) ??
        _value.toStringAsFixed(widget.decimals);
  }

  void _listenFocus() {
    // When field loses focus
    if (!_focusNode.hasFocus) {
      _controller.text = _format();
    }
    // When field gains focus
    if (_focusNode.hasFocus) {
      _controller.text = _value.toStringAsFixed(widget.decimals);
    }
  }

  TextEditingValue _filterMinMax(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    var doubleValue = double.parse(newValue.text);
    if (doubleValue < widget.min) {
      return TextEditingValue(
          text: widget.min.toStringAsFixed(widget.decimals));
    }
    if (doubleValue > widget.max) {
      return TextEditingValue(
          text: widget.max.toStringAsFixed(widget.decimals));
    }
    return newValue;
  }

  void _onClickPlus() {
    if (_value + widget.step > widget.max) {
      return;
    }
    setState(() {
      _value += widget.step;
    });
    _controller.text = _format();
    widget.onChanged?.call(_value);
  }

  void _onClickMinus() {
    if (_value - widget.step < widget.min) {
      return;
    }
    setState(() {
      _value -= widget.step;
    });
    _controller.text = _format();
    widget.onChanged?.call(_value);
  }

  void _onChangedValue(String val) {
    if (val.isEmpty) {
      setState(() {
        _value = widget.min;
      });
      widget.onChanged?.call(_value);
      return;
    }
    var doubleVal = double.parse(val);
    setState(() {
      _value = doubleVal;
    });
    widget.onChanged?.call(_value);
  }

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? 0.0;
    if (widget.value != null) {
      _controller.text = _format();
    }
    _focusNode.addListener(() {
      _listenFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(() {
      _listenFocus();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: _value == widget.min
                  ? Theme.of(context).disabledColor
                  : const Color(0xFF000000),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: ElevatedButton(
            onPressed: _value == widget.min ? null : _onClickMinus,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Icon(
              Icons.remove,
              size: 16,
              color: _value == widget.min
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 28,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: widget.decoration,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                TextInputFormatter.withFunction(_filterMinMax)
              ],
              onChanged: _onChangedValue,
            ),
          ),
        ),
        Container(
          width: 24,
          height: 24,
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: _value == widget.max
                  ? Theme.of(context).disabledColor
                  : const Color(0xFF000000),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: ElevatedButton(
            onPressed: _value == widget.max ? null : _onClickPlus,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Icon(
              Icons.add,
              size: 16,
              color: _value == widget.max
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
        ),
      ],
    );
  }
}
