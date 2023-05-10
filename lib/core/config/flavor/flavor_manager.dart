import 'package:flutter/services.dart';

import '../../utils/print_util.dart';
import 'flavor_setting.dart';

class FlavorManager {
  static getFlavorSetting() async {
    const platform = MethodChannel('native');
    final flavor = await platform.invokeMethod<String>('getFlavor');

    dPrint('STARTED WITH FLAVOR $flavor');

    if (flavor == 'dev') {
      return FlavorSettings.dev().appSetting;
    } else if (flavor == "sit") {
      return FlavorSettings.sit().appSetting;
    } else if (flavor == "uat") {
      return FlavorSettings.uat().appSetting;
    } else if (flavor == 'prd') {
      return FlavorSettings.prd().appSetting;
    } else {
      throw Exception("Unknown flavor: $flavor");
    }
  }
}
