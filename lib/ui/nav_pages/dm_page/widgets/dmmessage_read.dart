import 'package:flutter/material.dart';
import 'package:zurichat/constants/app_strings.dart';
import 'package:zurichat/ui/shared/text_styles.dart';

class DMMessageRead extends StatelessWidget {
  const DMMessageRead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: const Color(0xff1A61DB),
              image: const DecorationImage(
                image: NetworkImage(
                  DmReadAvatar,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pappin 4️⃣',
                style: AppTextStyle.darkGreySize16Bold,
              ),
              const SizedBox(height: 5),
              Text(
                'Can i have your number?',
                style: AppTextStyle.lightGreySize14,
                // style: AppTextStyles.normalText,
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '1d',
                // style: AppTextStyles.timestamp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
