import 'package:flutter/material.dart';
import '../../shared/styles/decoration.dart';
import '../helpers/api/cacheKeys.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale _appLocale = const Locale("en", "");
  SharedPreferencesService prefsService = SharedPreferencesService.instance;

  LanguageProvider() {
    loadLocale();
  }

  Future<void> loadLocale() async {
    String? languageCode = prefsService.getValue('language_code') as String?;
    String? countryCode = prefsService.getValue('country_code') as String?;
    if (languageCode != null && countryCode != null) {
      _appLocale = Locale(languageCode, countryCode);
    } else {
      _appLocale = WidgetsBinding.instance.platformDispatcher.locale;
    }
  }

  changeLanguage(Locale locale) async {
    await prefsService.setValue('language_code', locale.languageCode);
    await prefsService.setValue('country_code', locale.countryCode ?? "");
    _appLocale = locale;
    MyDecorations.myFont = (locale.languageCode == 'en') ? 'Saira' : 'Brando';
    notifyListeners();
  }

  Locale get appLocale => _appLocale;
}
