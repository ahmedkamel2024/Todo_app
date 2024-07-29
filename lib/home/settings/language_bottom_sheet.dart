import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../provider/app_language_provider.dart';
import '../../provider/app_mode_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppLanguageProvider>(context);
    var modeProvider = Provider.of<AppModeProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                provider.changeLanguage('en');
              },
              child: provider.appLanguage == 'en'
                  ? getSelectItemWidget(AppLocalizations.of(context)!.english)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.english)),
          SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                provider.changeLanguage('ar');
              },
              child: provider.appLanguage == 'ar'
                  ? getSelectItemWidget(AppLocalizations.of(context)!.arabic)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.arabic))
        ],
      ),
    );
  }

  Widget getSelectItemWidget(String text) {
    var modeProvider = Provider.of<AppModeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: modeProvider.isDarkMode()
                    ? AppColors.whiteColor
                    : AppColors.primaryColor,
              ),
        ),
        Icon(
          Icons.check,
          size: 30,
          color: modeProvider.isDarkMode()
              ? AppColors.whiteColor
              : AppColors.primaryColor,
        )
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    var modeProvider = Provider.of<AppModeProvider>(context);
    return Text(text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: modeProvider.isDarkMode()
                  ? AppColors.whiteColor
                  : AppColors.primaryColor,
            ));
  }
}
