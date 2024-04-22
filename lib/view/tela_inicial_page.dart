import 'package:app_anotacoes/global/global.dart';
import 'package:app_anotacoes/view/tela_criacao_page.dart';
import 'package:app_anotacoes/view/tela_edicao_page.dart';
import 'package:flutter/material.dart';

class TelaInicialPage extends StatefulWidget {
  const TelaInicialPage({super.key});

  @override
  State<TelaInicialPage> createState() => _TelaInicialPageState();
}

class _TelaInicialPageState extends State<TelaInicialPage> {

  
  List<Map<String, dynamic>> listaDeAnotacoes = [];

  updateTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minhas anotações ${listaDeAnotacoes.length}',
        ),
        actions: [
          Visibility(
            visible: listaDeAnotacoes.isNotEmpty,
            child: IconButton(
              icon: const Icon(
                Icons.delete_sweep,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Atenção!!'),
                      content: const Text(
                        'Deseja remover todas as anotações ',
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            listaDeAnotacoes = [];
                            updateTela();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: listaDeAnotacoes.isEmpty
          ? const Center(
              child: Text("Não há anotações"),
            )
          : ListView.builder(
              itemCount: listaDeAnotacoes.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Text("${index + 1}°"),
                      title: Text(
                        ajustarTexto(listaDeAnotacoes[index].keys),
                      ),
                      subtitle: Text(
                        ajustarTexto(listaDeAnotacoes[index].values)
                      ),
                      trailing: SizedBox(
                        width: 65,
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.amberAccent,
                                ),
                                onPressed: () async {
                                  listaDeAnotacoes[index] =
                                      await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TelaEdicaoPage(
                                        item: listaDeAnotacoes[index],
                                      ),
                                    ),
                                  );
                                  updateTela();
                                },
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  listaDeAnotacoes.removeAt(index);
                                  updateTela();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nova nota',
        onPressed: () async {
          Map<String, dynamic> novoitem = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TelaCriacaoPage(),
            ),
          );
          listaDeAnotacoes.add(novoitem);
          updateTela();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
