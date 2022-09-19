import 'package:arm_chat/src/core/utils/field_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  group('Form Field Validators', () {
    test('show required if field is empty', () {
      expect(FieldValidator.validateFieldNotEmpty("", "required"), "required");
    });
    test('validate email entered is valid', () {
      expect(FieldValidator.validateEmail("agehgh", "Enter valid email"),
          "Enter valid email");
      expect(FieldValidator.validateEmail("agehgh@jhjhjh", "Enter valid email"),
          "Enter valid email");
      expect(FieldValidator.validateEmail("agehgh.gdgg@", "Enter valid email"),
          "Enter valid email");
      expect(FieldValidator.validateEmail("ade@gmail.com", "Enter valid email"),
          null);
    });

    test('validate password values are equal with confirm password', () {
      expect(
          FieldValidator.validateValueIsEqual(
              "Testing1@", "Testing1@", "Password not the same"),
          null);
      expect(
          FieldValidator.validateValueIsEqual(
              "Testing1@", "Testing1", "Password not the same"),
          "Password not the same");
    });

    test('validate password', () {
      expect(
          FieldValidator.validatePassword("Testing1@", "Valid password"), null);
      expect(
          FieldValidator.validatePassword(
              "Testing1", "Invalid password without character"),
          "Invalid password without character");
      expect(
          FieldValidator.validatePassword(
              "Testing@", "Invalid password without digit"),
          "Invalid password without digit");
      expect(
          FieldValidator.validatePassword(
              "Tin1@", "Invalid password less than 8 characters"),
          "Invalid password less than 8 characters");
    });
  });
}
