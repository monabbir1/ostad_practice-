import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ostad_prac/Widget/expence.dart';

class Expesetrakar extends StatefulWidget {
  const Expesetrakar({super.key});

  @override
  State<Expesetrakar> createState() => _ExpesetrakarState();
}

class _ExpesetrakarState extends State<Expesetrakar> {
  List<Expense> _expense = [];
  List<String> _category = ['Food','Entertainment','Bill','Others'];
  double _total = 0;
  
  void _addExpense(String title, double amount, DateTime date, String category){
    setState(() {
      _expense.add(Expense(title: title, amount: amount, date: date, category: category));
      _total += amount;
    });
  }
  void _deleteExpense(int index){
    setState(() {
      _total -= _expense[index].amount;
      _expense.removeAt(index);
    });
  }

  void _showFrom(BuildContext context){
    TextEditingController _titleController = TextEditingController();
    TextEditingController _amountController = TextEditingController();
    String selectedCategory = _category.first;
    DateTime selectedTime = DateTime.now();

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
            ),),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
              labelText: 'Amount'
            ),),

            DropdownButtonFormField(items: _category.map((category)=>DropdownMenuItem(value: category,child: Text(category),)).toList() ,
                onChanged:(value)=> selectedCategory =value! ,decoration: InputDecoration(labelText: 'Category'),),
              
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
              if(_titleController.text.isEmpty || double.tryParse(_amountController.text) == null){

              }
              _addExpense(_titleController.text, double.parse(_amountController.text), selectedTime, selectedCategory);
              _titleController.clear();
              _amountController.clear();
            }, child: Text("Add Expense"))
          ],
        ),
      );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Cost'),
      backgroundColor: Colors.grey[800],
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()=>_showFrom(context), icon: Icon(Icons.add))
        ],
      ),
      
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.all(20),
                child: Text('Total: \৳ ${_total}',style: TextStyle(fontSize: 20),),
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                  itemCount: _expense.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[900],
                              child: Text(_expense[index].category),
                            ),
                            title: Text(_expense[index].title),
                            subtitle: Text(DateFormat.yMMMd().format(_expense[index].date )),
                            trailing: Text(_expense[index].amount.toString()),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=>_showFrom(context),
        backgroundColor: Colors.grey[800],
        child: Icon(Icons.add),),
    );
  }
}
