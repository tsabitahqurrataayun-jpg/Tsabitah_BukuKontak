class Contact {
  String name;
  String phone;
  String email;
  String? category; // <-- baru, nullable karena opsional

  Contact({
    required this.name,
    required this.phone,
    required this.email,
    this.category, // <-- opsional, tidak pakai 'required'
  });
}