class RegularMatch{

  static const String PHONE_REG = "^((1[0-9][0-9])\\d{8}\$)";
  ///校验用户手机号码
  static bool isChinaPhoneLegal(String str) {
    return new RegExp(PHONE_REG).hasMatch(str);
  }
}