part of 'main.dart';

class Entity {
  Map _attributes;
  String _domain;
  String _entityId;
  String _state;
  String _entityPicture;

  String get displayName => _attributes["friendly_name"] ?? (_attributes["name"] ?? "_");
  String get domain => _domain;
  String get entityId => _entityId;
  String get state => _state;
  set state(value) => _state = value;

  double get minValue => _attributes["min"] ?? 0.0;
  double get maxValue => _attributes["max"] ?? 100.0;
  double get valueStep => _attributes["step"] ?? 1.0;
  double get doubleState => double.tryParse(_state) ?? 0.0;
  bool get isSlider => _attributes["mode"] == "slider";

  String get deviceClass => _attributes["device_class"] ?? null;
  bool get isView => (_domain == "group") && (_attributes != null ? _attributes["view"] ?? false : false);
  bool get isGroup => _domain == "group";
  String get icon => _attributes["icon"] ?? "";
  bool get isOn => state == "on";
  String get entityPicture => _attributes["entity_picture"];
  String get unitOfMeasurement => _attributes["unit_of_measurement"] ?? "";
  List get childEntities => _attributes["entity_id"] ?? [];

  Entity(Map rawData) {
    update(rawData);
  }

  int getValueDivisions() {
    return ((maxValue - minValue)/valueStep).round().round();
  }

  void update(Map rawData) {
    _attributes = rawData["attributes"] ?? {};
    _domain = rawData["entity_id"].split(".")[0];
    _entityId = rawData["entity_id"];
    _state = rawData["state"];
  }

}