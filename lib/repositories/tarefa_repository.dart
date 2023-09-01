import 'package:dio_lista_de_tarefa/model/tarefa.dart';

class TarefaRepository {
  // base de dados
  // Repository é responsavel por salvar(manipulor os dados)
  List<Tarefa> _tarefas = [];

  Future<void> adicionor(Tarefa tarefa) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.add(tarefa);
  }

  Future<void> alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas
        .where((element) => element.getId() == id)
        .first
        .setConcluido(concluido);
  }

  Future<List<Tarefa>> listarTarefas() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tarefas;
  }

  Future<List<Tarefa>> listarNaoConcluida() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tarefas.where((element) => !element.getConcluido()).toList();
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _tarefas.remove(_tarefas.where((element) => element.getId() == id).first);
  }
}
