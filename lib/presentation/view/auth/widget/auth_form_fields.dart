import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/validators.dart';

final _emailAllowed = FilteringTextInputFormatter.allow(
  RegExp(r'[A-Za-z0-9@._+\-]'),
);
final _passAllowed = FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]'));

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final bool validateAll;
  final bool showTouched;
  final String labelKey;

  const EmailField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocus,
    this.validateAll = false,
    required this.showTouched,
    this.labelKey = 'auth_email',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      inputFormatters: [_emailAllowed],
      validator: (v) {
        final shouldValidate = validateAll || focusNode.hasFocus || showTouched;
        if (!shouldValidate) return null;
        final key = AuthValidators.email(v);
        return key?.tr();
      },
      onFieldSubmitted: (_) => nextFocus?.requestFocus(),
      decoration: InputDecoration(
        labelText: labelKey.tr(),
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: AppColors.lightBlack,
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool validateAll;
  final bool showTouched;
  final String labelKey;

  const PasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.validateAll = false,
    required this.showTouched,
    this.labelKey = 'auth_password',
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _obscure,
      textInputAction: TextInputAction.done,
      inputFormatters: [_passAllowed],
      validator: (v) {
        final shouldValidate =
            widget.validateAll ||
            widget.focusNode.hasFocus ||
            widget.showTouched;
        if (!shouldValidate) return null;
        final key = AuthValidators.password(v);
        return key?.tr();
      },
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        labelText: widget.labelKey.tr(),
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.lightBlack),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
