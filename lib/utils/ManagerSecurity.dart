import 'package:encrypt/encrypt.dart';
import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/blocks/register_block.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:string_encryption/string_encryption.dart';

import 'dart:convert';

class ManagerSecurity {
  final cryptor = new StringEncryption();

  //final passwordT = Constant.security;
  final _prefs = new PreferenciasUsuario();
  String keyS;
  Future<String> generatekey() async {
    await _prefs.initPrefs();
    // final String key = await cryptor.generateRandomKey();
    if (_prefs.securityKey == "") {
      final String salt = await cryptor.generateSalt();
      _prefs.securityKey = salt;
      keyS = await cryptor.generateKeyFromPassword(
          Constant.securityKey, _prefs.securityKey);
      return keyS;
    }
    print(_prefs.securityKey);
    return _prefs.securityKey;
  }

  Future<String> newEncryp(String password) async {
    final plainText = password;
    final key = Key.fromUtf8(Constant.securityKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    // final fernet = Fernet(b64key);
    // final encrypter = Encrypter(fernet);

    // final encrypted = encrypter.encrypt(plainText);
    var encry = encrypted.base64.toString();
    return encry;
    // final decrypted = encrypter.decrypt(encrypted);

    // print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    // print(encrypted.base64); // random cipher text
    // print(fernet.extractTimestamp(encrypted.bytes)); // unix timestamp
  }

  Future<String> decryptedNew(String password) async {
    final plainText = password;
    final key = Key.fromUtf8(Constant.securityKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final decrypted = encrypter.decrypt(Encrypted.from64(plainText), iv: iv);
    return decrypted;
    // print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    // print(encrypted.base64); // random cipher text
    // print(fernet.extractTimestamp(encrypted.bytes)); // unix timestamp
  }

  Future<String> encrypte(String password) async {
    await _prefs.initPrefs();
    print(password);

    return await cryptor.encrypt(password, await generatekey());
  }

  Future<String> deencrypte(String password) async {
    try {
      final String decrypted =
          await cryptor.decrypt(password, await generatekey());
      print(decrypted);
      return decrypted; // - A string to encrypt.
    } on MacMismatchException {
      // unable to decrypt (wrong key or forged data)
      print(MacMismatchException);
      return "error";
    }
  }
}
