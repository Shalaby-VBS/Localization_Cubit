abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class ChangeAppLanguage extends LocalizationState {
  final String ?languageCode;

  ChangeAppLanguage({this.languageCode});
}

