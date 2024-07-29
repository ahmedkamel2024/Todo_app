import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../provider/app_mode_provider.dart';

class ModeBottomSheet extends StatefulWidget {
  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppModeProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                provider.changeMode(ThemeMode.light);
              },
              child: provider.appMode == ThemeMode.light
                  ? getSelectItemWidget(AppLocalizations.of(context)!.light)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.light)),
          SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                provider.changeMode(ThemeMode.dark);
              },
              child: provider.isDarkMode()
                  ? getSelectItemWidget(AppLocalizations.of(context)!.dark)
                  : getUnSelectedItemWidget(AppLocalizations.of(context)!.dark))
        ],
      ),
    );
  }

  Widget getSelectItemWidget(String text) {
    var modeProvider = Provider.of<AppModeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: modeProvider.isDarkMode()
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                )),
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
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: modeProvider.isDarkMode()
              ? AppColors.whiteColor
              : AppColors.primaryColor),
    );
  }
}
