import 'package:flutter/material.dart';

class TelaCriacaoPage extends StatefulWidget {
  const TelaCriacaoPage({super.key});
  @override
  State<TelaCriacaoPage> createState() => _TelaCriacaoPageState();
}

class _TelaCriacaoPageState extends State<TelaCriacaoPage> {
  String titulo = "";
  String descricao = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova anotação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                ),
                onChanged: (value) {
                  titulo = value;
                },
              ),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                onChanged: (value) {
                  descricao = value;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Salvar',
        onPressed: () {
          if (titulo.isNotEmpty && descricao.isNotEmpty) {
            Map<String, dynamic> item = {
              titulo: descricao
            };
            Navigator.pop(context, item);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Preencha todos os campos'),
              ),
            );
          }
        },
        child: const Icon(
          Icons.save_outlined,
        ),
      ),
    );
  }
}
