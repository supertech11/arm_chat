import 'package:arm_chat/src/core/components/back_page_button.dart';
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
                body: BackPageButton(
                  key: Key("back"),
                ),
              );
            },
          );
        },
      );
    },
  );

  group(
    'BackPageButton Widget Test',
    () {
      testWidgets(
        "Validate the presence of back button",
        (WidgetTester tester) async {
          await tester.pumpWidget(widget);
          expect(find.byKey(const Key("back")), findsOneWidget);
          await tester.tap(find.byKey(const Key("back")));
        },
      );
    },
  );
}
