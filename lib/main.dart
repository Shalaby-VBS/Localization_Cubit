import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization_cubit/logic/cubit/localization_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localizations.dart';
import 'constants.dart';
import 'enums.dart';
import 'home_screen.dart';
import 'logic/cubit/localization_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LocalizationCubit()..appLanguageFunction(LanguagesTypesEnums.initial),
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          if (state is ChangeAppLanguage) {
            return MaterialApp(
              title: 'Localization Cubit',
              debugShowCheckedModeBanner: false,
              locale: Locale(state.languageCode!),
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null) {
                    if (deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                }
                return supportedLocales.first;
              },
              home: const HomeScreen(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
