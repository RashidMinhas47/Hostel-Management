import 'package:hostel_management/common/widgets/buttons/t_large_button.dart';
import 'package:hostel_management/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/text/t_small_title.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

import '../../../controllers/login_ctr.dart';


class TLoginForm extends StatefulWidget {
  const TLoginForm({
    super.key,
  });

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    const Widget itemSpace = SizedBox(height: TSizes.spaceBtwItems);
    const Widget sectionSpace = SizedBox(height: TSizes.spaceBtwSections);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              validator: (value)=>TFormValidator.validateEmail(value),
              controller: loginController.emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            ///Password
            Obx(
               () =>
                 TextFormField(
                  obscureText: loginController.isChecked.value,
                  validator: (value)=>TFormValidator.validatePassword(value),
                  controller: loginController.passwordController,
                  decoration:  InputDecoration(
                    prefixIcon: Icon(Iconsax.password_check),
                    labelText: TTexts.password,
                    suffixIcon: IconButton(onPressed: loginController.isToggle,icon: Icon(loginController.isChecked.value ? Iconsax.eye: Iconsax.eye_slash)),
                  ),
                )

            ),

            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            ///Remember me and forgot password

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remeber me

                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {},activeColor: TColors.action,),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                ///Foget password
                TextButton(
                    onPressed: () =>Get.to(()=> const ForgetPassword()),
                    child: TTitleSmall(label: TTexts.forgetPassword,color: TColors.actionDark,))
              ],
            ),
            sectionSpace,
            ///SignIn Button
            Obx(()=> loginController.isLoading.value
                ? const CircularProgressIndicator() :  TLargeButton(label: "Login", onPressed: (){
              if (_formKey.currentState!.validate()) {
                loginController.loginUser();
              }
            }),
            ),
            itemSpace,
            ///Create Account Button
           TLargeButton(label: "Create Account", onPressed: ()=> Get.back())
          ],
        ),
      ),
    );
  }
}


