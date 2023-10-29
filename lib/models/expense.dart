import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; //installed for ids
import 'package:intl/intl.dart'; //installed for foarmatting dates

const uuid = Uuid(); //installed a third party package to generate unique ids
final fomatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

//key value pair to display the icon as per the category
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
};

class Expense {
//constructor
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //Initializer List feature supported by dart
  //generates a unique ID and assigns it as an initial value to the ID property whenever this expense class is initialized.

  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return fomatter.format(date);
  }
}

//2nd Modal:
//for grouping same type of categories
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  final Category category;
  final List<Expense> expenses;

  //alternative named constructor function
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); //where is used to filter the list
  //if the expense I'm currently taking a look at(expense.category) has the category I wanna set(this.category) for the ExpenseBucket,I wanna keep that expense in that list of
  // expenses(List<Expense> expenses) that is stored in this bucket.
  //Otherwise it should be dropped.

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
