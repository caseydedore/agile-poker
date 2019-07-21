import 'package:flutter/material.dart';
import 'package:agile_poker/deck_root.dart';
import '../data/model/agile_card.dart';
import '../service/image_storage.dart';

class CardDeleteDialogBuilder {
  final AgileCard _card;

  CardDeleteDialogBuilder(this._card);

  factory CardDeleteDialogBuilder.create({@required AgileCard card}) =>
      CardDeleteDialogBuilder(card);

  void present(BuildContext context) async {
    await showDialog(
      context: context,
      builder: _build
    );
  }

  Widget _build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Card'),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: Navigator.of(context).pop
        ),
        FlatButton(
          child: Text('Ok'),
          onPressed: () { _deleteCard(context); } ,
        )
      ],
    );
  }

  void _deleteCard(BuildContext context) async {
    await ImageStorage().deleteImage(_card.image);
    await DeckRoot.of(context).removeCard(_card);
    Navigator.of(context).pop();
  }
}