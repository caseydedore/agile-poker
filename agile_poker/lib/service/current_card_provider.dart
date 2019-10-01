import 'package:flutter/foundation.dart';
import 'package:agile_poker/data/model/agile_card.dart';

class CurrentCardProvider with ChangeNotifier {
  AgileCard _currentCard;

  get currentCard => _currentCard;

  set currentCard (AgileCard value) {
    _currentCard = value;
    notifyListeners();
  }
}