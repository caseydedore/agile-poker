import 'package:flutter/foundation.dart';
import 'package:agile_poker/data/agile_card_data.dart';
import 'package:agile_poker/data/model/agile_card.dart';

class DeckProvider with ChangeNotifier {
  List<AgileCard> _cards;
  final AgileCardData _data = AgileCardData();
  Future _initialLoad;

  DeckProvider() {
    _initialLoad = _data.getAgileCards();
    _initialLoad.then((cards) => _cards = cards);
  }

  Future<List<AgileCard>> get() async {
    await _initialLoad;
    return _cards;
  }

  set(List<AgileCard> newCards) {
    _cards = newCards;
    notifyListeners();
  }

  sortCards(CardSortMode mode) {
    if (mode == CardSortMode.asc) {
      _cards.sort((first, second) => first.number - second.number);
    } else {
      _cards.sort((first, second) => second.number - first.number);
    }
    notifyListeners();
  }
}

enum CardSortMode { asc, desc }