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

  Widget _build(BuildContext context) {
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
            _imagePreview(),
            Container(
              child: FlatButton(
                  onPressed: _addImageToCard,
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
            await DeckRoot.of(context).updateCard(_card);
            Navigator.of(context).pop();
          },
        )
      ],
    ).build(context);
  }

  Widget _imagePreview() {
    return Container(
      child: _card.image.isNotEmpty
        ? Image.file(File(_card.image))
        : null
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final deckInterface = DeckRoot.of(context);
    CardDeleteDialogBuilder.create(
      card: deckInterface.currentCard,
    ).present(context);
  }

  void _addImageToCard() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final savedImage = await ImageStorage().saveImage(image);
    _card = AgileCard.asNew(id: _card.id, number: _card.number, image: savedImage);
  }
}