import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PageA extends StatefulWidget {
  const PageA({super.key});

  @override
  State<PageA> createState() {
    return _PageAState();
  }
}

class _PageAState extends State<PageA> {
  final String title = 'Salesians Sarrià 24/25';
  final _formKey = GlobalKey<FormBuilderState>();
  var velocityOptions = ['above 40km/h, below 40km/h, 0km/h'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormTitle(),
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormLabelGroup(
                        title: 'Please provide the speed of vehicle?',
                        subtitle: 'please select one option given below',
                      ),
                      FormBuilderRadioGroup(
                        decoration: InputDecoration(border: InputBorder.none),
                        name: "speed",
                        orientation: OptionsOrientation.vertical,
                        options: const [
                          FormBuilderFieldOption(value: 'above 40km/h'),
                          FormBuilderFieldOption(value: 'below 40km/h'),
                          FormBuilderFieldOption(value: '0km/h')
                        ],
                        onChanged: (String? value) {
                          debugPrint(value);
                        },
                      ),
                      FormLabelGroup(title: 'Enter remarks'),
                      FormBuilderTextField(
                        name: 'remark',
                        decoration: InputDecoration(
                          labelText: 'Enter your remarks',
                        ),
                      ),
                      FormLabelGroup(
                        title: 'Please provide the high speed of vehicle?',
                        subtitle: 'please select one option given below',
                      ),
                      FormBuilderDropdown(
                        name: 'highspeed',
                        decoration: InputDecoration(
                          hintText: 'Select Option',
                        ),
                        items: ['High', 'Medium', 'Low'] // lista de opciones
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                      ),
                      FormLabelGroup(
                        title:
                            'Please provide the speed of the vehicle past 1 hour?',
                        subtitle:
                            'please select one or more options given below',
                      ),
                      FormBuilderCheckboxGroup(
                        name: 'selectSpeed',
                        orientation: OptionsOrientation.vertical,
                        options: const [
                          FormBuilderFieldOption(value: '20 km/h'),
                          FormBuilderFieldOption(value: '30 km/h'),
                          FormBuilderFieldOption(value: '40 km/h'),
                          FormBuilderFieldOption(value: '50 km/h'),
                        ],
                      ),
                    ]),
              ),
              // FormBuilder campos aquí
            ),
          ],
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

class FormTitle extends StatelessWidget {
  const FormTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Driving Form',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Form example',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
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

class FormLabelGroup extends StatelessWidget {
  final String title;
  final String? subtitle;

  FormLabelGroup({super.key, required this.title, this.subtitle});

  Widget conditionalSubtitle(BuildContext context) {
    if (subtitle != null) {
      return Text(
        subtitle!,
        style: Theme.of(context).textTheme.labelLarge?.apply(
              fontSizeFactor: 1.25,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        conditionalSubtitle(context),
      ],
    );
  }
}
