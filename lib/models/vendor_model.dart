class Vendor {
  final int vendorId;
  final String name;
  final String contactInfo;
  final String address;
  final String city;
  final String gst;
  final String additionalInfo;
  final String emailId;

  Vendor({
    required this.vendorId,
    required this.name,
    required this.contactInfo,
    required this.address,
    required this.city,
    required this.gst,
    required this.additionalInfo,
    required this.emailId,
  });

  // Convert JSON to Model
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorId: json['vendor_id'],
      name: json['name'],
      contactInfo: json['contact_info'],
      address: json['address'],
      city: json['city'],
      gst: json['gst'],
      additionalInfo: json['additional_info'],
      emailId: json['email_id'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'vendor_id': vendorId,
      'name': name,
      'contact_info': contactInfo,
      'address': address,
      'city': city,
      'gst': gst,
      'additional_info': additionalInfo,
      'email_id': emailId,
    };
  }
}
