import 'package:flutter/material.dart';
import '../data.dart';
import '../model/factory_model.dart';

class FactoryListButton extends StatefulWidget {
  final Function(FactoryModel) onSelected;
  final FactoryModel selectedFactory;
  const FactoryListButton({
    super.key,
    required this.onSelected,
    required this.selectedFactory,
  });

  @override
  State<FactoryListButton> createState() => _FactoryListButtonState();
}

class _FactoryListButtonState extends State<FactoryListButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.01,
        ),
        height: 150, // Set a fixed height or a relative height
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          scrollDirection: Axis.horizontal,
          itemCount: factoryList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                widget.onSelected(factoryList[index]);
              },
              child: Card(
                elevation: 5,
                shadowColor: widget.selectedFactory == factoryList[index]
                    ? Colors.blue
                    : Colors.grey,
                color: Colors.grey.shade50,
                child: SizedBox(
                  width: width * 0.46,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.factory,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(factoryList[index].factoryName),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
