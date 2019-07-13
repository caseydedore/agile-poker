import 'package:flutter/material.dart';
import '../deck_root.dart';
import '../data/model/agile_card.dart';
import 'value_slider_view.dart';
import 'card_delete_dialog_builder.dart';

class CardEditDialogBuilder {
  AgileCard _value;
  final int _maxValue;
  final int _minValue;

  CardEditDialogBuilder(this._value, this._minValue, this._maxValue);

  factory CardEditDialogBuilder.create({
    @required AgileCard card,
    @required int minValue,
    @required int maxValue
  }) =>
    CardEditDialogBuilder(card, minValue, maxValue);
  
  void present(BuildContext context) async {
    await showDialog(
      context: context,
      builder: _build
    );
  }

  Widget _build(BuildContext context) {
    return AlertDialog(
      title: Text('Adjust Value'),
      content: SingleChildScrollView(
        child: ValueSliderView(
          _value.number,
          _minValue,
          _maxValue,
          (val) { _value = AgileCard.asNew(id: _value.id, number: val); }
        )
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: Navigator.of(context).pop,
        ),
        FlatButton(
          child: Text('Delete', style: TextStyle(color: Colors.redAccent),),
          onPressed: () {
            _showDeleteDialog(context);
          }
        ),
        FlatButton(
          child: Text('Ok'),
          onPressed: () async {
            await DeckRoot.of(context).updateCard(_value);
            Navigator.of(context).pop();
          },
        )
      ],
    ).build(context);
  }

  void _showDeleteDialog(BuildContext context) {
    final deckInterface = DeckRoot.of(context);
    CardDeleteDialogBuilder.create(
      card: deckInterface.currentCard,
    ).present(context);
  }
}