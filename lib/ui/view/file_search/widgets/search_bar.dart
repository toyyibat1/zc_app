import 'package:flutter/material.dart';
import 'package:zurichat/constants/app_strings.dart';
import 'package:zurichat/ui/shared/text_styles.dart';

import '../../../shared/shared.dart';

// search bar
final Image closeIcon = Image.asset(CloseSearch);
final Image voiceSearch = Image.asset(VoiceSearch);

class CustomSearchBar extends StatelessWidget {
  final String? searchFilter;
  const CustomSearchBar({
    Key? key,
    this.searchFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.paleGreen,
              borderRadius: BorderRadius.circular(8)),
          child: Positioned(
            top: 0,
            bottom: 0,
            child: ListTile(
                leading: closeIcon,
                title: TextField(
                  decoration: InputDecoration(
                    hintText: Designers,
                    hintStyle: AppTextStyle.darkGreySize12,
                  ),
                ),
                trailing: voiceSearch),
          ),
        ),
      ],
    );
  }
}
