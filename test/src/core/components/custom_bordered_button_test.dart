import 'package:arm_chat/src/core/components/custom_bordered_button.dart';
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
                body: CustomBorderedButton(
                  key: Key("button"),
                  label: "press",
                  isLoading: true,
                ),
              );
            },
          );
        },
      );
    },
  );

  group(
    'CustomBorderedButton Widget Test',
    () {
      testWidgets(
        "Validate the presence of bordered button and loading state superceding the label when set",
        (WidgetTester tester) async {
          await tester.pumpWidget(widget);
          expect(find.byKey(const Key("button")), findsOneWidget);
          expect(find.text("press"), findsNothing);
          expect(find.byKey(const Key("loader")), findsOneWidget);
        },
      );
    },
  );
}
