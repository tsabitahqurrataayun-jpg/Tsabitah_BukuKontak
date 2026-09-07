import 'package:flutter/material.dart';
import 'contact.dart';
import 'contact_list_page.dart';
import 'favorite_page.dart';
import 'add_contact_page.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Contact> _contacts = [];

  Future<void> _openAddContact() async {
    final result = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(builder: (_) => const AddContactPage()),
    );
    if (result != null) {
      setState(() => _contacts.add(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buku Kontak'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kontak'),
              Tab(text: 'Favorit'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.teal),
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: const Icon(Icons.contacts),
                title: const Text('Kontak'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Tambah Kontak'),
                onTap: () {
                  Navigator.pop(context);
                  _openAddContact();
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favorit'),
                onTap: () {
                  Navigator.pop(context);
                  DefaultTabController.of(context).animateTo(1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Tentang'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ContactListPage(contacts: _contacts),
            const FavoritePage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openAddContact,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}