import 'package:assignment/ui/home_page.dart';
import 'package:assignment/widgets/phone_text_field.dart';
import 'package:flutter/material.dart';
import '../widgets/theme_button.dart';

class AccountActivationPage extends StatefulWidget {
  const AccountActivationPage({super.key});

  @override
  State<AccountActivationPage> createState() => _AccountActivationPageState();
}

class _AccountActivationPageState extends State<AccountActivationPage> {
  final TextEditingController _mobileNoTec = TextEditingController();
  final TextEditingController _otpTec = TextEditingController();
  bool isCheckedTC = false;
  bool isNextStep = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xfffffcfc),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/upm_icon.jpeg',
                  width: width * (width > 1000 ? 0.2 : 0.5),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Text(
                  'Welcome !',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 36,
                  ),
                ),
                Card(
                  color: isNextStep ? Colors.white : const Color(0xffffdcdc),
                  child: Container(
                    height: height * 0.44,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 36,
                      ),
                      child: isNextStep
                          ? _buildOtpSubmit(width)
                          : _buildGetActivationCode(width),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: SizedBox(
                    width: width,
                    child: const Column(
                      children: [
                        Text(
                          'Disclaimer | Privacy Statement',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Copyright UPM & Kejuruteraan Minyak Sawit CCS Sdn Bhd',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGetActivationCode(double width) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Enter your mobile number to activate your account.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Icon(Icons.info_outline),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 48,
              bottom: 16,
            ),
            child: PhoneTextField(mobileNoTec: _mobileNoTec),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isCheckedTC,
                onChanged: (value) {
                  setState(() {
                    isCheckedTC = !isCheckedTC;
                  });
                },
                fillColor: MaterialStateProperty.all(Colors.blue),
              ),
              const Text('I agree to the terms & conditions')
            ],
          ),
          ThemeButton(
            onPressed: () {
              if (!isCheckedTC) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('You haven\'t agree terms & consitions'),
                  ),
                );
              } else if (_mobileNoTec.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Phone is empty'),
                  ),
                );
              } else {
                String phoneInput = _mobileNoTec.text;
                RegExp regex = RegExp('^[0-9]{9}|[0-9]{10}');
                if (!regex.hasMatch(phoneInput)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Phone format is invalid'),
                    ),
                  );
                } else {
                  setState(() {
                    isNextStep = true;
                  });
                }
              }
            },
            buttonText: 'Get Activation Code',
          ),
        ],
      );

  Widget _buildOtpSubmit(double width) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Enter the activation code you received via SMS.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Icon(Icons.info_outline),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _otpTec,
              textAlign: TextAlign.center,
              maxLength: 6,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'OTP',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.grey)),
              ),
            ),
          ),
          Column(
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: 'Didn\'t receive? '),
                    TextSpan(
                      text: 'Tap here',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              ThemeButton(
                onPressed: () {
                  if (_otpTec.text.isEmpty || _otpTec.text.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('OTP is not matched'),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                },
                buttonText: 'Activate',
              ),
            ],
          )
        ],
      );
}
