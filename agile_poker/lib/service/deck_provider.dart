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

  Future addNewCard() async {
    final card = AgileCard.asNew();
    final newCard = await _data.addAgileCard(card);
    _cards.add(newCard);
    notifyListeners();
  }

  Future removeCard(AgileCard card) async {
    await _data.removeAgileCard(card);
    _cards.remove(card);
    notifyListeners();
  }

  Future updateCard(AgileCard card) async {
    await _data.updateAgileCard(card);
    final indexOfOriginal = _cards.indexWhere((old) => old.id == card.id);
    _cards.removeAt(indexOfOriginal);
    _cards.insert(indexOfOriginal, card);
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