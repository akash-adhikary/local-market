class RawMaterial {
  final int materialId;
  final String name;
  final String type;
  final int dimension;
  final String color;
  final String unit;
  final int vendorId;
  final String brand;

  RawMaterial({
    required this.materialId,
    required this.name,
    required this.type,
    required this.dimension,
    required this.color,
    required this.unit,
    required this.vendorId,
    required this.brand,
  });

  // Convert JSON to Model
  factory RawMaterial.fromJson(Map<String, dynamic> json) {
    return RawMaterial(
      materialId: json['material_id'],
      name: json['name'],
      type: json['type'],
      dimension: json['dimension'],
      color: json['color'],
      unit: json['unit'],
      vendorId: json['vendor_id'],
      brand: json['brand'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'material_id': materialId,
      'name': name,
      'type': type,
      'dimension': dimension,
      'color': color,
      'unit': unit,
      'vendor_id': vendorId,
      'brand': brand,
    };
  }
}
