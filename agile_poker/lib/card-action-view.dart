import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CardActionView extends StatefulWidget {
  final Function _onEditRequested;
  final Function _onDeleteRequested;

  CardActionView(
    this._onEditRequested,
    this._onDeleteRequested,
    {Key key}
  ) : super(key: key);

  @override
  _CardActionViewState createState() {
    final state = _CardActionViewState();
    _stateBridge._onUpdate = state.update;
    _stateBridge._onDataUpdate = (cards) => state.setCards(cards);
    state.onEditRequested = _onEditRequested;
    state.onDeleteRequested = _onDeleteRequested;
    return state;
  }

  void update(int currentIndex) {
    _stateBridge._onUpdate(currentIndex);
  }

  void setCards(List<String> cards) {
    _stateBridge._onDataUpdate(cards);
  }
}

class _CardActionViewState extends State<CardActionView> {
  var _current = '';
  var _previous = '';
  var _next = '';
  final _endStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );
  List<String> _cards;
  var _isInViewMode = true;
  var _isEditAvailable = true;

  @override
  Widget build(BuildContext context) {
    final layout = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _previousRowItem(),
        _currentRowItem(),
        _nextRowItem(),
      ],
    );
    return Material(
      child: layout,
      color: Colors.transparent,
    );
  }

  Widget _currentRowItem() {
    return _isInViewMode
      ? Expanded(
        child: Center(
          child: SizedBox(
            child: RaisedButton(
              onPressed: () {
                if(!_isEditAvailable) {
                  return;
                }
                setState(() {
                  _isInViewMode = !_isInViewMode;
                });
              },
              child: AutoSizeText(
                _current,
                minFontSize: 15,
                maxFontSize: 60,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            width: 80,
            height: 80,
          ),
        )
      )
      : Expanded(
        child: Center(
          child: SizedBox(
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  _isInViewMode = !_isInViewMode;
                });
              },
              child: Icon(
                Icons.arrow_back,
                size: 35,
              ),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              ),
            ),
            width: 80,
            height: 80,
          ),
        )
      );
  }

  Widget _previousRowItem() {
    return _isInViewMode
      ? SizedBox(
        child: AutoSizeText(
          _previous,
          minFontSize: 10,
          style: _endStyle,
          textAlign: TextAlign.center
        ),
        width: 100
      )
      : SizedBox(
      child: Center(
        child: SizedBox(
          child: RaisedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: AlertDialog(
                  title: Text('Delete Card?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () async {
                        await onDeleteRequested();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ).build
              );
            },
            child: Icon(Icons.delete_forever, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            color: Colors.redAccent,
          ),
          width: 60,
          height: 60,
        ),
      ),
      width: 100,
    );
  }

  Widget _nextRowItem() {
    return _isInViewMode
      ? SizedBox(
        child: AutoSizeText(
            _next,
            minFontSize: 10,
            style: _endStyle,
            textAlign: TextAlign.center
        ),
        width: 100,
      )
      : SizedBox(
        child: Center(
          child: SizedBox(
            child: RaisedButton(
              onPressed: onEditRequested,
              child: Icon(Icons.edit, color: Colors.white,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              color: Colors.grey,
            ),
            width: 60,
            height: 60,
          ),
        ),
        width: 100,
      );
  }

  void update(int currentIndex) {
    _isEditAvailable = currentIndex < _cards.length - 1;
    _current =
      currentIndex < _cards.length
        ? _cards[currentIndex]
        : ' ';
    _previous =
      currentIndex - 1 >= 0 && currentIndex - 1 < _cards.length
        ? '${_cards[currentIndex - 1]}'
        : ' ';
    _next =
      currentIndex + 1 < _cards.length
        ? '${_cards[currentIndex + 1]}'
        : ' ';
    setState(() {});
  }

  void setCards(List<String> cards) {
    _cards = cards;
  }

  Function onEditRequested;
  Function onDeleteRequested;
}

class CardActionViewStateBridge {
  Function _onUpdate;
  Function _onDataUpdate;
}

final _stateBridge = CardActionViewStateBridge();