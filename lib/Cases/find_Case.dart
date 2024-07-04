import 'package:flutter/material.dart';
import 'Case_api_handler.dart';
import 'package:Adal/Cases/CaseModel.dart';
import 'CaseModel.dart';

class FindCases extends StatefulWidget {
  const FindCases({super.key});

  @override
  State<FindCases> createState() => _FindCasesState();
}

class _FindCasesState extends State<FindCases> {
  ApiHandler apiHandler = ApiHandler();
  Cases? case_;
  TextEditingController textEditingController = TextEditingController();
  String errorMessage = '';

  void findCases(int caseId) async {
    try {
      Cases fetchedCases = await apiHandler.getCasesById(id: caseId);
      setState(() {
        case_ = fetchedCases;
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        case_ = null;
        errorMessage = 'Cases not found or error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Cases"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Color.fromARGB(255, 76, 137, 175),
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: () {
          int caseId = int.tryParse(textEditingController.text) ?? -1;
          if (caseId > 0) {
            findCases(caseId);
          } else {
            setState(() {
              errorMessage = 'Please enter a valid case_ ID';
              case_ = null;
            });
          }
        },
        child: const Text('Find'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                labelText: 'Enter Cases ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            if (case_ != null)
              ListTile(
                leading: Text("${case_!.id}"),
                title: Text(case_!.description),
                subtitle: Text(case_!.clientId.toString()),
              ),
          ],
        ),
      ),
    );
  }
}
