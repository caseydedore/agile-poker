import 'package:flutter/material.dart';
import 'package:agile_poker/data/agile_card_data.dart';
import 'package:agile_poker/data/model/agile_card.dart';
import 'package:agile_poker/agile_card_view.dart';

class AgileCardEditView extends StatefulWidget {
  final AgileCard _card;
  final Function _onEditComplete;

  AgileCardEditView(this._card, this._onEditComplete);

  @override
  _AgileCardEditViewState createState() => _AgileCardEditViewState(_card, _onEditComplete);
}

class _AgileCardEditViewState extends State<AgileCardEditView> {
  AgileCard _card;
  final _data = AgileCardData();
  final Function _onEditComplete;

  _AgileCardEditViewState(this._card, this._onEditComplete);

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: <Widget>[
        AgileCardView.as(_card),
        Material(
          child: Slider(
              value: _card.number.roundToDouble(),
              onChanged: _onValueChange,
              min: 0,
              max: 99
          ),
        ),
        ConstrainedBox(
          child: RaisedButton(
            child: const Text('Delete'),
            onPressed: () async {
              await _data.removeAgileCard(_card);
              await _onEditComplete();
              Navigator.pop(context);
            },
            color: Colors.redAccent,
          ),
          constraints: const BoxConstraints(minWidth: double.infinity),
        )
      ],
    );
    final exitHandler = WillPopScope(
      child: content,
      onWillPop: _updateCard,
    );
    return exitHandler;
  }

  Future<bool> _updateCard() async {
    await _data.updateAgileCard(_card);
    await _onEditComplete();
    return true;
  }

  void _onValueChange(double value) {
    _card = AgileCard(_card.id, value.round());
    setState(() {});
  }
}
