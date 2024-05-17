import 'package:assignment/model/index_model.dart';

import 'contact_model.dart';

class FactoryModel {
  final String factoryName;
  final double totalPowerConsumption;
  final IndexModel readIndex;
  final IndexModel minIndex;
  final List<ContactModel> engineerList;

  FactoryModel({
    required this.factoryName,
    required this.totalPowerConsumption,
    required this.readIndex,
    required this.minIndex,
    required this.engineerList,
  });
}
