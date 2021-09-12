part of 'shared.dart';

// Margin
const double defaultMargin = 24;

// Colors
Color mainColor = 'FFC700'.toColor();
Color blackColor = '020202'.toColor();
Color greyColor = '8D92A3'.toColor();

// Widgets
Widget loadingIndicator = SpinKitFadingCircle(
  size: 45,
  color: mainColor,
);

// Fonts
TextStyle mainFontStyle = GoogleFonts.poppins().copyWith(color: mainColor);

TextStyle blackFontStyle1 = GoogleFonts.poppins().copyWith(
  color: blackColor,
  fontSize: 22,
  fontWeight: FontWeight.w500,
);

TextStyle blackFontStyle2 = GoogleFonts.poppins().copyWith(
  color: blackColor,
  fontSize: 16,
);

TextStyle blackFontStyle3 = GoogleFonts.poppins().copyWith(color: blackColor);

TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);
