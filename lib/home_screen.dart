import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_cubit/app_localizations.dart';
import 'package:localization_cubit/shared_preferences_helper.dart';

import 'enums.dart';
import 'logic/cubit/localization_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context).translate('homeScreen'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ElevatedButton(
            onPressed: () {
              SharedPreferencesHelper.setData('lang', 'en');
              BlocProvider.of<LocalizationCubit>(context)
                  .appLanguageFunction(LanguagesTypesEnums.english);
            },
            child: const Text('English'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              SharedPreferencesHelper.setData('lang', 'ar');
              BlocProvider.of<LocalizationCubit>(context)
                  .appLanguageFunction(LanguagesTypesEnums.arabic);
            },
            child: const Text('Arabic'),
          ),
        ],
      )),
    );
  }
}
