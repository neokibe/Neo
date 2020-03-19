import 'package:flutter/material.dart';
import 'package:productapp/core/models/productModel.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/CRUDModel.dart';
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String genderType = 'Other';
  String firstName;
  String lastName ;

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<CRUDModel>(context) ;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Add Member'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'First Name',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter First Name';
                  }
                },
                  onSaved: (value) => firstName = value
              ),
              SizedBox(height: 16,),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Last Name',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Last Name';
                  }
                },
                  onSaved: (value) => lastName = value
              ),
              DropdownButton<String>(
                value: genderType,
                onChanged: (String newValue) {
                  setState(() {
                    genderType = newValue;
                  });
                },
                items: <String>['Male', 'Female', 'Other',]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await productProvider.addProduct(Product(name: firstName,price: lastName,img: genderType.toLowerCase()));
                    Navigator.pop(context) ;
                  }
                },
                child: Text('add Member', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              )

            ],
          ),
        ),
      ),
    );
  }
}
