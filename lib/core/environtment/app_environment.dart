class AppEnvironment {
  AppEnvironment._();
  static final AppEnvironment _instance = AppEnvironment._();
  factory AppEnvironment() {
    return _instance;
  }

  static bool devHeader = false;
  static String id = '';
  static String name = '';
  static String urlScheme = '';
  static String enviromentServer = '';
  static String enviromentSuffix = '';
  static String authorizationHeader = 'Basic YXBwLWNsaWVudDphcHAtc2VjcmV0ITIz';

  static init(appMode) {
    if (appMode == 'PRD_VENTENY') {
      devHeader = false;
      id = 'PRD_VENTENY';
      name = 'Production';
      urlScheme = 'https://';
      enviromentServer = 'https://itunes.apple.com/';
      enviromentSuffix = '';
    }
  }
}
