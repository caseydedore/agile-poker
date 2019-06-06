import 'package:flutter/material.dart';

class ValueSliderView extends StatelessWidget {
  final double _initialValue;
  final ValueSliderChange _onChanged;

  ValueSliderView(this._initialValue, this._onChanged);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Slider(
        value: _initialValue,
        onChanged: _onChanged,
        max: 101,
        min: 0,
        divisions: 101,
      )
    );
  }
}

typedef void ValueSliderChange(double value);