import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkProvider {
  Future<String> createLink(String refcod) async {
    final String url = "http://app.prueba?=$refcod";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        androidParameters: const AndroidParameters(
            packageName: "app.prueba", minimumVersion: 0),
        iosParameters:
            const IOSParameters(bundleId: "app.prueba", minimumVersion: "0"),
        link: Uri.parse(url),
        uriPrefix: "http://pruebadevsystem.page.link");

    final FirebaseDynamicLinks link = await FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters);

    return refLink.shortUrl.toString();
  }

  void initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      final Uri refLink = instanceLink.link;
      print("Este es el link $refLink");
    }
  }
}
