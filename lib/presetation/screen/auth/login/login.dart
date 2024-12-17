import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoo_app/core/utils/app_styles.dart';
import 'package:todoo_app/core/utils/assets_mananger.dart';
import 'package:todoo_app/core/utils/colors_manager.dart';
import 'package:todoo_app/core/utils/constant_manager.dart';
import 'package:todoo_app/core/utils/dialog_utils/dialog_utils.dart';
import 'package:todoo_app/core/utils/email_validation.dart';
import 'package:todoo_app/core/utils/routes_manager.dart';
import 'package:todoo_app/datebase_manager/model/user_dm.dart';
import 'package:todoo_app/presetation/screen/auth/widgets/custom_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailNameController;

  late TextEditingController passwordNameController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailNameController = TextEditingController();
    passwordNameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailNameController.dispose();
    passwordNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: REdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              key: formKey,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  AssetsManager.routeImage,
                  width: 237.w,
                  height: 71.h,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text('E-mail address', style: AppLightStyles.title),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: 'enter your email address',
                  keyBoardType: TextInputType.emailAddress,
                  controller: emailNameController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz, enter your email address';
                    }
                    if (!isValidEmail(input)) {
                      return 'Email bad format';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text('Password', style: AppLightStyles.title),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: 'enter your Password',
                  keyBoardType: TextInputType.visiblePassword,
                  controller: passwordNameController,
                  isSecure: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz, enter your Password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                MaterialButton(
                  padding: REdgeInsets.symmetric(vertical: 11),
                  color: ColorsManager.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  onPressed: () {
                    signIn();
                  },
                  child: Text(
                    'Sign-In',
                    style: AppLightStyles.buttonTitle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: AppLightStyles.title?.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.register);
                      },
                      child: Text('Create account',
                          style: AppLightStyles.title?.copyWith(
                              fontSize: 14,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (formKey.currentState?.validate() == false) return;

    try {
      DialogUtils.showLoading(context, message: 'Wait...');
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailNameController.text,
        password: passwordNameController.text,
      );
      UserDm.currentUser = await readUseFireStore(credential.user!.uid);

      if (mounted) {
        DialogUtils.hide(context);
      }

      DialogUtils.showMessage(
        context,
        body: 'User logged in successfully',
        posActionTitle: 'Ok',
        posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.home);
        },
      );
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hide(context);
      late String message;
      if (authError.code == ConstantManager.invalidCredentialCode) {
        message = 'Wrong email password';
      }
      DialogUtils.showMessage(context, body: message, posActionTitle: 'Ok');
    } catch (error) {
      DialogUtils.hide(context);
      DialogUtils.showMessage(context, body: error.toString());
    }
  }

  Future<UserDm> readUseFireStore(String uid) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(UserDm.collectionName);
    DocumentReference userDoc = userCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDoc.get();
    Map<String, dynamic> json = userDocSnapshot.data() as Map<String, dynamic>;
    UserDm userDm = UserDm.formFireStore(json);
    return userDm;
  }
}
