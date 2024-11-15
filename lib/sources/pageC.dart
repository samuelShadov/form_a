import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PageC extends StatefulWidget {
  const PageC({super.key});

  @override
  State<PageC> createState() => _PageCState();
}

class _PageCState extends State<PageC> {
  final String title = 'Salesians Sarrià 24/25';
  final _formKey = GlobalKey<FormBuilderState>();
  var velocityOptions = ['above 40km/h, below 40km/h, 0km/h'];
  int _currentLength = 0;
  final int _maxLength = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20), // Añadimos padding para crear el espacio
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FormBuilderChoiceChip<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Choice Chips',
                    border: OutlineInputBorder(),
                  ),
                  name: 'choice_chips',
                  options: const [
                    FormBuilderChipOption(
                      value: 'Flutter',
                    ),
                    FormBuilderChipOption(
                      value: 'Android',
                    ),
                    FormBuilderChipOption(
                      value: 'Chrome OS',
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Espacio entre widgets

                FormBuilderSwitch(
                  title: const Text('This is a switch'),
                  decoration: const InputDecoration(
                    labelText: 'Switch',
                    border: OutlineInputBorder(),
                  ),
                  name: 'switch',
                  initialValue: false,
                ),
                const SizedBox(height: 20),

                Stack(
                  children: [
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        labelText: 'Text Field',
                        border: OutlineInputBorder(),
                      ),
                      name: 'textField',
                      onChanged: (val) {
                        setState(() {
                          _currentLength = val?.length ?? 0;
                        });
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.maxLength(_maxLength),
                      ]),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Text(
                        '$_currentLength/$_maxLength',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                FormBuilderDropdown(
                  decoration: const InputDecoration(
                    labelText: 'Dropdown Field',
                    border: OutlineInputBorder(),
                  ),
                  name: 'dropdown',
                  items: ['Finland', 'Spain', 'United Kingdom'] // Lista de opciones
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),

                FormBuilderRadioGroup(
                  decoration: const InputDecoration(
                    labelText: 'Radio Group',
                    border: OutlineInputBorder(),
                  ),
                  name: "speed",
                  orientation: OptionsOrientation.vertical,
                  options: const [
                    FormBuilderFieldOption(value: 'Option 1'),
                    FormBuilderFieldOption(value: 'Option 2'),
                    FormBuilderFieldOption(value: 'Option 3'),
                    FormBuilderFieldOption(value: 'Option 4'),
                  ],
                  onChanged: (String? value) {
                    debugPrint(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload),
        onPressed: () {
          _formKey.currentState?.saveAndValidate();
          String? formString = _formKey.currentState?.value.toString();
          alertDialog(context, formString!);
        },
      ),
    );
  }
}

void alertDialog(BuildContext context, String contentText) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Submission Completed"),
      icon: const Icon(Icons.check_circle),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Close'),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
