//CONTAINS THE UI

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/charts/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    //here Expense is taken from the models class.../models/expense.dart'
    Expense(
        title: 'Flutter Course',
        amount: 449,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 200,
        date: DateTime.now(),
        category: Category.leisure),
  ];

//to add new expenses
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true, //takes the full size of the screen
      context: context, builder: (ctx) => NewExpense(onAddExpense: _addExpense),
      //the ctx refer to the context-showModalBotomSheet
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses
        .indexOf(expense); //this will hold the position of the expense
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex,
                  expense); //using insert instead of add so that we can isnert at that particular postion only if we have deleted it by mistake
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context)
        .size
        .width; //so that we can know how much width that specific device takes
    Widget mainContent =
        const Center(child: Text('No expenses found.Start adding some!'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, //method is defined above
            icon: const Icon(Icons.add), //shows the + button on the top
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  //wrapping with Expanded widget because col k ander col(list) aara hai to difficulty hogi display karane me list
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  //wrapping with Expanded widget because col k ander col(list) aara hai to difficulty hogi display karane me list
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
