import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../data.dart';
import '../model/factory_model.dart';
import '../widgets/factory_list_button.dart';
import '../widgets/theme_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FactoryModel selectedFactory;

  @override
  void initState() {
    super.initState();

    selectedFactory = factoryList.first;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                child: SingleChildScrollView( // Wrap the column in SingleChildScrollView
                  child: Card(
                    color: Colors.grey.shade100,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          selectedFactory.totalPowerConsumption == 0
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/warning.png',
                                      width: 20,
                                    ),
                                    const Text(
                                      'ABD1234 IS UNREACHABLE!',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24,
                                      ),
                                    )
                                  ],
                                )
                              : Text(
                                  '${selectedFactory.totalPowerConsumption}kW',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                  ),
                                ),
                          Wrap(
                            spacing: width * 0.01,
                            runSpacing: height * 0.01,
                            children: [
                              _buildGaugeChart(
                                standardValue:
                                    selectedFactory.minIndex.steamPressure,
                                value: selectedFactory.readIndex.steamPressure,
                                title: 'Steam Pressure',
                                quantifier: 'bar',
                              ),
                              _buildGaugeChart(
                                standardValue: selectedFactory.minIndex.steamFlow,
                                value: selectedFactory.readIndex.steamFlow,
                                title: 'Steam Flow',
                                quantifier: 'T/H',
                              ),
                              _buildGaugeChart(
                                standardValue:
                                    selectedFactory.minIndex.waterLevel,
                                value: selectedFactory.readIndex.waterLevel,
                                title: 'Water Level',
                                quantifier: '%',
                              ),
                              _buildGaugeChart(
                                standardValue:
                                    selectedFactory.minIndex.powerFrequency,
                                value: selectedFactory.readIndex.powerFrequency,
                                title: 'Power Frequency',
                                quantifier: 'Hz',
                              ),
                            ],
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FactoryListButton(
              onSelected: (FactoryModel factory) {
                setState(() {
                  selectedFactory = factory;
                });
              },
              selectedFactory: selectedFactory,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ThemeBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }

  Widget _buildGaugeChart({
    required double standardValue,
    required double value,
    required String title,
    required String quantifier,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        width: width * 0.43,
        height: height * 0.27,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    canScaleToFit: true,
                    radiusFactor: 0.9,
                    axisLineStyle: AxisLineStyle(
                      color: Colors.grey.shade300,
                      thickness: 0.3,
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    showLabels: false,
                    startAngle: 180,
                    endAngle: 0,
                    pointers: <GaugePointer>[
                      RangePointer(
                        width: 0.3,
                        value: value,
                        color:
                            value < standardValue ? Colors.red : Colors.green,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      MarkerPointer(
                        value: standardValue,
                        color: Colors.grey.shade300,
                        enableDragging: false,
                        markerType: MarkerType.invertedTriangle,
                        markerOffset: -16,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Wrap(
              children: [
                Text(
                  '$value ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                Text(
                  quantifier,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

