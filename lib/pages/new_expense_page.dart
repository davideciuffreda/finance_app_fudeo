import 'package:finance_app_fudeo/models/store.dart';
import 'package:finance_app_fudeo/widgets/expense_edit.dart';
import 'package:flutter/material.dart';

class NewExpensePage extends StatefulWidget {
  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  void onSubmit({
    required double value,
    required String? description,
  }) {
    store.value.createExpense(value: value, description: description);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ExpenseEdit(
      onSubmit: onSubmit,
    );
  }
}
