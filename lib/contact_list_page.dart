import 'dart:async';
import 'package:flutter/material.dart';
import 'contact.dart';

class ContactListPage extends StatefulWidget {
  final List<Contact> contacts;
  const ContactListPage({
    super.key,
    required this.contacts,
    required this.onEdit,
    required this.onDelete,
  });
  final void Function(Contact contact) onEdit;
  final void Function(Contact contact) onDelete;

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final StreamController<String> _searchController = StreamController<String>();

  @override
  void dispose() {
    _searchController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.contacts.isEmpty) {
      return const Center(child: Text('Belum ada kontak.'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Cari kontak...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (teks) {
              _searchController.add(teks);
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<String>(
            stream: _searchController.stream,
            initialData: '',
            builder: (context, snapshot) {
              final keyword = (snapshot.data ?? '').toLowerCase();

              final hasilFilter = widget.contacts.where((c) {
                final namaCocok = c.name.toLowerCase().contains(keyword);
                final kategoriCocok =
                    (c.category ?? '').toLowerCase().contains(keyword);
                return namaCocok || kategoriCocok;
              }).toList();

              if (hasilFilter.isEmpty) {
                return const Center(child: Text('Kontak tidak ditemukan.'));
              }

              return ListView.builder(
                itemCount: hasilFilter.length,
                itemBuilder: (context, index) {
                  final c = hasilFilter[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        c.name.isNotEmpty ? c.name[0].toUpperCase() : '?',
                      ),
                    ),
                    title: Text(c.name),
                    subtitle: Text(
                      '${c.email}\n${c.phone}${c.category?.isNotEmpty == true ? '\nKategori: ${c.category}' : ''}',
                    ),
                    isThreeLine: c.category?.isNotEmpty == true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => widget.onEdit(c),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => widget.onDelete(c),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}