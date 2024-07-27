import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../CaseModel.dart';
import '../Case_api_handler.dart';
import '../../Auth/LoginAuthProvider.dart';

class ClientCasePage extends StatefulWidget {
  const ClientCasePage({Key? key}) : super(key: key);

  @override
  State<ClientCasePage> createState() => _ClientCasePageState();
}

class _ClientCasePageState extends State<ClientCasePage> {
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
      List<Cases> fetchedData = await apiHandler.getClientCasesData();
      setState(() {
        data = fetchedData;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching Cases: $e')),
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
        ],
      ),
    );
  }
}
