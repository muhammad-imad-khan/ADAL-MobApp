import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CaseModel.dart';
import 'Case_api_handler.dart';
import 'add_Case.dart';
import 'edit_Case.dart';
import 'find_Case.dart';
import '../Auth/LoginAuthProvider.dart';

class CasePage extends StatefulWidget {
  const CasePage({Key? key}) : super(key: key);

  @override
  State<CasePage> createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  ApiHandler apiHandler = ApiHandler();
  List<Cases> data = [];
  bool isGrid = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      List<Cases> fetchedData = await apiHandler.getCasesData();
      setState(() {
        data = fetchedData;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching Cases: $e')),
      );
    }
  }

  void deleteCase(int id) async {
    try {
      await apiHandler.deleteCases(id: id);
      getData(); // Refresh data after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting Case: $e')),
      );
    }
  }

  void addCase(Cases case_) async {
    try {
      await apiHandler.addCases(case_: case_);
      getData(); // Refresh data after adding
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding Case: $e')),
      );
    }
  }

  void editCase(Cases case_) async {
    try {
      await apiHandler.updateCases(id: case_.id, case_: case_);
      getData(); // Refresh data after editing
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating Case: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Case"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 76, 137, 175),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () =>
                Provider.of<LoginAuthProvider>(context, listen: false)
                    .logout(context),
          ),
        ],
      ),
      bottomNavigationBar: MaterialButton(
        color: Color.fromARGB(255, 76, 137, 175),
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: getData,
        child: const Text('Refresh'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            backgroundColor: Color.fromARGB(255, 76, 137, 175),
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const FindCases()),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 2,
            backgroundColor: Color.fromARGB(255, 76, 137, 175),
            foregroundColor: Colors.white,
            onPressed: () async {
              final newCase = await Navigator.push<Cases>(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCases(),
                ),
              );
              if (newCase != null) {
                addCase(newCase);
              }
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleButtons(
              isSelected: [isGrid, !isGrid],
              onPressed: (index) {
                setState(() {
                  isGrid = index == 0;
                });
              },
              children: const [
                Icon(Icons.grid_view),
                Icon(Icons.list),
              ],
            ),
          ),
          Expanded(
            child: isGrid ? buildGridView() : buildListView(),
          ),
        ],
      ),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return buildCaseCard(data[index]);
      },
    );
  }

  Widget buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return buildCaseCard(data[index]);
      },
    );
  }

  Widget buildCaseCard(Cases case_) {
    Color statusColor;
    switch (case_.categoryId) {
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Delivered':
        statusColor = Color.fromARGB(255, 76, 137, 175);
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
        break;
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  case_.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Chip(
                  backgroundColor: statusColor,
                  label: Text(
                    case_.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '\$${case_.clientId.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 76, 137, 175),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                 Text(
                  'Name: ${case_.name ?? ''}',
                ),
                Text(
                  'Description: ${case_.description}',
                ),
                Text(
                  'Code: ${case_.id}',
                ),
               
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () async {
                  final editedCase = await Navigator.push<Cases>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditCases(case_: case_),
                    ),
                  );
                  if (editedCase != null) {
                    editCase(editedCase);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  deleteCase(case_.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
