import 'package:assignment/widgets/theme_bottom_navigation_bar.dart';
import 'package:assignment/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import '../data.dart';
import '../model/factory_model.dart';
import '../widgets/factory_list_button.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _steamPressureController =
      TextEditingController();
  final TextEditingController _steamFlowController = TextEditingController();
  final TextEditingController _waterLevelController = TextEditingController();
  final TextEditingController _powerFrequencyController =
      TextEditingController();

  late FactoryModel selectedFactory;
  int selectedIndex = 0;
  bool isEditable = false;

  @override
  void initState() {
    super.initState();

    selectedFactory = factoryList.first;
    setMinimumThreshold();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: _buildMinimumThresholdForm(),
              ),
            ),
            FactoryListButton(
              onSelected: (FactoryModel factory) {
                setState(() {
                  selectedFactory = factory;
                  selectedIndex = factoryList.indexOf(factory);
                });
                setMinimumThreshold();
              },
              selectedFactory: selectedFactory,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ThemeBottomNavigationBar(
        currentIndex: 2,
      ),
    );
  }

  Widget _buildMinimumThresholdForm() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      color: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.02,
        ),
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 6,
                  child: Text(
                    'Minimum Threshold',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Expanded(
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ThemeButton(
                    onPressed: () {
                      if (isEditable) {
                        setState(() {
                          selectedFactory.minIndex.steamPressure =
                              double.parse(_steamPressureController.text);
                          selectedFactory.minIndex.steamFlow =
                              double.parse(_steamFlowController.text);
                          selectedFactory.minIndex.waterLevel =
                              double.parse(_waterLevelController.text);
                          selectedFactory.minIndex.powerFrequency =
                              double.parse(_powerFrequencyController.text);
                        });
                      }

                      setState(() {
                        isEditable = !isEditable;
                      });
                    },
                    icon: Icon(
                      isEditable ? Icons.done : Icons.edit,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Wrap(
              runSpacing: height * 0.05,
              children: [
                _buildIndexTextField(
                  title: 'Steam Pressure',
                  controller: _steamPressureController,
                  unit: 'bar',
                ),
                _buildIndexTextField(
                  title: 'Steam Flow',
                  controller: _steamFlowController,
                  unit: 'T/H',
                ),
                _buildIndexTextField(
                  title: 'Water Level',
                  controller: _waterLevelController,
                  unit: '%',
                ),
                _buildIndexTextField(
                  title: 'Power Frequency',
                  controller: _powerFrequencyController,
                  unit: 'Hz',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIndexTextField({
    required String title,
    required TextEditingController controller,
    required String unit,
  }) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.43,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            width: width * 0.25,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.21,
                height: height * 0.07,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(8),
                  ),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    enabled: isEditable,
                    controller: controller,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              Container(
                height: height * 0.07,
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(8),
                  ),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Center(
                  child: Text(
                    unit,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  setMinimumThreshold() {
    setState(() {
      _steamPressureController.text =
          selectedFactory.minIndex.steamPressure.toStringAsFixed(0);
      _steamFlowController.text =
          selectedFactory.minIndex.steamFlow.toStringAsFixed(0);
      _waterLevelController.text =
          selectedFactory.minIndex.waterLevel.toStringAsFixed(0);
      _powerFrequencyController.text =
          selectedFactory.minIndex.powerFrequency.toStringAsFixed(0);
    });
  }
}
