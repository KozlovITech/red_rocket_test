class AuthValidators {
  static final RegExp _ascii = RegExp(r'^[\x00-\x7F]+$');
  static final RegExp _emailStrict =
  RegExp(r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$');

  static String? email(
      String? v, {
        String requiredMsg = 'error_email_required',
        String invalidMsg  = 'error_email_invalid',
        String latinMsg    = 'error_email_latin',
      }) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return requiredMsg;
    if (!_ascii.hasMatch(value)) return latinMsg;
    if (!_emailStrict.hasMatch(value)) return invalidMsg;
    return null;
  }

  static String? password(
      String? v, {
        String requiredMsg = 'error_pass_required',
        String shortMsg    = 'error_pass_short',
        String latinMsg    = 'error_pass_latin',
      }) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return requiredMsg;
    if (value.length < 6) return shortMsg;
    if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) return latinMsg;
    return null;
  }
}