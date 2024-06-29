import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFilterButton extends StatefulWidget {
  const CustomFilterButton(
      {super.key, required this.categories, required this.onFilterApplied, required this.selectedCategories});
 final List<String> categories;
 final List<String> selectedCategories;
  final Function(List<String>) onFilterApplied;
  @override
  State<CustomFilterButton> createState() => _CustomFilterButtonState();
}

class _CustomFilterButtonState extends State<CustomFilterButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.tune,
          size: 30,
          color: Colors.green,
        ),
        onPressed: () async {
          await FilterListDialog.display<String>(
            context,
            listData: widget.categories,
            selectedListData: widget.selectedCategories,
            choiceChipLabel: (cat) => cat,
            validateSelectedItem: (list, val) => list!.contains(val),
            hideSearchField: true,
            height: 240,
            width: 400,
            insetPadding:
                const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
            onItemSearch: (user, query) {
              return user.toLowerCase().contains(query.toLowerCase());
            },
            onApplyButtonClick: (selectedCategories) {
               widget.onFilterApplied(List.from(selectedCategories!));
              setState(() {});
              Navigator.pop(context);
            },
            
          );
        });
  }
}
