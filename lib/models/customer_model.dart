class Customer {
  final int id;
  final String name;
  final String contactInfo;

  Customer({required this.id, required this.name, required this.contactInfo});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      contactInfo: json['contact_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact_info': contactInfo,
    };
  }
}
