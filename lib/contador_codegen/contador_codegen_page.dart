// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_imc/contador_codegen/contador_codegen_controller.dart';

class ContadorCodeGenPage extends StatefulWidget {
  ContadorCodeGenPage({Key? key}) : super(key: key);

  @override
  State<ContadorCodeGenPage> createState() => _ContadorCodeGenPageState();
}

class _ContadorCodeGenPageState extends State<ContadorCodeGenPage> {
  final controller = ContadorCodegenController();
  final reactionDisposer = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();

    // autorun fica escutando as variáveis que estão sendo usadas dentro dele
    // e também roda logo quando criado!!!

    // Ele vai rodar sempre que for criado
    // E quando algum dos observáveis que esta dentro dele for alterado também
    // Reaction
    final autorunDisposer = autorun((_) {
      log('----------------------- Auto Run ---------------------');
      log(controller.fullName.first);
    });

    // reaction fica escutando as variáveis que estão sendo usadas dentro dele
    // Mas ele NÃO roda logo quando criado!!! APENAS quando observavel dele
    // for alterado

    // reaction nós falamos para o mobx qual o atributo observavel que queremos observar
    // Tem que dizer qual atributo vai observar (apenas 1)
    final reactionDiposer = reaction((_) => controller.counter, (counter) {
      log('----------------------- Reaction ---------------------');
      print(counter);
    });

    // WHEN roda somente UMA VEZ!!!
    // Portanto a partir do momento que ele for TRUE, se a condição se repetir
    // Ele não executa mais
    final whenDisposer = when((_) => controller.fullName.first == 'Lucas', () {
      log('----------------------- WHEN ---------------------');
      log(controller.fullName.first);
    });

    reactionDisposer.add(autorunDisposer);
    reactionDisposer.add(reactionDiposer);
    reactionDisposer.add(whenDisposer);
  }

  @override
  void dispose() {
    super.dispose();
    reactionDisposer.forEach((reaction) => reaction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador MobX CodeGen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) {
                return Text(
                  '${controller.counter}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Observer(
              builder: (_) {
                return Text(
                  controller.fullName.first,
                );
              },
            ),
            Observer(
              builder: (_) {
                return Text(
                  controller.fullName.last,
                );
              },
            ),
            Observer(
              builder: (_) {
                return Text(
                  controller.saudacao,
                );
              },
            ),
            TextButton(
              onPressed: () => controller.changeName(),
              child: const Text('Change Name'),
            ),
            TextButton(
              onPressed: () => controller.rollbackName(),
              child: const Text('Rolback Name'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
