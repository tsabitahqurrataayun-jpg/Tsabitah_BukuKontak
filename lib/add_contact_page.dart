import 'package:flutter/material.dart';
import 'contact.dart';

class AddContactPage extends StatefulWidget {
  final Contact? existingContact;

  const AddContactPage({super.key, this.existingContact});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    final contact = widget.existingContact;
    _nameController = TextEditingController(text: contact?.name ?? '');
    _emailController = TextEditingController(text: contact?.email ?? '');
    _phoneController = TextEditingController(text: contact?.phone ?? '');
    _categoryController = TextEditingController(text: contact?.category ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _saveContact() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(
      context,
      Contact(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        category: _categoryController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingContact == null ? 'Tambah Kontak' : 'Edit Kontak',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }
                  return value.contains('@') ? null : 'Email harus mengandung @';
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'No. Handphone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No. HP wajib diisi';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'No. HP hanya boleh berisi angka';
                  }
                  return value.length >= 10 ? null : 'No. HP minimal 10 digit';
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveContact,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
