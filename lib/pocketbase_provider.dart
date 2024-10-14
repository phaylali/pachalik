import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pocketbaseProvider = Provider<PocketBase>((ref) {
  // Replace this with the actual URL for your PocketBase server
  const pb = 'http://127.0.0.1:8090/';
  return PocketBase(pb);
});

Future<void> signUp(PocketBase pb) async {
  final body = <String, dynamic>{
    "username": "Bob",
    "email": "bob@example.com",
    "password": "12345678",
    "passwordConfirm": "12345678",
    "name": "Bob Smith"
  };

  final record = await pb.collection('users').create(body: body);
  if (kDebugMode) {
    print(record);
  }
}

class SignUpProvider extends ChangeNotifier {
  final PocketBase pocketbase;

  SignUpProvider({required this.pocketbase});

  Future<void> createUser(Map<String, dynamic> body) async {
    try {
      final record = await pocketbase.collection('users').create(body: body);
      notifyListeners(); // Notify listeners when the user is created
    } catch (e) {
      // Handle any errors here
      rethrow;
    }
  }
}

final signUpProvider =
    StateNotifierProvider<SignUpProvider, Map<String, dynamic>>(
  (ref) => SignUpProvider(pocketbase: ref.watch(pocketbaseProvider)),
);
