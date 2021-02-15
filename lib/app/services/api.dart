import 'package:cov_19/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

class API {
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.apiSandboxKey);

  static final String host = "ncov2019-admin.firebaseapp.com";
  Uri tokenUri() => Uri(
        scheme: "https",
        host: host,
        path: "token",
      );
}
