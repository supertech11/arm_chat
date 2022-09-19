import 'package:arm_chat/src/core/components/custom_text.dart';
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
                body: CustomText(
                  text: "sample_text",
                ),
              );
            },
          );
        },
      );
    },
  );

  group(
    'CustomText Widget Test',
    () {
      testWidgets(
        "Validate the presence of the text in the component",
        (WidgetTester tester) async {
          await tester.pumpWidget(widget);
          expect(find.text("sample_text"), findsOneWidget);
        },
      );
    },
  );
}
