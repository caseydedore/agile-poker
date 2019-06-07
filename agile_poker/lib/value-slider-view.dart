import 'package:flutter/material.dart';

class ValueSliderView extends StatefulWidget {
  ValueSliderView();

  @override
  ValueSliderViewState createState() => ValueSliderViewState();
}

class ValueSliderViewState extends State<ValueSliderView> {
  int value = 0;

  ValueSliderViewState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value.toString()),
        Slider(
          value: value.roundToDouble(),
          onChanged: (val) {
            setState(() {
              value = val.round();
            });
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