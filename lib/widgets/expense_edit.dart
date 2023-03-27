import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseEdit extends StatefulWidget {
  final double? initialValue;
  final String? initialDescription;
  final IconData? floatingActionButtonIcon;
  final void Function()? onFloatingActionButtonPressed;
  final void Function({
    required double value,
    required String? description,
  }) onSubmit;

  ExpenseEdit({
    this.floatingActionButtonIcon,
    this.onFloatingActionButtonPressed,
    this.initialValue,
    this.initialDescription,
    required this.onSubmit,
  });

  @override
  State<ExpenseEdit> createState() => _ExpenseEdit();
}

class _ExpenseEdit extends State<ExpenseEdit> {
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool isTappedDown = false;

  @override
  void initState() {
    _priceController.text = widget.initialValue?.toString() ?? '';
    _descriptionController.text = widget.initialDescription?.toString() ?? '';
    super.initState();
  }

  void onSubmit() {
    final value = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final description = _descriptionController.text.trim();

    if (value == 0) {
      Get.snackbar(
        "Nope!",
        "You can't create an expense with price value equal to 0",
        animationDuration: Duration(seconds: 2),
        backgroundColor: Colors.red.withOpacity(0.15),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    widget.onSubmit(
      value: value,
      description: description.isEmpty ? null : description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: InkWell(
        onLongPress: onSubmit,
        onHighlightChanged: (value) {
          setState(() => isTappedDown = value);
        },
        splashColor: Colors.green.shade100,
        highlightColor: Colors.green.shade400,
        focusColor: Colors.transparent,
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputPrice(),
            inputDescription(),
          ],
        ),
      ),
      floatingActionButton: widget.floatingActionButtonIcon == null
          ? null
          : FloatingActionButton(
              onPressed: widget.onFloatingActionButtonPressed,
              child: Icon(widget.floatingActionButtonIcon),
              backgroundColor: Colors.green.shade200,
              foregroundColor: Colors.green.shade900,
            ),
    );
  }

  Widget inputPrice() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "€",
            style: TextStyle(
                fontSize: 50,
                color: isTappedDown ? Colors.white : Colors.green.shade800,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 20),
          IntrinsicWidth(
            child: TextField(
              controller: _priceController,
              style: TextStyle(
                  fontSize: 50,
                  color: isTappedDown ? Colors.white : Colors.green.shade800,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: "0.00",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.green.shade200,
                ),
              ),
            ),
          ),
        ],
      );

  Widget inputDescription() => IntrinsicWidth(
        child: TextField(
          controller: _descriptionController,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25,
              color: isTappedDown ? Colors.white : Colors.green.shade800,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: "Description (optional)",
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.green.shade200,
            ),
          ),
        ),
      );
}
