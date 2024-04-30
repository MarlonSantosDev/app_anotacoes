import 'package:app_anotacoes/tela_criacao_page.dart';
import 'package:app_anotacoes/tela_edicao_page.dart';
import 'package:flutter/material.dart';

/*
  Faça o app_anotacoes funcionar
  Faça a refação do app_anotacoes MVC
    - Model (Modelos de dados)
    - View (Telas)
    - Controller (Regras de negócio)
 Faça utilizado model de anotacao (Titulo, description, status) * Modelo
 Faça utilizado alguma gerencia de estado
 (Opcionais)
 O aplicativo tem de recuperar as anotacoes criadas quando é aberto (Faça uma chamada API ou Shared Preferences) 
 
 */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const TelaInicialPage(),
    );
  }
}

class TelaInicialPage extends StatefulWidget {
  const TelaInicialPage({super.key});

  @override
  State<TelaInicialPage> createState() => _TelaInicialPageState();
}

class _TelaInicialPageState extends State<TelaInicialPage> {
  List<Map<String, dynamic>> listaDeAnotacoes = [];

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
                        listaDeAnotacoes[index].keys.toString(),
                      ),
                      subtitle: Text(
                        listaDeAnotacoes[index].values.toString(),
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
                                  listaDeAnotacoes[index] = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const TelaEdicaoPage(
                                        item: {},
                                      ),
                                    ),
                                  );
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TelaCriacaoPage(),
            ),
          );
        },
      ),
    );
  }
}
