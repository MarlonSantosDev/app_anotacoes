import 'package:app_anotacoes/global/global.dart';
import 'package:flutter/material.dart';

class TelaEdicaoPage extends StatefulWidget {
  final Map<String, dynamic> item;
  const TelaEdicaoPage({super.key, required this.item});

  @override
  State<TelaEdicaoPage> createState() => _TelaEdicaoPageState();
}

class _TelaEdicaoPageState extends State<TelaEdicaoPage> {

  String titulo = "";
  String descricao = "";

  @override
  initState() {
    super.initState();
    titulo = ajustarTexto(widget.item.keys);
    descricao = ajustarTexto(widget.item.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição de anotação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: titulo,
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                ),
                onChanged: (value) {
                  titulo = value;
                },
              ),
              TextFormField(
                initialValue: descricao,
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
            Map<String, dynamic> item = {titulo: descricao};
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
