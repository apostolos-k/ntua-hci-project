class CarModel {
  final int? id;
  final String? displayname;
  final String? brand;
  final String? model;
  final String? type;
  final String? mileage;
  final String? plate;

  CarModel(
      {this.id,
      this.displayname,
      this.brand,
      this.model,
      this.type,
      this.mileage,
      this.plate});

  CarModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        displayname = res['displayname'],
        brand = res['brand'],
        model = res['model'],
        type = res['type'],
        mileage = res['mileage'],
        plate = res['plate'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "displayname": displayname,
      "brand": brand,
      "model": model,
      "type": type,
      "mileage": mileage,
      "plate": plate,
    };
  }
}
