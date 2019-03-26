
class AgileCard {
  final int id;
  final int number;
  String get symbol => _numberToSymbol(number);

  AgileCard(this.id, this.number);

  factory AgileCard.asNewCardPlaceholder() {
    return AgileCard(0, -1);
  }

  String _numberToSymbol(int number) {
    return _remappedSymbols[number] ?? number.toString();
  }

  static const Map<int, String> _remappedSymbols = const {
    null: '',
    -1: '+',
    100: 'inf',
    101: '?'
  };
}