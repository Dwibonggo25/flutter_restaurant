import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/home/home_page_bloc.dart';


class BottomSheetsSearch extends StatefulWidget {
  @override
  _BottomSheetsSearchState createState() => _BottomSheetsSearchState();
}

class _BottomSheetsSearchState extends State<BottomSheetsSearch> {

  final _searchFieldKey = GlobalKey<FormFieldState>();
  final _searchFieldController = TextEditingController();
  var _typeSearch = ["Menu", "Nama Restaurant"];
  String _type;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
          ),
          child: Column(
            children: [
              Text("Cari Restaurant",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.25),
              ),
              SizedBox(height: 8,),
              _seacrhField(context),
              SizedBox(height: 8,),
              _dropdownType(context),
              SizedBox(height: 8,),
              _buttonSearch(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _seacrhField(BuildContext context) {
    return TextFormField(
      key: _searchFieldKey,
      controller: _searchFieldController,
      decoration: InputDecoration(
          labelText: "Cari berdasarkan",
          filled: true,
          fillColor: Colors.grey[100],
      ),
      onChanged: (value) {

      },
    );
  }

  Widget _dropdownType(BuildContext context) {
    return Container(
      child: DropdownButton(
        hint: Text("Pilih type"),
        isExpanded: true,
        value: _type,
        items: _typeSearch.map((item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        }).toList(),
        onChanged: (value){
          setState(() {
            _type = value;
          });
        },
      ),
    );
  }

  Widget _buttonSearch(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: 80,
            child: RaisedButton(
              color: Colors.red,
              onPressed: () => {
                _validateInput()
              },
              padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: Row(// Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 4,),
                  Text("Cari",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _validateInput() {
    if(_type == null) {
      return;
    }
    context.read<HomePageBloc>().add(SearchPageIn(query: _searchFieldController.text));
    Navigator.pop(context);
  }

}

