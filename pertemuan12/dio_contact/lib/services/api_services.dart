import 'package:dio_contact/model/contact_model.dart';
import 'package:flutter/material.dart';

class ApiServices {

  final Dio dio = Dio();
  final String _baseUrl = 'https://ulbicontacts-59a677aa5bea.herokuapp.com/';

  Future<Iterable<ContactsModel>?> getAllContact() async {
    try {
      var respnse = await dio.get('$_baseUrl/contacts');

      if (respnse.statusCode == 200) {
        final contactlist = (response.data['data'] as List)
         .map((contact) => ContactsModel.fromJson(contact))
         .toList();

      return contactlist;
  }
  return null;
    }on DioException catch (e) {
      if (e.respnse != null && e.response!.statusCode != 200) {
        debugPrint(
          'client error - The request cannot be fulfilled');
          return null;
      }
      rethrow;
    }catch (e) {
      rethrow;
    }
  }

  Future<ContactsModel?> getSingleContact(String id) async {}

  Future<ContactResponse?> postContact(ContactInput ct) async {
    try {
      final response = await dio.post(
        '$_baseUrl/insert',
        data: ct.toJson(),
      );
      if (response.statusCode == 200) {
        return ContactResponse.fromJson(response.data);
    }
    return null;
      } catch (e) {
        rethrow;
      }
      }

  Future<ContactResponse?> putContact(String id, ContactInput ct) async {}

  Future deleteContact(String id) async {}
}
