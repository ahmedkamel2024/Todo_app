import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../provider/app_language_provider.dart';
import '../../provider/app_mode_provider.dart';
import 'language_bottom_sheet.dart';
import 'mode_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppLanguageProvider>(context);
    var modeProvider = Provider.of<AppModeProvider>(context);
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              ShowLanguageBottomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: modeProvider.isDarkMode()
                      ? AppColors.blackDarkColor
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 35,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              ShowModeBottomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: modeProvider.isDarkMode()
                      ? AppColors.blackDarkColor
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(modeProvider.isDarkMode()
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 35,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ShowLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void ShowModeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ModeBottomSheet());
  }
}
