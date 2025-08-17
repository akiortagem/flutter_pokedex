import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_color_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class PKMNText {
  // Body and UI
  static const String bodyFont = 'Roboto';

  static final title = GoogleFonts.lato(
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );

  static final subtitle = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const bodyText1 = TextStyle(
    fontFamily: bodyFont,
    fontSize: 12,
  );

  static final subtitle1 = GoogleFonts.lato(fontSize: 14);
}

extension PKMNTextColor on TextStyle {
  TextStyle get textLight {
    return copyWith(color: PKMNColors.textLight);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.w900);
  }

  TextStyle get textSecondary {
    return copyWith(color: PKMNColors.textSecondary);
  }

  TextStyle get italic {
    return copyWith(fontStyle: FontStyle.italic);
  }

  TextStyle get small {
    return copyWith(fontSize: 10);
  }

  TextStyle get large {
    return copyWith(fontSize: 16);
  }

  TextStyle get larger {
    return copyWith(fontSize: 24);
  }

  TextStyle get largest {
    return copyWith(fontSize: 32);
  }
}
