import 'package:calling_chat_app/config/colors/app_colors.dart';
import 'package:calling_chat_app/core/components/custom_button.dart';
import 'package:calling_chat_app/core/helpers/extension.dart';
import 'package:calling_chat_app/core/methods/get_responsive_text/responsive_text.dart';
import 'package:calling_chat_app/features/chat/ui/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/components/form_error.dart';
import '../../../../core/helpers/keyboard.dart';
import '../../../../core/helpers/regex.dart';
import '../../../../core/helpers/spacing.dart';
import 'custom_text_form_feild.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: "Enter your email",
            prefixIcon: IconlyBroken.message,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
          ),
          Spacing.verticalSpace(20),
          CustomTextFormField(
            hintText: "Enter your password",
            prefixIcon: IconlyBroken.lock,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            onSaved: (newValue) => password = newValue,
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 7) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
          ),
          Spacing.verticalSpace(16),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: AppColors.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(
                    width: .5,
                    color: AppColors.kBorderColor,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text(
                "Remember me",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: getResponsiveFontSize(context, fontSize: 14),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.kPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: getResponsiveFontSize(context, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          FormError(errors: errors),
          Spacing.verticalSpace(16),
          CustomButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                context.pushWithScale(const ChatScreen());
                KeyboardUtil.hideKeyboard(context);
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
            text: 'Continue',
          ),
        ],
      ),
    );
  }
}
