import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../deck_root.dart';
import '../data/model/agile_card.dart';
import 'value_slider_view.dart';
import 'card_delete_dialog_builder.dart';
import 'package:agile_poker/service/image_storage.dart';

class CardEditDialogBuilder {
  AgileCard _card;
  final int _maxValue;
  final int _minValue;

  CardEditDialogBuilder._(this._card, this._minValue, this._maxValue);

  factory CardEditDialogBuilder.create({
    @required AgileCard card,
    @required int minValue,
    @required int maxValue
  }) => CardEditDialogBuilder._(card, minValue, maxValue);
  
  void present(BuildContext context) async {
    await showDialog(
      context: context,
      builder: _build
    );
  }

  Widget _build(BuildContext context) => _EditDialog(_card, _minValue, _maxValue);
}

class _EditDialog extends StatefulWidget {
  final AgileCard _card;
  final int _maxValue;
  final int _minValue;

  _EditDialog(this._card, this._minValue, this._maxValue);

  @override
  State<StatefulWidget> createState() => _EditDialogState(_card, _minValue, _maxValue);
}

class _EditDialogState extends State<_EditDialog> {
  AgileCard _card;
  final int _minValue, _maxValue;
  File _previewImage;

  _EditDialogState(this._card, this._minValue, this._maxValue) {
    _previewImage  = _card.image.isNotEmpty
      ? File(_card.image)
      : null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adjust Value'),
      content: Center(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: ValueSliderView(
                _card.number,
                _minValue,
                _maxValue,
                (val) { _card = AgileCard.asNew(id: _card.id, number: val, image: _card.image); }
              )
            ),
            Container(
              child: _previewImage != null
                ? Image.file(_previewImage)
                : null
            ),
            Container(
              child: FlatButton(
                onPressed: _addImageToCardPreview,
                child: Text('Choose Image')
              ),
              padding: EdgeInsets.only(bottom: 20),
            ),
          ]
        ),
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
            final savedImage = await ImageStorage().saveImage(_previewImage);
            _card = AgileCard.asNew(id: _card.id, number: _card.number, image: savedImage);
            await DeckRoot.of(context).updateCard(_card);
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

  Future _addImageToCardPreview() async {
    _previewImage = await ImagePicker.pickImage(source: ImageSource.gallery) ?? _previewImage;
    _card = AgileCard.asNew(id: _card.id, number: _card.number, image: _previewImage?.path ?? '');
    setState(() {});
  }
}