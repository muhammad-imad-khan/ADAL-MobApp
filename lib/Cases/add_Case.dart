import 'package:Adal/Cases/CaseModel.dart';
import 'package:Adal/Cases/Case_api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddCases extends StatefulWidget {
  const AddCases({Key? key}) : super(key: key);

  @override
  State<AddCases> createState() => _AddCasesState();
}

class _AddCasesState extends State<AddCases> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();

  void addCases() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      final case_ = Cases(
        id: 0,
        name: '',
        description: '',
        categoryId: 0,
        clientId: 0,
      );


      await apiHandler.addCases(case_: case_);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Cases"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 76, 137, 175),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Color.fromARGB(255, 76, 137, 175),
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: addCases,
        child: const Text('Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'customerName',
                decoration: const InputDecoration(labelText: 'Description'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'categoryId',
                decoration: const InputDecoration(labelText: 'Category ID'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
               FormBuilderTextField(
                name: 'clientId',
                decoration: const InputDecoration(labelText: 'Client ID'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
