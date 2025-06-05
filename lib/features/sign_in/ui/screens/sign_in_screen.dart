import 'package:calling_chat_app/config/themes/font_weight.dart';
import 'package:calling_chat_app/core/helpers/spacing.dart';
import 'package:calling_chat_app/core/methods/get_responsive_text/responsive_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/no_account_text.dart';
import '../../../../core/components/socal_card.dart';
import '../../../../core/constant/app_constant.dart';
import '../components/sign_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
          child: SingleChildScrollView(
            child: SizedBox(
              height: AppConstant.deviceHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: getResponsiveFontSize(context, fontSize: 30),
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                  ),
                  Spacing.verticalSpace(8),
                  Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: getResponsiveFontSize(context, fontSize: 15),
                      fontWeight: FontWeightHelper.regular,
                      color: Colors.black54,
                    ),
                  ),
                  Spacing.verticalSpace(16),
                  const SignForm(),
                  Spacing.verticalSpace(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(icon: "assets/icons/twitter.svg", press: () {}),
                    ],
                  ),
                  Spacing.verticalSpace(16),
                  const NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
