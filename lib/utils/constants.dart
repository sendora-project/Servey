import 'package:intl/intl.dart';

import 'toolbox.dart';

class Constants {
  static DateFormat kHourFormat = DateFormat('h:mm a', 'en-US');
  static DateFormat kCompactDate = DateFormat('MM-dd-yyyy', 'en-US');
  static DateFormat kFullCompactDate = DateFormat(
    'MM-dd-yyyy \'at\' h:mm a',
    'en-US',
  );

  static DateFormat kDate = DateFormat('EEEE, d MMMM', 'en-US');

  static DateFormat kMoDays = DateFormat('MMMM d', 'en-US');

  static DateFormat kFullDate = DateFormat(
    'EEEE, d MMMM \'at\' h:mm a',
    'en-US',
  );

  static List<String> kPasswordDisclaimer = [
    'Your password must meet the following criterias:\n',
    '${Toolbox.kBullet} At least one digit.',
    '${Toolbox.kBullet} At least one lowercase and uppercase letter.',
    '${Toolbox.kBullet} At least one special character [@#\$%^&+=!].',
    '${Toolbox.kBullet} At least 8 characters long.',
    '${Toolbox.kBullet} No whitespaces.',
  ];

  static String kMapsUrl = 'https://www.google.com/maps/search';
}
