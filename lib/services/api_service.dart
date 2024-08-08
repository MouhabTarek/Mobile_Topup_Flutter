
class ApiService {
  static const String baseUrl = 'https://api.example.com';

  List<Map<String, String>> fetchBeneficiaries()  {
    // Mocking API call
    //final response = await http.get(Uri.parse('$baseUrl/beneficiaries'));

    return [
        {'id': '1', 'nickname': 'John Doe', 'phoneNumber': '1234567890'},
        {'id': '2', 'nickname': 'Jane Doe', 'phoneNumber': '0987654321'},
      ];
//  if (response.statusCode == 200) {
//   // Here we mock data for demonstration
//   
//   else {
//   throw Exception('Failed to load beneficiaries');
//  
  }
}