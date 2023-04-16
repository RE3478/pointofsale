import 'package:flutter/material.dart';
import 'package:smart_online_sale/utils/repository/repository.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Repository repo = Repository();

  List<String> _states = ["Choose a state"];
  List<String> _lgas = ["Choose .."];
  String _selectedState = "Choose a state";
  String _selectedLGA = "Choose ..";
  bool _isLoading = false;

  @override
  void initState() {
    _states = List.from(_states)..addAll(repo.getStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Column(
            children: [
              DropdownButton<String>(
                isExpanded: true,
                items: _states.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (value) => _onSelectedState(value!),
                value: _selectedState,
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : DropdownButton<String>(
                      isExpanded: true,
                      items: _lgas.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      // onChanged: (value) => print(value),
                      onChanged: (value) => _onSelectedLGA(value!),
                      value: _selectedLGA,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectedState(String value) async {
    setState(() {
      _selectedLGA = "Choose ..";
      _selectedState = value;
      _lgas = ["Choose .."];
      _isLoading = true;
    });

    _lgas = List.from(_lgas)..addAll(await repo.getLocalByState(value));

    setState(() {
      _isLoading = false;
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => _selectedLGA = value);
  }
}
