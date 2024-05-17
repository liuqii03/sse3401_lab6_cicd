import 'package:assignment/model/contact_model.dart';
import 'package:assignment/model/index_model.dart';
import 'model/factory_model.dart';

List<FactoryModel> factoryList = [
  FactoryModel(
      factoryName: 'Factory 1',
      totalPowerConsumption: 1549.7,
      readIndex: IndexModel(
        steamPressure: 34.19,
        steamFlow: 22.82,
        waterLevel: 55.41,
        powerFrequency: 50.08,
      ),
      minIndex: IndexModel(
        steamPressure: 29,
        steamFlow: 22,
        waterLevel: 53,
        powerFrequency: 48,
      ),
      engineerList: [
        ContactModel(
          name: 'Ben',
          phone: '+60109219938',
        ),
        ContactModel(
          name: 'Testing 1',
          phone: '+601234567891',
        ),
        ContactModel(
          name: 'Hello',
          phone: '+60123456789',
        )
      ]),
  FactoryModel(
    factoryName: 'Factory 2',
    totalPowerConsumption: 0,
    readIndex: IndexModel(
      steamPressure: 0,
      steamFlow: 0,
      waterLevel: 0,
      powerFrequency: 0,
    ),
    minIndex: IndexModel(
      steamPressure: 29,
      steamFlow: 22,
      waterLevel: 53,
      powerFrequency: 48,
    ),
    engineerList: [],
  ),
  FactoryModel(
    factoryName: 'Factory 3',
    totalPowerConsumption: 0,
    readIndex: IndexModel(
      steamPressure: 0,
      steamFlow: 0,
      waterLevel: 0,
      powerFrequency: 0,
    ),
    minIndex: IndexModel(
      steamPressure: 29,
      steamFlow: 22,
      waterLevel: 53,
      powerFrequency: 48,
    ),
    engineerList: [],
  ),
];
