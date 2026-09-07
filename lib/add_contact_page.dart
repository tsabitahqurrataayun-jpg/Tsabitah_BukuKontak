import 'package:flutter/material.dart';
import 'contact.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final contact = Contact(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );
      Navigator.pop(context, contact); // kembali ke halaman Kontak
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Kontak')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (v) => v == null || v.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v == null || v.isEmpty ? 'Email wajib diisi' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'No. Handphone'),
                validator: (v) => v == null || v.isEmpty ? 'No. HP wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _saveContact, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}