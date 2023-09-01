import 'package:dio_lista_de_tarefa/model/tarefa.dart';
import 'package:dio_lista_de_tarefa/repositories/tarefa_repository.dart';
import 'package:flutter/material.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  TextEditingController descricaoControler = TextEditingController();

  var _tarefas = <Tarefa>[];

  var apenasNaoConcluido = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    if (apenasNaoConcluido) {
      _tarefas = await tarefaRepository.listarNaoConcluida();
    } else {
      _tarefas = await tarefaRepository.listarTarefas();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descricaoControler.text = '';
          showDialog(
              context: context,
              builder: (BuildContext build) {
                return AlertDialog(
                  title: const Text('Adicionar Tarefa'),
                  content: TextField(
                    controller: descricaoControler,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        var tarefa = Tarefa(descricaoControler.text, false);
                        await tarefaRepository.adicionor(tarefa);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        obterTarefas();
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  const Text('Apenas não concluídos'),
                  Switch(
                      value: apenasNaoConcluido,
                      onChanged: (bool value) {
                        apenasNaoConcluido = value;
                        obterTarefas();
                      })
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (BuildContext bc, int index) {
                    return Dismissible(
                      onDismissed: (DismissDirection direction) async {
                        await tarefaRepository.remove(_tarefas[index].getId());
                        obterTarefas();
                      },
                      key: Key(_tarefas[index].getId()),
                      child: ListTile(
                        title: Text(_tarefas[index].getDescricao()),
                        trailing: Switch(
                            value: _tarefas[index].getConcluido(),
                            onChanged: (bool value) async {
                              await tarefaRepository.alterar(
                                  _tarefas[index].getId(), value);
                              obterTarefas();
                            }),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
