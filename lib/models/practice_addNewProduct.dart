import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  static const name = '/add-new product screen';

  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() {
    // TODO: implement createState
    return AddNewProductScreenState();
  }
}

class AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _productNameTEController =
      TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _imgTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewProductInProgress = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _builtForm(),
        ),
      ),
    );
  }

  _builtForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _productNameTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:
                  const InputDecoration(labelText: 'Name', hintText: 'Product Name'),
              validator: (String? value) {
                if (value?.trim().isNotEmpty ?? true) {
                  return 'Enter Product Name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _productCodeTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:
                  const InputDecoration(labelText: 'Code', hintText: 'Product Code'),
              validator: (String? value) {
                if (value?.trim().isNotEmpty ?? true) {
                  return 'Enter Product Code';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imgTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Image',
                hintText: 'Product Image',
              ),
              validator: (String? value) {
                if (value?.trim().isNotEmpty ?? true) {
                  return 'Enter Product Image';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _unitPriceTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Unit Price',
                hintText: 'Product Unit price',
              ),
              validator: (String? value) {
                if (value?.trim().isNotEmpty ?? true) {
                  return 'Enter Unit Price';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _quantityTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                hintText: 'Product Quantity',
              ),
              validator: (String? value) {
                if (value?.trim().isNotEmpty ?? true) {
                  return 'Enter Product Quantity';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _totalTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Total Price',
                hintText: 'Product Total Price',
              ),
              validator: (String? value) {
                if (value?.trim().isNotEmpty ?? true) {
                  return 'Enter Product Totalprice';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Visibility(
                visible: _addNewProductInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addNewProduct();
                      }
                      ;
                    },
                    child: const Text('Add Product')))
          ],
        ));
  }

  Future<void> _addNewProduct() async {
    _addNewProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    Map<String, dynamic> requestBody = {
      "ProductName": _productNameTEController.text.trim(),
      "ProductCode": _productCodeTEController.text.trim(),
      "Img": _imgTEController,
      "UnitPrice": _unitPriceTEController,
      "Qty": _quantityTEController,
      "TotalPrice": _totalTEController,
    };
    Response response = await post(uri,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(requestBody));
    print(response.statusCode);
    print(response.body);
    _addNewProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('product has updated!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('product has failed to update.try again')));
    }
  }

  void clearTextField() {
    _productNameTEController.clear();
    _productCodeTEController.clear();
    _unitPriceTEController.clear();
    _imgTEController.clear();
    _totalTEController.clear();
    _quantityTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _productNameTEController.dispose();
    _imgTEController.dispose();
    _quantityTEController.dispose();
    _unitPriceTEController.dispose();
    _totalTEController.dispose();
    _productCodeTEController.dispose();
  }
}
