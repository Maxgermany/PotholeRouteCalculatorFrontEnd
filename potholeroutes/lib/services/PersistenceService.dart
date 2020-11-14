import 'package:shared_preferences/shared_preferences.dart';

class PersistentService {
  final prefs = SharedPreferences.getInstance();

  Future<String> getContractId() {
    return prefs.then((value) => value.getString('contractId') ?? '000');
  }

  void setContractId(String contractId) {
    prefs.then((value) => value.setString('contractId', contractId));
  }
}
