import 'package:arm_chat/src/core/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

void main() {
  late Widget widget;
  const scaffoldKey = Key("scaffold");
  setUp(
    () {
      widget = GetMaterialApp(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return const Scaffold(
                key: scaffoldKey,
                body: CustomTextFormField(
                  key: Key(
                    "textform",
                  ),
                  labelText: "firstname",
                ),
              );
            },
          );
        },
      );
    },
  );

  group(
    'CustomTextFormField Widget Test',
    () {
      testWidgets(
        "Validate the presence of textform button and visibility of label when set",
        (WidgetTester tester) async {
          await tester.pumpWidget(widget);
          expect(find.byKey(const Key("textform")), findsOneWidget);
          expect(find.text("firstname"), findsOneWidget);
        },
      );
    },
  );
}
