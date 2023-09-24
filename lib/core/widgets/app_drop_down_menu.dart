import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppDropDownMenu extends StatelessWidget {
  String? label;
  List<String>? menus = [];

  TextEditingController? controller;

   GlobalKey<FormFieldState>? stateKey = GlobalKey<FormFieldState>();


  AppDropDownMenu({super.key, required this.label, required this.menus , required this.controller , required this.stateKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: DropdownButtonFormField2<String>(

            key: stateKey,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: label ?? "",
              border: const OutlineInputBorder(),
            ),
            items: menus!
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(e, style: TextStyle(fontSize: 17),),
                    ),
                  ),
                )
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              print(value);

              controller!.text = value!;
            },
            onMenuStateChange: (isMenuOpen) {
              print(isMenuOpen);
            },
            onSaved: (value) {
              print(value);
            },
            openWithLongPress: false,
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        )
      ],
    );
  }
}
