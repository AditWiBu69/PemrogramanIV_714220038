import 'package:dio_contact/model/contacts_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final ContactResponse ctRes;

  const ContactCard({Key? key, required this.ctRes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.lightBlue[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDataRow('ID', ctRes.insertedId),
          _buildDataRow('Message', ctRes.message),
          _buildDataRow('Status', ctRes.status),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, dynamic value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10), // Space between label and value
        Expanded(
          child: Text(
            ': $value',
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
