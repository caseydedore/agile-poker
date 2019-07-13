import 'package:flutter/material.dart';
import 'package:agile_poker/data/model/agile_card.dart';

class ValueSliderView extends StatefulWidget {
  final int _initialValue;
  final int _minValue;
  final int _maxValue;
  final ValueSliderChange _onChanged;

  ValueSliderView(this._initialValue, this._minValue, this._maxValue, this._onChanged);

  @override
  ValueSliderViewState createState() =>
      ValueSliderViewState(_initialValue, _minValue, _maxValue, _onChanged);
}

class ValueSliderViewState extends State<ValueSliderView> {
  int _value = 0;
  final int _min;
  final int _max;
  final ValueSliderChange _onChanged;

  ValueSliderViewState(this._value, this._min, this._max, this._onChanged);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AgileCard.asNew(id: 0, number: _value).symbol),
        Slider(
          value: _value.roundToDouble(),
          onChanged: (val) {
            _value = val.round();
            _onChanged(_value);
            setState(() { });
          },
          max: _max.toDouble(),
          min: _min.toDouble(),
        )
      ],
    );
  }
}

typedef void ValueSliderChange(int value);