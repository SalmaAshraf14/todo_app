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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController fullNameController;

  late TextEditingController userNameController;

  late TextEditingController emailNameController;

  late TextEditingController passwordNameController;

  late TextEditingController rePasswordNameController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    emailNameController = TextEditingController();
    passwordNameController = TextEditingController();
    rePasswordNameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    emailNameController.dispose();
    passwordNameController.dispose();
    rePasswordNameController.dispose();
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
                Text('Full Name', style: AppLightStyles.title),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: 'enter your full name',
                  keyBoardType: TextInputType.name,
                  controller: fullNameController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz, enter full name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text('User Name', style: AppLightStyles.title),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: 'enter  user name',
                  keyBoardType: TextInputType.name,
                  controller: userNameController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz, enter user name';
                    }
                    return null;
                  },
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
                Text('re_Password', style: AppLightStyles.title),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: ' Password confirmation',
                  keyBoardType: TextInputType.visiblePassword,
                  controller: rePasswordNameController,
                  isSecure: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz, enter confirm Password';
                    }
                    if (input != passwordNameController.text) {
                      return "Password doesn't match";
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
                    signUp();
                  },
                  child: Text(
                    'Sign-Up',
                    style: AppLightStyles.buttonTitle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account?",
                      style: AppLightStyles.title?.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.login);
                      },
                      child: Text('Sing-In ',
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

  void signUp() async {
    if (formKey.currentState?.validate() == false) return;

    try {
      DialogUtils.showLoading(context, message: 'Wait...');
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailNameController.text,
        password: passwordNameController.text,
      );
      addUserToFireStore(credential.user!.uid);
      print(credential.user!.uid);
      if (mounted) {
        DialogUtils.hide(context);
      }

      DialogUtils.showMessage(
        context,
        body: 'User register successfully',
        posActionTitle: 'Ok',
        posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.login);
        },
      );
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hide(context);
      late String message;
      if (authError.code == ConstantManager.weakPasswordCode) {
        message = 'The password provided is too weak.';
      } else if (authError.code == ConstantManager.emailAlreadyInUseCode) {
        message = 'The account already exists for that email.';
      }
      DialogUtils.showMessage(context,
          title: 'Error occurred', body: message, posActionTitle: 'Ok');
    } catch (error) {
      DialogUtils.hide(context);
      DialogUtils.showMessage(context,
          title: 'Error Occurred', body: error.toString());
    }
  }

  void addUserToFireStore(String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDm.collectionName);
    DocumentReference userDocument = usersCollection.doc(uid);
    UserDm userDm = UserDm(
        id: uid,
        fullName: fullNameController.text,
        userName: userNameController.text,
        email: emailNameController.text);
    await userDocument.set(userDm.toFireStore());
  }
}
