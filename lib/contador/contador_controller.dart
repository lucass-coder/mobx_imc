

import 'package:mobx/mobx.dart';

class ContadorController {

  var _counter = Observable<int>(0, name: 'counter observable');
  late Action increment;

  ContadorController() {
    increment = Action(_incrementCounter);
  }

  int get counter => _counter.value;

  void _incrementCounter() {
    _counter.value++;
  }

 }