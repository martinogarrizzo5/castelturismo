import 'package:flutter/cupertino.dart';

class TextUtils {
  static String getText(String description, BuildContext context) {
    // localize user language
    Locale userLocale = Localizations.localeOf(context);
    var language = userLocale.languageCode.substring(0, 2);

    final descriptions = description.split("<");

    String translatedDescription = "";
    String englishDescription = "";

    for (var text in descriptions) {
      if (text.startsWith(language)) {
        translatedDescription = text.substring(3);
      }
      if (text.startsWith("en")) {
        englishDescription = text.substring(3);
      }
    }

    // default language set to english
    if (translatedDescription.isEmpty) {
      return englishDescription;
    }

    return translatedDescription;
  }
}
