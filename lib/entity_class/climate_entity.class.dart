part of '../main.dart';

class ClimateEntity extends Entity {

  @override
  EntityHistoryConfig historyConfig = EntityHistoryConfig(
    chartType: EntityHistoryWidgetType.numericAttributes,
    numericState: false,
    numericAttributesToShow: ["current_temperature"]
  );

  static const SUPPORT_TARGET_TEMPERATURE = 1;
  static const SUPPORT_TARGET_TEMPERATURE_HIGH = 2;
  static const SUPPORT_TARGET_TEMPERATURE_LOW = 4;
  static const SUPPORT_TARGET_HUMIDITY = 8;
  static const SUPPORT_TARGET_HUMIDITY_HIGH = 16;
  static const SUPPORT_TARGET_HUMIDITY_LOW = 32;
  static const SUPPORT_FAN_MODE = 64;
  static const SUPPORT_OPERATION_MODE = 128;
  static const SUPPORT_HOLD_MODE = 256;
  static const SUPPORT_SWING_MODE = 512;
  static const SUPPORT_AWAY_MODE = 1024;
  static const SUPPORT_AUX_HEAT = 2048;
  static const SUPPORT_ON_OFF = 4096;

  ClimateEntity(Map rawData, String webHost) : super(rawData, webHost);

  bool get supportTargetTemperature => ((supportedFeatures &
  ClimateEntity.SUPPORT_TARGET_TEMPERATURE) ==
      ClimateEntity.SUPPORT_TARGET_TEMPERATURE);
  bool get supportTargetTemperatureHigh => ((supportedFeatures &
  ClimateEntity.SUPPORT_TARGET_TEMPERATURE_HIGH) ==
      ClimateEntity.SUPPORT_TARGET_TEMPERATURE_HIGH);
  bool get supportTargetTemperatureLow => ((supportedFeatures &
  ClimateEntity.SUPPORT_TARGET_TEMPERATURE_LOW) ==
      ClimateEntity.SUPPORT_TARGET_TEMPERATURE_LOW);
  bool get supportTargetHumidity => ((supportedFeatures &
  ClimateEntity.SUPPORT_TARGET_HUMIDITY) ==
      ClimateEntity.SUPPORT_TARGET_HUMIDITY);
  bool get supportTargetHumidityHigh => ((supportedFeatures &
  ClimateEntity.SUPPORT_TARGET_HUMIDITY_HIGH) ==
      ClimateEntity.SUPPORT_TARGET_HUMIDITY_HIGH);
  bool get supportTargetHumidityLow => ((supportedFeatures &
  ClimateEntity.SUPPORT_TARGET_HUMIDITY_LOW) ==
      ClimateEntity.SUPPORT_TARGET_HUMIDITY_LOW);
  bool get supportFanMode =>
      ((supportedFeatures & ClimateEntity.SUPPORT_FAN_MODE) ==
          ClimateEntity.SUPPORT_FAN_MODE);
  bool get supportOperationMode => ((supportedFeatures &
  ClimateEntity.SUPPORT_OPERATION_MODE) ==
      ClimateEntity.SUPPORT_OPERATION_MODE);
  bool get supportHoldMode =>
      ((supportedFeatures & ClimateEntity.SUPPORT_HOLD_MODE) ==
          ClimateEntity.SUPPORT_HOLD_MODE);
  bool get supportSwingMode =>
      ((supportedFeatures & ClimateEntity.SUPPORT_SWING_MODE) ==
          ClimateEntity.SUPPORT_SWING_MODE);
  bool get supportAwayMode =>
      ((supportedFeatures & ClimateEntity.SUPPORT_AWAY_MODE) ==
          ClimateEntity.SUPPORT_AWAY_MODE);
  bool get supportAuxHeat =>
      ((supportedFeatures & ClimateEntity.SUPPORT_AUX_HEAT) ==
          ClimateEntity.SUPPORT_AUX_HEAT);
  bool get supportOnOff =>
      ((supportedFeatures & ClimateEntity.SUPPORT_ON_OFF) ==
          ClimateEntity.SUPPORT_ON_OFF);

  List<String> get operationList => attributes["operation_list"] != null
      ? (attributes["operation_list"] as List).cast<String>()
      : null;
  List<String> get fanList => attributes["fan_list"] != null
      ? (attributes["fan_list"] as List).cast<String>()
      : null;
  List<String> get swingList => attributes["swing_list"] != null
      ? (attributes["swing_list"] as List).cast<String>()
      : null;
  double get temperature => _getDoubleAttributeValue('temperature');
  double get targetHigh => _getDoubleAttributeValue('target_temp_high');
  double get targetLow => _getDoubleAttributeValue('target_temp_low');
  double get maxTemp => _getDoubleAttributeValue('max_temp') ?? 100.0;
  double get minTemp => _getDoubleAttributeValue('min_temp') ?? -100.0;
  double get targetHumidity => _getDoubleAttributeValue('humidity');
  double get maxHumidity => _getDoubleAttributeValue('max_humidity');
  double get minHumidity => _getDoubleAttributeValue('min_humidity');
  double get temperatureStep => _getDoubleAttributeValue('target_temp_step') ?? 0.5;
  String get operationMode => attributes['operation_mode'];
  String get fanMode => attributes['fan_mode'];
  String get swingMode => attributes['swing_mode'];
  bool get awayMode => attributes['away_mode'] == "on";
  bool get isOff => state == EntityState.off;
  bool get auxHeat => attributes['aux_heat'] == "on";

  @override
  void update(Map rawData, String webHost) {
    super.update(rawData, webHost);
    if (supportTargetTemperature) {
      historyConfig.numericAttributesToShow.add("temperature");
    }
    if (supportTargetTemperatureHigh) {
      historyConfig.numericAttributesToShow.add("target_temp_high");
    }
    if (supportTargetTemperatureLow) {
      historyConfig.numericAttributesToShow.add("target_temp_low");
    }
  }

  @override
  Widget _buildStatePart(BuildContext context) {
    return ClimateStateWidget();
  }

  @override
  Widget _buildAdditionalControlsForPage(BuildContext context) {
    return ClimateControlWidget();
  }

  @override
  double _getDoubleAttributeValue(String attributeName) {
    var temp1 = attributes["$attributeName"];
    if (temp1 is int) {
      return temp1.toDouble();
    } else if (temp1 is double) {
      return temp1;
    } else {
      return null;
    }
  }

}