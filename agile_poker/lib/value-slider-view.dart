import 'package:flutter/material.dart';

class ValueSliderView extends StatefulWidget {
  final int _initialValue;
  final ValueSliderChange _onChanged;

  ValueSliderView(this._initialValue, this._onChanged);

  @override
  ValueSliderViewState createState() => ValueSliderViewState(_initialValue, _onChanged);
}

class ValueSliderViewState extends State<ValueSliderView> {
  int _value = 0;
  final ValueSliderChange _onChanged;

  ValueSliderViewState(this._value, this._onChanged);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_value.toString()),
        Slider(
          value: _value.roundToDouble(),
          onChanged: (val) {
            _value = val.round();
            _onChanged(_value);
            setState(() { });
          },
          max: 101,
          min: 0,
          divisions: 101,
        )
      ],
    );
  }
}

typedef void ValueSliderChange(int value);