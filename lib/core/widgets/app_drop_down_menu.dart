import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employee_attendance_system/core/theme/app_theme.dart';
import 'package:employee_attendance_system/core/widgets/app_text_filed.dart';
import 'package:flutter/material.dart';

class AppDropDownMenu extends StatelessWidget {
  String? label;
  List<String>? menus = [];

  TextEditingController? controller;

  GlobalKey<FormFieldState>? stateKey = GlobalKey<FormFieldState>();

  TextEditingController? _searchTextEditingController = TextEditingController();

  AppDropDownMenu(
      {super.key,
      required this.label,
      required this.menus,
      required this.controller,
      required this.stateKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: DropdownButtonFormField2<String>(
            dropdownSearchData: _searhDropDown(context),
            key: stateKey,
            isDense: true,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: label ?? "",
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
            items: menus!
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Container(
                      //  height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              e,
                              style: AppTheme.bodyText1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          // Spacer(),
                          //  Divider(
                          //    height: 1,
                          //    color: Colors.black45,
                          //  )
                        ],
                      ),
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
            menuItemStyleData: const MenuItemStyleData(
              height: 72,
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 7,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  DropdownSearchData<String> _searhDropDown(BuildContext context) {
    return DropdownSearchData(
      searchController: _searchTextEditingController,
      searchInnerWidgetHeight: 52,
      searchInnerWidget: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppTextFiled(
          context: context,
          controller: _searchTextEditingController,
          isRequired: false,
          label: "Search",
          hint: 'Search',
          textInputType: TextInputType.name,
        ),
      ),
      searchMatchFn: (item, searchValue) {
        return item.value
                ?.toLowerCase()
                .toString()
                .contains(searchValue.toLowerCase().toLowerCase()) ??
            false;
      },
    );
  }
}
