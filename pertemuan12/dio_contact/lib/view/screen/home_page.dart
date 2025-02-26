import 'package:flutter/material.dart';
import 'package:dio_contact/model/contacts_model.dart';
import 'package:dio_contact/services/api_services.dart';
import 'package:dio_contact/view/widget/contact_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _numberCtl = TextEditingController();
  String _result = '-';
  final ApiServices _dataService = ApiServices();
  List<ContactsModel> _contactMdl = [];
  ContactResponse? ctRes;

  @override
  void initState() {
    super.initState();
    refreshContactsList();
  }

  Future<void> refreshContactsList() async {
    final users = await _dataService.getAllContact();
    setState(() {
      _contactMdl = users?.toList().reversed.toList() ?? [];
    });
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _numberCtl.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty || value.length < 4) {
      return 'Nama harus memiliki minimal 4 karakter';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Nomor HP harus berupa angka';
    }
    return null;
  }

  Widget _buildListContact() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final ctList = _contactMdl[index];
        return Card(
          child: ListTile(
            title: Text(ctList.namaKontak ?? 'Nama tidak tersedia'),
            subtitle: Text(ctList.nomorHp ?? 'Nomor tidak tersedia'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    print('Edit button pressed for ${ctList.namaKontak}');
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    print('Delete button pressed for ${ctList.namaKontak}');
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
      itemCount: _contactMdl.length,
    );
  }

  Widget hasilCard(BuildContext context) {
    return ctRes != null
        ? ContactCard(ctRes: ctRes!)
        : const SizedBox.shrink();
  }

  Future<void> _postContact() async {
    if (!_formKey.currentState!.validate()) {
      displaySnackbar('Semua field harus diisi dengan benar');
      return;
    }

    final postModel = ContactInput(
      namaKontak: _nameCtl.text,
      nomorHp: _numberCtl.text,
    );

    ContactResponse? res = await _dataService.postContact(postModel);

    setState(() {
      ctRes = res;
    });

    _nameCtl.clear();
    _numberCtl.clear();
    await refreshContactsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts API'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameCtl,
                validator: _validateName,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Nama',
                  suffixIcon: IconButton(
                    onPressed: _nameCtl.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _numberCtl,
                keyboardType: TextInputType.number,
                validator: _validatePhoneNumber,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Nomor HP',
                  suffixIcon: IconButton(
                    onPressed: _numberCtl.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _postContact,
                    child: const Text('POST'),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              hasilCard(context),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: refreshContactsList,
                      child: const Text('Refresh Data'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _nameCtl.clear();
                        _numberCtl.clear();
                        _result = '-';
                        ctRes = null;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                'List Contact',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: _contactMdl.isEmpty
                    ? const Center(child: Text('No contacts available'))
                    : _buildListContact(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void displaySnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
