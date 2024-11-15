import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PageB extends StatefulWidget {
  const PageB({super.key});

  @override
  State<PageB> createState() {
    return _PageBState();
  }
}

class _PageBState extends State<PageB> {
  int _currentIndex = 0;
  final _formKey = GlobalKey<FormBuilderState>();

  // Cambia la pestaña actual
  void _goToNextTab() {
    setState(() {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _showSubmissionDialog();
      }
    });
  }

  // Mostrar el diálogo de confirmación
  void _showSubmissionDialog() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      String contentText = _formKey.currentState!.value.toString();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salesians Sarrià 24/25'),
      ),
      body: Column(
        children: [
          // Encabezado con botones de pestañas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabButton("Pers.", 0),
              _buildTabButton("Contact", 1),
              _buildTabButton("Upload", 2),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: _getFormForTab(_currentIndex),
              ),
            ),
          ),
          // Botones de CONTINUE y CANCEL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_currentIndex == 2) {
                    // Si está en la última pestaña, valida el formulario y muestra el diálogo
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      String? formString =
                          _formKey.currentState?.value.toString();
                      alertDialog(context, formString!);
                    }
                  } else {
                    // Si no está en la última pestaña, avanza a la siguiente
                    _goToNextTab();
                  }
                },
                child: const Text('CONTINUE'),
              ),

              TextButton(
                onPressed: () {
                  // Acción para cancelar (volver al inicio)
                  setState(() {
                    _currentIndex = 0;
                    _formKey.currentState?.reset();
                  });
                },
                child: const Text('CANCEL'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Construye los botones del encabezado
  Widget _buildTabButton(String title, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          color: _currentIndex == index ? Colors.blue : Colors.grey,
          fontWeight: _currentIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // Devuelve el formulario correspondiente a la pestaña actual
  Widget _getFormForTab(int index) {
    switch (index) {
      case 0:
        return Center(
          child: Text(
            'Personal\nPulsi "Contact" o pulsi el botó de "Continue".',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        );
      case 1:
        return Center(
          child: Text(
            'Contact\nPulsi "Upload" o pulsi el botó de "Continue".',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        );
      case 2:
        return Column(
          children: [
            FormBuilderTextField(
              name: 'email',
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              name: 'address',
              decoration: InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.required(),
            ),
            SizedBox(height: 16),
            FormBuilderTextField(
              name: 'mobile',
              decoration: InputDecoration(
                labelText: 'Mobile No',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
              ]),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
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
