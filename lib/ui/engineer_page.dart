// ignore_for_file: unused_local_variable

import 'package:assignment/ui/invitation_page.dart';
import 'package:assignment/widgets/theme_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../data.dart';
import '../model/contact_model.dart';
import '../model/factory_model.dart';
import '../widgets/factory_list_button.dart';

class EngineerPage extends StatefulWidget {
  const EngineerPage({super.key});

  @override
  State<EngineerPage> createState() => _EngineerPageState();
}

class _EngineerPageState extends State<EngineerPage> {
  late FactoryModel selectedFactory;
  int selectedIndex = 0;

  _EngineerPageState() {
    selectedFactory = factoryList.first;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedFactory.factoryName,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings),
          )
        ],
      ),
      body: Container(
        color: Colors.grey.shade400,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.01,
                ),
                child: _buildEngineerList(),
              ),
            ),
            FactoryListButton(
              onSelected: (FactoryModel factory) {
                setState(() {
                  selectedFactory = factory;
                  selectedIndex = factoryList.indexOf(factory);
                });
              },
              selectedFactory: selectedFactory,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ThemeBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }

  Widget _buildEngineerList() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Card(
        color: Colors.grey.shade100,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.02,
          ),
          width: width,
          child: selectedFactory.engineerList.isEmpty
              ? const Center(
                  child: Text('No Engineer Added Yet'),
                )
              : ListView.separated(
                  itemCount: selectedFactory.engineerList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: Colors.white,
                      title: Text(
                        selectedFactory.engineerList[index].name,
                      ),
                      subtitle: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.grey,
                          ),
                          Text(
                            selectedFactory.engineerList[index].phone,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ContactModel newEngineer = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  InvitationPage(selectedIndex: selectedIndex),
            ),
          );

          setState(() {
            selectedFactory.engineerList.add(newEngineer);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
