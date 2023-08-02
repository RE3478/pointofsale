// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SearchBar extends StatefulWidget {
//   const SearchBar({super.key});

//   @override
//   State<SearchBar> createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   final _searchQueryController = TextEditingController();
//   bool _isSearching = false;
//   String searchQuery = "Search query";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: _isSearching ? const BackButton() : Container(),
//         title: _isSearching ? _buildSearchField() : _buildTitle(context),
//         actions: _buildActions(),
//       ),
//       body: Column(
//         children: const [],
//       ),
//     );
//   }

//   Widget _buildSearchField() {
//     return TextField(
//       controller: _searchQueryController,
//       autofocus: true,
//       decoration: InputDecoration(
//         hintText: "Search Product...",
//         border: InputBorder.none,
//         hintStyle: const TextStyle(color: Colors.white30),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//       ),
//       style: const TextStyle(color: Colors.white, fontSize: 16.0),
//       onChanged: (query) => updateSearchQuery(query),
//     );
//   }

//   List<Widget> _buildActions() {
//     if (_isSearching) {
//       return <Widget>[
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () {
//             // ignore: unnecessary_null_comparison
//             if (_searchQueryController == null ||
//                 _searchQueryController.text.isEmpty) {
//               Navigator.pop(context);
//               return;
//             }
//             _clearSearchQuery();
//           },
//         ),
//       ];
//     }

//     return <Widget>[
//       IconButton(
//         icon: const Icon(Icons.search),
//         onPressed: _startSearch,
//       ),
//     ];
//   }

//   void _startSearch() {
//     ModalRoute.of(context)
//         ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

//     setState(() {
//       _isSearching = true;
//     });
//   }

//   void updateSearchQuery(String newQuery) {
//     setState(() {
//       searchQuery = newQuery;
//     });
//   }

//   void _stopSearching() {
//     _clearSearchQuery();

//     setState(() {
//       _isSearching = false;
//     });
//   }

//   void _clearSearchQuery() {
//     setState(() {
//       _searchQueryController.clear();
//       updateSearchQuery("");
//     });
//   }

//   _buildTitle(BuildContext context) {}
// }
