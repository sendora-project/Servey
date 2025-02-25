import 'package:flutter/material.dart';

import 'theme.dart';

class StyleUtils {
  static TextStyle customLightStyle(
    double size, {
    String family = 'Quicksand',
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle customDarkStyle(
    double size, {
    String family = 'Quicksand',
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
  }

  static TextStyle customFadeDarkStyle(
    double size, {
    String family = 'Quicksand',
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    );
  }

  static TextStyle customFadeLightDarkStyle(
    double size, {
    String family = 'Quicksand',
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.white54,
    );
  }

  static const TextStyle smallLightStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle mediumLightStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle regularLightStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle highLightStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle bigLightStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 19,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle smallDarkStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static const TextStyle mediumDarkStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static const TextStyle regularDarkStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static const TextStyle highDarktStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static const TextStyle bigDarkStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 19,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle smallFadeDarkStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );
  static const TextStyle mediumFadeDarkStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );
  static const TextStyle regularFadeDarkStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );
  static const TextStyle highFadeDarktStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );
  static const TextStyle bigFadeDarkStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 19,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  static const TextStyle smallFadeLightStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: Colors.white54,
  );
  static const TextStyle mediumFadeLightStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: Colors.white54,
  );
  static const TextStyle regularFadeLightStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white54,
  );
  static const TextStyle highFadeLightStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.white54,
  );

  static const TextStyle errorStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: ThemeUtils.kWarning,
  );
  static const TextStyle regularErrorStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: ThemeUtils.kWarning,
  );
  static const TextStyle highErrorStyle = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: ThemeUtils.kWarning,
  );
}
