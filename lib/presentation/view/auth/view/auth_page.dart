// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_dimens.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/validators.dart';
import '../../../common_widgets/buttons_widget.dart';
import '../logic/login/login_cubit.dart';
import '../widget/auth_form_fields.dart';

class AuthPage extends StatefulWidget {
  static const String id = 'auth';
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  bool _validateAll = false;

  bool _emailTouched = false;
  bool _passTouched = false;

  bool get _bothValid {
    final emailOk = AuthValidators.email(_email.text) == null;
    final passOk = AuthValidators.password(_pass.text) == null;
    return emailOk && passOk;
  }

  @override
  @override
  void initState() {
    super.initState();
    _email.addListener(() {
      if (!_emailTouched) _emailTouched = true;
      setState(() {});
    });
    _pass.addListener(() {
      if (!_passTouched) _passTouched = true;
      setState(() {});
    });
    _emailFocus.addListener(() => setState(() {}));
    _passFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _validateAll = true);
    final valid = _formKey.currentState?.validate() ?? false;
    setState(() => _validateAll = false);

    if (!valid) {
      if (AuthPageSilent.email(_email.text) != null) {
        _emailFocus.requestFocus();
      } else if (AuthPageSilent.pass(_pass.text) != null) {
        _passFocus.requestFocus();
      }
      return;
    }

    context.loaderOverlay.show();
    try {
      await context.read<LoginCubit>().login(
        email: _email.text.trim(),
        password: _pass.text,
      );
    } finally {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == LoginStatus.failure && state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF5F7FA), Color(0xFFE6ECF3)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.size24,
                  vertical: AppDimens.size16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Card(
                      color: AppColors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimens.borderRadius,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimens.size20,
                          vertical: AppDimens.size24,
                        ),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: AppDimens.size8),
                              Text(
                                'auth_title'.tr(),
                                style: AppTextStyles.bold27,
                              ),
                              SizedBox(height: AppDimens.size6),
                              Text(
                                'auth_subtitle'.tr(),
                                style: AppTextStyles.normal14Grey,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: AppDimens.size24),

                              EmailField(
                                controller: _email,
                                focusNode: _emailFocus,
                                nextFocus: _passFocus,
                                validateAll: _validateAll,
                                showTouched: _emailTouched,
                                labelKey: 'auth_email'.tr(),
                              ),
                              SizedBox(height: AppDimens.size12),
                              PasswordField(
                                controller: _pass,
                                focusNode: _passFocus,
                                validateAll: _validateAll,
                                showTouched: _passTouched,
                                labelKey: 'auth_password'.tr(),
                              ),
                              SizedBox(height: AppDimens.size20),

                              MainDefaultButton(
                                label: 'auth_login'.tr(),
                                action: _bothValid ? _submit : null,
                              ),
                              SizedBox(height: AppDimens.size8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// silent checks for enabling button (no UI errors)
class AuthPageSilent {
  static String? email(String v) => AuthValidators.email(v);
  static String? pass(String v) => AuthValidators.password(v);
}
