import 'package:flutter/material.dart';
import 'deck_main_view.dart';
import 'data/agile_card_data.dart';
import 'data/model/agile_card.dart';

class DeckRoot extends StatefulWidget {
  @override
  DeckRootState createState() => DeckRootState();

  static DeckRootState of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_DeckRootStateManager) as _DeckRootStateManager).state;
}

class DeckRootState extends State<DeckRoot> {
  final _data = AgileCardData();
  AgileCard currentCard;
  List<AgileCard> cards;
  var cardsLoaded = false;

  @override
  void initState() {
    loadCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final view = cardsLoaded
      ? DeckMainView()
      : Container();
    return _DeckRootStateManager(state: this, deckView: view);
  }

  Future addNewCard() async {
    final card = AgileCard.asNew();
    currentCard = await _data.addAgileCard(card);
    cards.add(currentCard);
    setState(() {});
  }

  Future removeCard(AgileCard card) async {
    await _data.removeAgileCard(card);
    cards.remove(card);
    setState(() {});
  }

  Future updateCard(AgileCard card) async {
    await _data.updateAgileCard(card);
    final indexOfOriginal = cards.indexWhere((old) => old.id == card.id);
    cards.removeAt(indexOfOriginal);
    cards.insert(indexOfOriginal, card);
    currentCard = card;
    setState(() {});
  }

  Future loadCards() async {
    cards = await _data.getAgileCards();
    cardsLoaded = true;
    setState(() {});
  }
}

class _DeckRootStateManager extends InheritedWidget {
  final DeckRootState state;
  final Widget deckView;

  _DeckRootStateManager({@required this.state, @required this.deckView}) : super(
    child: MaterialApp(
      title: 'Agile Poker Deck',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: deckView,
    )
  );

  @override
  bool updateShouldNotify(_DeckRootStateManager oldWidget) => true;
}