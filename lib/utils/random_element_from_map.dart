import 'dart:math';

dynamic randomElementFromMap(Map map) {
  final _random = new Random();
  var values = map.values.toList();
  var element = values[_random.nextInt(values.length)];
  return element;
}
