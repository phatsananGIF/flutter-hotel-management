
import '../../core/enum/flavor/flvors.dart';

class AppFlavorData {
  final Flavors flavorName;
  final String apiEndpoint;
  final String ssoEndpoint;

  AppFlavorData({
    required this.flavorName,
    required this.apiEndpoint,
    required this.ssoEndpoint,
  });
}
