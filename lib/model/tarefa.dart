import 'package:flutter/material.dart';

class Tarefa {
  String _id = UniqueKey().toString();
  String _descricao = "";
  bool _concluido = false;

  Tarefa(this._descricao, this._concluido);

  String getId() => _id;

  void setId(String id) {
    _id = id;
  }

  String getDescricao() => _descricao;

  void setDescicao(String descricao) {
    _descricao = descricao;
  }

  bool getConcluido() => _concluido;

  void setConcluido(bool concluido) {
    _concluido = concluido;
  }
}
