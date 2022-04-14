import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

ThemeData getThemeOf(final BuildContext context) => Theme.of(context);

AppLocalizations getAppLocalizationsOf(final BuildContext context) {
  final found = AppLocalizations.of(context);
  if (found == null) {
    throw Exception("Trying to get AppLocalizations "
        "but is not initialized in current context.");
  }
  return found;
}

class AppColors {
  //note: remember after "0xFF" FF digits are alpha.
  static const primaryColor = Color(0xFFc85100);
  static const backGroundColor = Color(0xFF121212);
  static const surfaceColor = Color(0xFF262626);
  static const accentColor = Color(0xFFCF6679);
  static const textPrimaryColor = Color(0xFFFFFFFF);
}

///Ingenio barber theme
final darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.backGroundColor,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryColor,
    secondary: AppColors.accentColor,
    surface: AppColors.surfaceColor,
    background: Colors.white,
  ),
);
