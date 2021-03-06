
class AgileCard {
  final int id;
  final int number;
  final String image;

  String get symbol => _numberToSymbol(number);

  AgileCard._(this.id, this.number, this.image);

  factory AgileCard.asNew({int id, int number, String image}) {
    return AgileCard._(id ?? 0, number ?? 0, image ?? '');
  }

  factory AgileCard.fromString(String id, String symbol) {
    var number = 0;
    _remappedSymbols.forEach((key, value) {
      if (value == symbol) {
        number = key;
        return;
      }
    });
    return AgileCard._(0, number, '');
  }

  String _numberToSymbol(int number) {
    return _remappedSymbols[number] ?? number.toString();
  }

  static const Map<int, String> _remappedSymbols = const {
    -1: '+',
    100: '∞',
    101: '?'
  };
}