import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../screens/home.dart';

class ItemLista extends StatefulWidget {
  final Tarefa tarefa;
  final HomeState _widgetPai;
  final TextEditingController controlador = TextEditingController();
  bool edicao = false;

  ItemLista(this.tarefa, this._widgetPai, {super.key, this.edicao = false});

  @override
  State<StatefulWidget> createState() {
    return ItemListaState();
  }
}

class ItemListaState extends State<ItemLista> {
  late final TapAction _tapAction;

  void mudaParaEdicao() {
    widget._widgetPai.mudaParaEdicao(widget);
    // setState(() {
    //   widget.edicao = true;
    //   widget._controlador.text = widget._tarefa.descricao;
    //   widget._widgetPai.widget.icone = Icons.done;
    //
    //   // widget._tarefa.emEdicao = false;
    // });
  }

  @override
  void initState() {
    super.initState();
    _tapAction = TapAction();
  }

  @override
  Widget build(BuildContext context) {
    widget.controlador.text = widget.tarefa.descricao;
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            widget.edicao
                ? Expanded(
                    flex: 1,
                    child: TextField(
                      controller: widget.controlador,
                      decoration: InputDecoration(
                          constraints: BoxConstraints.tight(const Size(300, 100)),
                          border: const UnderlineInputBorder()),
                      style: const TextStyle(fontSize: 20.0),
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      onChanged: (valor) {
                        setState(() {
                          widget.tarefa.descricao = widget.controlador.text;
                          widget.tarefa.emEdicao = false;
                        });
                      },
                    ),
                  )
                : Expanded(
                    child: ActionListener(
                      action: _tapAction,
                      listener: (Action<Intent> action) {
                        if (action.intentType == TapIntent) {
                          mudaParaEdicao();
                        }
                      },
                      child: ListTile(
                        title: !widget.tarefa.status
                            ? Text(
                                widget.tarefa.descricao,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(fontSize: 20.0),
                                maxLines: 5,
                                softWrap: true,
                              )
                            : Text(
                                widget.tarefa.descricao,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey[500]),
                                maxLines: 5,
                              ),
                        onLongPress: () {
                          widget._widgetPai.remover(widget.tarefa);
                        },
                        onTap: () => const ActionDispatcher()
                            .invokeAction(_tapAction, const TapIntent()),
                      ),
                    ),
                  ),
            Checkbox(
                value: widget.tarefa.status,
                onChanged: (novoValor) {
                  setState(() {
                    widget.tarefa.status = novoValor ?? false;
                  });
                })
          ],
        ));
  }
}

class TapAction extends Action<TapIntent> {

  @override
  void invoke(covariant TapIntent intent) {
    notifyActionListeners();
  }
}

class TapIntent extends Intent {
  const TapIntent();
}
