import 'package:flutter/material.dart';
import 'package:productapp/core/models/productModel.dart';
import 'package:productapp/core/viewmodels/CRUDModel.dart';
import 'package:provider/provider.dart';


class ModifyProduct extends StatefulWidget {
  final Product product;

  ModifyProduct({@required this.product});

  @override
  _ModifyProductState createState() => _ModifyProductState();
}

class _ModifyProductState extends State<ModifyProduct> {
  final _formKey = GlobalKey<FormState>();

  String genderType ;

  String firstName ;

  String lastName ;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    genderType =  widget.product.img[0].toUpperCase() + widget.product.img.substring(1);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Modify Member Details'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.product.name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Product Title',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Product Title';
                    }
                  },
                  onSaved: (value) => firstName = value
              ),
              SizedBox(height: 16,),
              TextFormField(
                  initialValue: widget.product.price,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Price',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter The price';
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
                items: <String>['Male', 'Female','Other']
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
                    await productProvider.updateProduct(Product(name: firstName,price: lastName,img: genderType.toLowerCase()),widget.product.id);
                    Navigator.pop(context) ;
                  }
                },
                child: Text('Modify Product', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              )

            ],
          ),
        ),
      ),
    );
  }
}
