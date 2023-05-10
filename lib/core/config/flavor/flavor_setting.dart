import '../../../domain/entities/app_flavor_data.dart';
import '../../enum/flavor/flvors.dart';

class FlavorSettings {
  final AppFlavorData appSetting;

  FlavorSettings.dev()
      : appSetting = AppFlavorData(
          flavorName: Flavors.dev,
          apiEndpoint: "",
          ssoEndpoint: "",
        );

  FlavorSettings.sit()
      : appSetting = AppFlavorData(
          flavorName: Flavors.sit,
          apiEndpoint: "",
          ssoEndpoint: "",
        );

  FlavorSettings.uat()
      : appSetting = AppFlavorData(
          flavorName: Flavors.uat,
          apiEndpoint: "",
          ssoEndpoint: "",
        );

  FlavorSettings.prd()
      : appSetting = AppFlavorData(
          flavorName: Flavors.prd,
          apiEndpoint: "",
          ssoEndpoint: "",
        );
}
