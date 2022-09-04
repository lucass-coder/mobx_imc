import 'package:mobx/mobx.dart';
import 'package:mobx_imc/model/full_name.dart';
part 'contador_codegen_controller.g.dart';

class ContadorCodegenController = ContadorCodegenControllerBase
    with _$ContadorCodegenController;

abstract class ContadorCodegenControllerBase with Store {
  @observable
  var counter = 0;

  @observable
  var fullName = FullName(first: 'first', last: 'last');

  @computed
  String get saudacao => 'Olá ${fullName.first} $counter';

  @action
  void increment() {
    counter++;
  }

  @action
  void changeName() {
    fullName = fullName.copyWith(first: 'Lucas', last: 'Santana');
  }

  @action
  void rollbackName() {
    fullName = fullName.copyWith(first: 'First', last: 'Last');
  }
}
