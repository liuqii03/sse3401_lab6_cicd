import 'package:assignment/data.dart';
import 'package:assignment/model/contact_model.dart';
import 'package:assignment/widgets/phone_text_field.dart';
import 'package:assignment/widgets/theme_button.dart';
import 'package:flutter/material.dart';

class InvitationPage extends StatefulWidget {
  final int selectedIndex;
  const InvitationPage({super.key, required this.selectedIndex});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  final TextEditingController _ownerNameTec = TextEditingController();
  final TextEditingController _ownerPhoneTec = TextEditingController();
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          factoryList[widget.selectedIndex].factoryName,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade400,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text(
              'Invitation',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 32,
              ),
            ),
            const Text('Invite users'),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                const Text(
                  'Owner\'s Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    checkFieldValidation();
                  },
                  controller: _ownerNameTec,
                  decoration: const InputDecoration(
                    hintText: 'Type here',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              runSpacing: 8,
              children: [
                const Text(
                  'Owner\'s Phone Number',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                PhoneTextField(
                  mobileNoTec: _ownerPhoneTec,
                  hintText: 'Enter your phone number',
                  onEditingComplete: () {
                    checkFieldValidation();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            ThemeButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  ContactModel(
                    name: _ownerNameTec.text,
                    phone: _ownerPhoneTec.text,
                  ),
                );
              },
              buttonText: 'Submit',
              isFullWidth: true,
              enable: isValid,
            ),
          ],
        ),
      ),
    );
  }

  void checkFieldValidation() {
    RegExp regex = RegExp('^[0-9]{9}|[0-9]{10}');
    bool isChecked = true;

    if (_ownerNameTec.text.isEmpty || _ownerPhoneTec.text.isEmpty) {
      isChecked = false;
    } else if (!regex.hasMatch(_ownerPhoneTec.text)) {
      isChecked = false;
    }

    setState(() {
      isValid = isChecked;
    });
  }
}
