import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(FormApp());

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormA(),
    );
  }
}

class FormA extends StatefulWidget {
  @override
  _FormAState createState() => _FormAState();
}

class _FormAState extends State<FormA> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulario A")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'nombre',
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              FormBuilderRadioGroup(
                name: 'sexo',
                decoration: InputDecoration(labelText: 'Sexo'),
                options: ['Masculino', 'Femenino']
                    .map((sexo) => FormBuilderFieldOption(value: sexo))
                    .toList(),
              ),
              FormBuilderCheckboxGroup(
                name: 'intereses',
                decoration: InputDecoration(labelText: 'Intereses'),
                options: ['Música', 'Deportes', 'Lectura']
                    .map((interes) => FormBuilderFieldOption(value: interes))
                    .toList(),
              ),
              FormBuilderDropdown(
                name: 'pais',
                decoration: InputDecoration(labelText: 'País'),
                items: ['España', 'Francia', 'Alemania']
                    .map((pais) => DropdownMenuItem(value: pais, child: Text(pais)))
                    .toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    print(_formKey.currentState?.value);
                  } else {
                    print("Validación fallida");
                  }
                },
                child: Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
