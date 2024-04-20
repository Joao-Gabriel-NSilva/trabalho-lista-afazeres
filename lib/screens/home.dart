import 'package:flutter/material.dart';

import '../components/item_lista.dart';
import '../models/tarefa.dart';

class Home extends StatefulWidget {
  final List<Tarefa> _tarefas = [];
  final TextEditingController controlador = TextEditingController();
  IconData icone = Icons.add;
  bool novo = false;
  Tarefa? tarefaEmEdicao;

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  void mudaParaEdicao(wid) {
    setState(() {
      widget.tarefaEmEdicao = wid.tarefa;
      wid.edicao = true;
      widget.novo = true;
      wid.controlador.text = wid.tarefa.descricao;
      widget.icone = Icons.done;
      wid.tarefa.emEdicao = true;
      widget._tarefas.firstWhere((a) => a == wid.tarefa).emEdicao = true;
    });
  }

  void remover(t) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmação'),
            content: const Text('Deseja excluir esse item?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget._tarefas.remove(t);
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('Ok')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    return;
                  },
                  child: const Text('Cancelar'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Afazeres'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(widget.icone),
        onPressed: () {
          if (!widget.novo) {
            setState(() {
              Tarefa t = Tarefa(descricao: '', status: false, emEdicao: true);
              widget.tarefaEmEdicao = t;
              widget._tarefas.add(t);
              widget.novo = true;
              widget.icone = Icons.done;
            });
          } else {
            setState(() {
              widget.icone = Icons.add;
              widget.novo = false;
              if (widget.tarefaEmEdicao?.descricao.isEmpty ?? false) {
                widget._tarefas.remove(widget.tarefaEmEdicao);
              } else {
                widget._tarefas
                    .firstWhere((a) => a == widget.tarefaEmEdicao)
                    .emEdicao = false;
                widget.tarefaEmEdicao?.emEdicao = false;
              }
            });
          }
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget._tarefas.length,
              itemBuilder: (context, index) {
                ItemLista? item;
                if (widget._tarefas[index].descricao.isNotEmpty ||
                    widget._tarefas[index].emEdicao) {
                  item = ItemLista(
                    widget._tarefas[index],
                    this,
                    edicao: widget._tarefas[index].emEdicao,
                  );
                }
                return item;
              },
            ),
          ),
        ],
      ),
    );
  }
}
