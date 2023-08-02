// import 'package:smart_online_sale/modells/category_selection.dart';

// class Repository {
//   // List getAll() => _nigeria;

//   Future<List<String>> getLocalByState(String state) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return Future.value(_nigeria
//         .map((map) => StateModel.fromJson(map))
//         .where((item) => item.state == state)
//         .map((item) => item.lgas)
//         .expand((i) => i)
//         .toList());
//   }

//   List<String> getStates() => _nigeria
//       .map((map) => StateModel.fromJson(map))
//       .map((item) => item.state)
//       .toList();
//   // _nigeria.map((item) => item['state'].toString()).toList();

//   final List _nigeria = [
//     {
//       "state": "Adamawa",
//       "alias": "adamawa",
//       "lgas": [
//         "Demsa",
//         "Fufure",
//         "Ganye",
//         "Gayuk",
//         "Song",
//         "Toungo",
//         "Yola North",
//         "Yola South"
//       ]
//     },
//     {
//       "state": "Yobe",
//       "alias": "yobe",
//       "lgas": [
//         "Bade",
//         "Bursari",
//         "Jakusko",
//         "Karasuwa",
//         "Nguru",
//         "Potiskum",
//         "Tarmuwa",
//         "Yunusari"
//       ]
//     },
//     {
//       "state": "Zamfara",
//       "alias": "zamfara",
//       "lgas": [
//         "Anka",
//         "Birnin Magaji/Kiyaw",
//         "Bakura",
//         "Kaura Namoda",
//         "Maru",
//         "Talata Mafara",
//         "Tsafe",
//         "Zurmi"
//       ]
//     },
//     {
//       "state": "Lagos",
//       "alias": "lagos",
//       "lgas": [
//         "Agege",
//         "Ajeromi-Ifelodun",
//         "Ikorodu",
//         "Kosofe",
//         "Ojo",
//         "Oshodi-Isolo",
//         "Shomolu",
//         "Surulere Lagos State"
//       ]
//     },
//     {
//       "state": "Katsina",
//       "alias": "katsina",
//       "lgas": [
//         "Bakori",
//         "Mani",
//         "Mashi",
//         "Sabuwa",
//         "Safana",
//         "Sandamu",
//         "Zango"
//       ]
//     },
//     {
//       "state": "Kwara",
//       "alias": "kwara",
//       "lgas": [
//         "Asa",
//         "Baruten",
//         "Edu",
//         "Ilorin East",
//         "Ifelodun",
//         "Moro",
//         "Offa",
//         "Oke Ero",
//         "Oyun",
//         "Pategi"
//       ]
//     },
//   ];
// }
