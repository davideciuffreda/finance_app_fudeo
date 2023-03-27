// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:finance_app_fudeo/models/store.dart';
import 'package:finance_app_fudeo/routing/router_constants.dart';
import 'package:finance_app_fudeo/widgets/expense_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          header(),
          contentList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(newExpensePageRoute);
        },
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget header() => Obx(
        () => Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          color: Colors.green.shade400,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "this month".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "${store.value.totalExpenseMonth.toStringAsFixed(2)}€",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  children: [
                    HeaderExpensesStats(
                      value: store.value.totalExpenseToday,
                      label: "Today",
                    ),
                    HeaderExpensesStats(
                      value: store.value.totalExpenseWeek,
                      label: "Week",
                    ),
                    HeaderExpensesStats(
                      value: store.value.totalExpenseYear,
                      label: "Year",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget contentList() => Obx(
        () => Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -2),
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: store.value.expenses.length,
              itemBuilder: (context, index) => ExpenseTile(
                store.value.expenses[index],
              ),
              separatorBuilder: (context, index) => Divider(
                height: 0,
              ),
            ),
          ),
        ),
      );
}

class HeaderExpensesStats extends StatelessWidget {
  final double value;
  final String label;

  const HeaderExpensesStats({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade300,
        border: Border.all(color: Colors.green.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            "${value.toStringAsFixed(2)}€",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.green.shade100,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
