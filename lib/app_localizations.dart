import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  Locale? locale;
  AppLocalizations(this.locale);

  // MARK: - Static member to have a simple access to the delegate from the MaterialApp.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  late Map<String, String> jsonStrings;

  // MARK: - Load the json file from the lang folder.
  Future loadLang() async {
    // MARK: - Load the json file from the lang folder.
    String langFilePath = await rootBundle.loadString('assets/translations/${locale!.languageCode}.json');
    Map<String, dynamic> decodedJson = json.decode(langFilePath);
    jsonStrings = decodedJson.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  // MARK: - Translate the key to the value in the json file.
  String translate(String key) {
    return jsonStrings[key] ?? 'No translation found for $key';
  }
}


// MARK: - LocalizationsDelegate is a factory for a set of localized resources.
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  // MARK: - Supported languages.
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  // MARK: - Called when a user changes the app's locale.
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.loadLang();
    return appLocalizations;
  }

  // MARK: - Called when a Localizations widget is rebuilt.
  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
