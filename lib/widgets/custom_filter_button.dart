import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

class CustomFilterButton extends StatefulWidget {
  const CustomFilterButton(
      {super.key,
      required this.categories,
      required this.onFilterApplied,
      required this.selectedCategories, required this.allProductsDeleted});
  final List<String> categories;
  final List<String> selectedCategories;
  final Function(List<String>) onFilterApplied;
  final bool allProductsDeleted;
  @override
  State<CustomFilterButton> createState() => _CustomFilterButtonState();
}

class _CustomFilterButtonState extends State<CustomFilterButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.tune,
          size: 30,
          color: widget.allProductsDeleted ? Colors.grey : Colors.green,
        ),
        onPressed: widget.allProductsDeleted ? null : () async {
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
