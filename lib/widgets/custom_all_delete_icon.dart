import 'package:flutter/material.dart';
import 'package:store_app/helper/delete_dialog_helper.dart';
import 'package:store_app/helper/show_snack_bar.dart';

class CustomAllDeleteIcon extends StatefulWidget {
  const CustomAllDeleteIcon({
    super.key,
    required this.onDeleteAll,
  });
  final VoidCallback onDeleteAll;
  @override
  State<CustomAllDeleteIcon> createState() => _CustomAllDeleteIconState();
}

class _CustomAllDeleteIconState extends State<CustomAllDeleteIcon> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () async {
          final shouldDelete = await showAlertDialog(
            context,
            'You sure you want to delete all products?',
          );
          if (shouldDelete) {
            widget.onDeleteAll();
            showSnackBar(
                // ignore: use_build_context_synchronously
                context,
                'All Products Deleted Successfully !',
                backgroundColor: Colors.green);
          }
        },
        child: const Icon(
          Icons.delete,
          size: 33,
          color: Colors.red,
        ),
      ),
    );
  }
}
