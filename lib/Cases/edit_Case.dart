import 'package:Adal/Cases/CaseModel.dart';
import 'package:Adal/Cases/Case_api_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditCases extends StatefulWidget {
  final Cases case_;
  const EditCases({Key? key, required this.case_}) : super(key: key);

  @override
  State<EditCases> createState() => _EditCasesState();
}

class _EditCasesState extends State<EditCases> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();
  late http.Response response;

  void updateData() async {
    try {
      if (_formKey.currentState!.saveAndValidate()) {
        final data = _formKey.currentState!.value;

        final updatedCases = Cases(
         id: 0,
        name: '',
        clientName: '',
        description: '',
        comment: '',
        status: '',
        offer: 0,
        categoryId: 0,
        clientId: 0,
        );

        response = await apiHandler.updateCases(id: widget.case_.id, case_: updatedCases);

        if (response.statusCode == 200) {
          Navigator.pop(context, true); // Pass true to indicate success
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update case_. Status code: ${response.statusCode}'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating case_: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Cases"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 76, 137, 175),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: updateData,
        child: const Text('Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          initialValue: {
            'id': widget.case_.id,
            'name': null,
            'description': null,
            'categoryId': 0,
            'clientId': 0,
          },
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'productId',
                decoration: const InputDecoration(labelText: 'Case ID'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              // Add more form fields for other properties as needed
              // Example:
              // FormBuilderTextField(
              //   name: 'customerId',
              //   decoration: const InputDecoration(labelText: 'Customer ID'),
              //   keyboardType: TextInputType.number,
              //   validator: FormBuilderValidators.compose([
              //     FormBuilderValidators.required(),
              //     FormBuilderValidators.numeric(),
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
