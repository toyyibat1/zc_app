import 'package:flutter/material.dart';
import 'package:zurichat/constants/app_strings.dart';
import 'package:zurichat/ui/shared/text_styles.dart';
import 'package:stacked_services/stacked_services.dart';

import '../colors.dart';

class SelectThemeDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const SelectThemeDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? _currentThemeValue = request.data['currentThemeValue'];

    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  DarkMode,
                  style: Theme.of(context).brightness == Brightness.dark
                      ? AppTextStyle.whiteSize16Bold
                      : AppTextStyle.darkGreySize16Bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: request.data['themes'].length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  request.data['themes'][index],
                ),
                leading: Radio(
                  activeColor: AppColors.zuriPrimaryColor,
                  value: index,
                  groupValue: _currentThemeValue,
                  onChanged: (int? value) {
                    setState(() => _currentThemeValue = value);
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () => completer(
                    DialogResponse(confirmed: false),
                  ),
                  child: const Text(Cancel),
                ),
                MaterialButton(
                  onPressed: () => completer(
                    DialogResponse(data: _currentThemeValue, confirmed: true),
                  ),
                  child: const Text(Apply),
                ),
                const SizedBox(height: 30),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
