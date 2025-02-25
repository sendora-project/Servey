class ValidationType {
  final RegExp regex;
  final String message;

  const ValidationType._(this.regex, this.message);

  String? match(String value) {
    return regex.hasMatch(value) ? null : message;
  }
}

class GeneralValidation extends ValidationType {
  static final kCode = GeneralValidation._(
    RegExp(r'\d{6,}'),
    'Incorrect code',
  );

  static final kEmail = GeneralValidation._(
    RegExp(r'^[a-zA-Z\d._%-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$'),
    'Incorrect email',
  );

  static final kPassword = GeneralValidation._(
    RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&=!])(?=\S+$).{8,}$'),
    'Incorrect password',
  );

  static final kPhone = GeneralValidation._(
    RegExp(r'^((\+|0)3{2}|0)[67-9](\d{8})$'),
    'Incorrect phone',
  );

  static final kUuid = GeneralValidation._(
    RegExp(
        r'^[\da-fA-F]{8}-[\da-fA-F]{4}-[\da-fA-F]{4}-[\da-fA-F]{4}-[\da-fA-F]{12}$'),
    'Incorrect id',
  );

  static final kDefault = GeneralValidation._(
    RegExp(r'.{3,}'),
    'Incorrect content',
  );

  static final kNonEmpty = GeneralValidation._(
    RegExp(r'.{1,}'),
    'Content must not be empty.',
  );

  GeneralValidation._(super.regex, super.message) : super._();
}

class CardValidation extends ValidationType {
  static final kMastercard = CardValidation._(
    RegExp(r'^5[1-5][0-9]{14}$'),
    'Incorrect mastercard number',
  );

  static final kVisa = CardValidation._(
    RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$'),
    'Incorrect visa number',
  );

  static final kAmex = CardValidation._(
    RegExp(r'^3[47][0-9]{13}$'),
    'Incorrect amex number',
  );

  static final kCcv = CardValidation._(
    RegExp(r'^\d{3,4}$'),
    'Incorrect ccv number',
  );

  static final kExpiration = CardValidation._(
    RegExp(r'^(0[1-9]|1[0-2])/\d{4}$'),
    'Incorrect expiration',
  );

  CardValidation._(super.regex, super.message) : super._();

  @override
  String? match(String value) {
    return regex.hasMatch(value.trim().replaceAll(' ', '')) ? null : message;
  }
}
