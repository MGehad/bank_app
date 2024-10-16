import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/images.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/styles/texts_style.dart';
import '../../../../settings/data/models/settings_model.dart';
import '../../../data/models/language_model.dart';

class LanguageOption extends StatelessWidget {
  final LanguageModel languageModel;

  const LanguageOption({
    super.key,
    required this.languageModel,
    required this.settingsModel,
  });

  final SettingsModel settingsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      color: AppColors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.transparent,
                child: SvgPicture.asset(
                  languageModel.languageImage,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                languageModel.languageName,
                style: TextsStyle.textStyleMedium16,
              ),
              const Spacer(flex: 4),
              if (languageModel.languageName == settingsModel.language)
                SvgPicture.asset(
                  Images.imagesCheckIcon,
                ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
