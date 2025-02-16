import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad_prac/Widget/expence.dart';
import 'package:intl/intl.dart';

class Expesetrakar extends StatefulWidget {
  const Expesetrakar({super.key});

  @override
  State<Expesetrakar> createState() => _ExpesetrakarState();
}

class _ExpesetrakarState extends State<Expesetrakar> {
  final List<Expense> _expense = [];
  final List<String> _category = ['Food','Transport','Entertainment','Gym'];
  double _total = 0;

  void _addExpense(String title,double amount,DateTime date,String category){
    setState(() {
      _expense.add(Expense(title: title, amount: amount, date: date, category: category));
      _total += amount;
    });
}


 void MySnackbar(message,context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }
  void _deleteExpense(int index){
    setState(() {
      _total -= _expense[index].amount;
      _expense.removeAt(index);
    });
  }

  void _showForm(BuildContext context){
    TextEditingController _titleController = TextEditingController();
    TextEditingController _amountController = TextEditingController();
    String selectedCategory = _category.first;
    DateTime selectedDate = DateTime.now();
    showModalBottomSheet(context: context,
        builder: (_){
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title'
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount'
              ),
            ),
            SizedBox(height: 10,),
            DropdownButtonFormField(items: _category.map((category)=>DropdownMenuItem(value: category,child: Text(category))).toList(),
                onChanged: (value)=>selectedCategory =value!,
            decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
              if(_titleController.text.isEmpty || double.tryParse(_amountController.text) == null ) {
                 MySnackbar('Empty value not allow', context);
              }
              _addExpense(_titleController.text, double.parse(_amountController.text), selectedDate, selectedCategory);
              _titleController.clear();
              _amountController.clear();
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850]
                ),
                child: Text('Add Expense'))
          ],
        ),
      );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        title: Text("Your Cost's"),
      actions: [
        IconButton(onPressed: ()=>_showForm(context), icon: Icon(Icons.add))
      ],
      ),
      body: Column(
        children: [
          Center(
            child: Card(
              margin: EdgeInsets.all(20),
              color: Colors.grey[800],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Total: \$${_total}",style: TextStyle(fontSize: 20),),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: _expense.length,
                itemBuilder: (context,index){
                  return Dismissible(
                    key: Key(_expense[index].hashCode.toString()),
                    background: Container(color: Colors.red,),
                    onDismissed: (direction)=>_deleteExpense(index),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.blueAccent,
                        child: Text(_expense[index].category),),
                        title: Text(_expense[index].title),
                        subtitle: Text(
                            DateFormat.yMMMd().format(_expense[index].date)),
                        trailing: Text(_expense[index].amount.toString(),style: TextStyle(fontSize: 15),),
                      ),

                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=>_showForm(context),child: Icon(Icons.add),backgroundColor: Colors.grey[850],),
    );
  }
}
