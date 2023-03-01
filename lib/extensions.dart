import 'dart:ui';

extension ColorExtensions on Color {
  Color brighten(int amount) {
    return withRed(red + amount).withGreen(green + amount).withBlue(blue + amount);
  }
}

extension IntExtensions on int {
  String decline(String oneWord, String twoFiveWord, String manyWord) {
    if (this >= 10 && this <= 19) return '$this $manyWord';

    final lastDigit = this % 10;

    if (lastDigit == 1) return '$this $oneWord';
    if (lastDigit > 4) return '$this $manyWord';
    return '$this $twoFiveWord';
  }
}
