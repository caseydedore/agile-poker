
class AgileCard {
  final int id;
  final int number;
  final String image;

  String get symbol => _numberToSymbol(number);

  AgileCard(this.id, this.number, this.image);

  factory AgileCard.asNew() {
    return AgileCard(0, 0, '');
  }

  factory AgileCard.fromString(String id, String symbol) {
    var number = 0;
    _remappedSymbols.forEach((key, value) {
      if (value == symbol) {
        number = key;
        return;
      }
    });
    return AgileCard(0, number, '');
  }

  String _numberToSymbol(int number) {
    return _remappedSymbols[number] ?? number.toString();
  }

  static const Map<int, String> _remappedSymbols = const {
    null: '',
    -1: '+',
    100: '∞',
    101: '?'
  };
}