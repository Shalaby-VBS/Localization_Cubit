import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_cubit/enums.dart';
import 'package:localization_cubit/logic/cubit/localization_state.dart';
import 'package:localization_cubit/shared_preferences_helper.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  void appLanguageFunction(LanguagesTypesEnums language) {
    switch (language) {
      case LanguagesTypesEnums.initial:
        if (SharedPreferencesHelper.getData('lang') != null) {
          if (SharedPreferencesHelper.getData('lang') == 'ar') {
            emit(ChangeAppLanguage(languageCode: 'ar'));
          } else {
            emit(ChangeAppLanguage(languageCode: 'en'));
          }
        }
        break;
      case LanguagesTypesEnums.arabic:
        SharedPreferencesHelper.setData('lang', 'ar');
        emit(ChangeAppLanguage(languageCode: 'ar'));
        break;
      case LanguagesTypesEnums.english:
        SharedPreferencesHelper.setData('lang', 'en');
        emit(ChangeAppLanguage(languageCode: 'en'));
        break;
      default:
        emit(ChangeAppLanguage(languageCode: 'en'));
    }
  }
}
