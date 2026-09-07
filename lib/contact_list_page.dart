import 'package:flutter/material.dart';
import 'contact.dart';

class ContactListPage extends StatelessWidget {
  final List<Contact> contacts;
  const ContactListPage({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const Center(child: Text('Belum ada kontak.'));
    }
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final c = contacts[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              c.name.isNotEmpty ? c.name[0].toUpperCase() : '?',
            ),
          ),
          title: Text(c.name),
          subtitle: Text('${c.email}\n${c.phone}'),
          isThreeLine: true,
        );
      },
    );
  }
}