import 'package:calling_chat_app/config/colors/app_colors.dart';
import 'package:calling_chat_app/config/themes/font_weight.dart';
import 'package:flutter/material.dart';

import '../methods/get_responsive_text/responsive_text.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.kGreyColor,
            fontWeight: FontWeightHelper.regular,
            fontSize: getResponsiveFontSize(context, fontSize: 15),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Sign Up",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeightHelper.regular,
              fontSize: getResponsiveFontSize(context, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
