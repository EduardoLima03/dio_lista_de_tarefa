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
                      onPressed: () {
                        debugPrint(descricaoControler.text);
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
