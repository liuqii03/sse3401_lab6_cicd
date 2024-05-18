// flutter drive \ --driver=test_driver/integration_test_driver.dart \ --target=integration_test/app_test.dart

// ignore_for_file: unused_local_variable

import 'package:assignment/widgets/factory_list_button.dart';
import 'package:assignment/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignment/main.dart' as app;

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets(
      "full app test",
      (WidgetTester tester) async {
        const Duration testDuration = Duration(milliseconds: 3000);
        app.main();
        await tester.pumpAndSettle();

        //Activation Page
        final mobileNumberInputFinder = find.byType(TextField);
        final otpInputFinder = find.byType(TextField);
        final termsCheckboxFinder = find.byType(Checkbox);
        final getActivationCodeButtonFinder = find.text('Get Activation Code');
        final activateButtonFinder = find.text('Activate');

        // Initial state
        await tester.enterText(mobileNumberInputFinder, '147737087');
        await tester.tap(termsCheckboxFinder);
        await tester.tap(getActivationCodeButtonFinder);
        await tester.pumpAndSettle();

        // Next step state
        await tester.enterText(otpInputFinder, '123456');
        await tester.tap(activateButtonFinder);
        await tester.pumpAndSettle();

        //Home Page
        final factoryListButtonFinder = find.byType(FactoryListButton);

        await tester.tap(factoryListButtonFinder);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        //Engineer Page
        await tester.tap(find.byIcon(Icons.person));
        await tester.pumpAndSettle(const Duration(seconds: 2));
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(const Duration(seconds: 2));

        //Invitation Page
        final ownerNameTextFieldFinder = find.byType(TextField).first;
        final ownerPhoneTextFieldFinder = find.byType(TextField).last;
        final submitButtonFinder = find.byType(ThemeButton);

        await tester.tap(ownerNameTextFieldFinder);
        await tester.enterText(ownerNameTextFieldFinder, 'John');
        await tester.pumpAndSettle(const Duration(seconds: 2));

        await tester.tap(ownerPhoneTextFieldFinder);
        await tester.enterText(ownerPhoneTextFieldFinder, '123456789');
        await tester.pumpAndSettle(const Duration(seconds: 2));

        await tester.tap(submitButtonFinder);
        await tester.pumpAndSettle(const Duration(seconds: 2));
      },
    );
  });
}
