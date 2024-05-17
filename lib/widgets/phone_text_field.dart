import 'package:flutter/material.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController mobileNoTec;
  final String hintText;
  final Function()? onEditingComplete;

  const PhoneTextField({
    super.key,
    required this.mobileNoTec,
    this.hintText = '',
    this.onEditingComplete,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              children: [
                Image.asset(
                  'assets/images/malaysia_flag.png',
                  width: width * 0.07,
                ),
                const Text('+60'),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: TextField(
              onChanged: (value) {
                if (widget.onEditingComplete != null) {
                  widget.onEditingComplete!();
                }
              },
              controller: widget.mobileNoTec,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                hintText: widget.hintText,
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }
}
