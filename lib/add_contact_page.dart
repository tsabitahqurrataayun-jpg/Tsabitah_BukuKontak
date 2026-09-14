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
  final _categoryController = TextEditingController();

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final contact = Contact(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        category: _categoryController.text,
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
              decoration: const InputDecoration(labelText: 'Nama'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama wajib diisi';
                  }
                  return null; // null artinya valid, tidak ada erro
                  },
                  ), // <-- koma di sini
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email wajib diisi';
                  }
                if (!value.contains('@')) {
                  return 'Email tidak valid';
                  }
                  return null;
                  },
                  ), // <-- koma di sini
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'No Handphone'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No Handphone wajib diisi';
                  }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Hanya boleh angka';
                  }
                if (value.length < 10) {
                  return 'Minimal 10 digit';
                  }
                  return null;
                  },
                  ), // <-- koma di sini
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