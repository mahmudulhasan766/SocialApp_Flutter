import 'package:http/http.dart' as http;

class Api {
  String _baseUrl = "https://api.unsplash.com/photos/";
  String _clientId = "HW38Jc7lkWLwczmr_qPz7J5LqMvbAiZal1w7-YNZ-Ac";

  Future getData() async {
    return await http.get("$_baseUrl?client_id=$_clientId");
  }
}
