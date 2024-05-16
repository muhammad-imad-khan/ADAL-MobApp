import 'package:flutter/material.dart';
import 'package:adal/add_user.dart';
import 'package:provider/provider.dart';
import 'package:adal/api_handler.dart';
import 'package:adal/edit_page.dart';
import 'package:adal/find_user.dart';
import 'package:adal/model.dart';
import 'package:adal/Auth/LoginAuthProvider.dart';
import './Auth/AuthScreens/login.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _logout(BuildContext context) {
    Provider.of<LoginAuthProvider>(context, listen: false).logout(context);
  }

  ApiHandler apiHandler = ApiHandler();
  List<User> data = [];

  void getData() async {
    List<User> fetchedData = await apiHandler.getUserData();
    setState(() {
      data = fetchedData;
    });
  }

  void deleteUser(int userId) async {
    await apiHandler.deleteUser(id: userId);
    getData(); // Refresh data after deletion
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adal"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 54, 142, 236),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      bottomNavigationBar: MaterialButton(
        color: Color.fromARGB(255, 50, 147, 237),
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
            backgroundColor: Color.fromARGB(255, 45, 151, 232),
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const FindUser()),
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
            backgroundColor: Color.fromARGB(255, 36, 200, 255),
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUser(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(user: data[index]),
                    ),
                  );
                },
                leading: Text("${data[index].id}"),
                title: Text(data[index].name),
                subtitle: Text(data[index].description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    deleteUser(data[index].id);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
