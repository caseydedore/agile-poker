import 'package:flutter/material.dart';

class AgileCard extends StatelessWidget {
  final int _number;

  AgileCard.asNumber(this._number);

  factory AgileCard.asBlank(Function onTap) {
    return AgileCard.asNumber(null);
  }

  @override
  Widget build(BuildContext context) {
    final width = 300.0;
    final height = 450.0;
    final margin = EdgeInsets.all(20.0);
    final card = Container(
      width: width,
      height: height,
      child: _getCardText(),
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(width:3, color: Colors.black26),
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[100],
      ),
    );
    final materialCard = Material(
      child: card,
      color: Colors.transparent,
    );
    return materialCard;
  }

  Widget _getCardText() {
    final text = Text('${_number ?? ''}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.fade,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 180,
        color: Colors.black87
      ),
    );
    final textContainer = Center(
      child: text,
    );
    return textContainer;
  }
}