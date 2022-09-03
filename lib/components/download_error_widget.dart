import 'package:castelturismo/components/button.dart';
import 'package:castelturismo/utils/text.dart';
import 'package:flutter/cupertino.dart';

class DownloadErrorWidget extends StatelessWidget {
  const DownloadErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/error.png",
              height: 100,
            ),
            Text(
              TextUtils.getText(
                "<it>Si è verificato un errore. Torna indietro e prova di nuovo più tardi.</it><en>An error occurred. Go back and try again later.</en><es>Se ha producido un error. Vuelve e inténtalo de nuevo más tarde.</es><de>Es ist ein Fehler aufgetreten. Gehen Sie zurück und versuchen Sie es später erneut.</de>",
                context,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Button(
              text: TextUtils.getText(
                "<it>Torna alla home</it><en>Go back to home</en><es>Volver a casa</es><de>Zurück zur Startseite</de>",
                context,
              ),
              onPress: () => Navigator.of(context).pushReplacementNamed("/"),
            ),
          ],
        ),
      ),
    );
  }
}
