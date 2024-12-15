import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ui_project_04/models/practice_addNewProduct.dart';
import 'package:ui_project_04/models/practice_product_item.dart';
import 'package:ui_project_04/models/product.dart';

class productListScreen extends StatefulWidget {
  const productListScreen({super.key});

  @override
  State<productListScreen> createState() {
    // TODO: implement createState
    return productListScreenState();
  }
}

class productListScreenState extends State<productListScreen> {
  List<Product> productList = [];
  bool _getproductListInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Product list Screen'),
        actions: [
          IconButton(
              onPressed: () {
                _getProductList();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            _getProductList();
          },
          child: Visibility(
            visible: _getProductList == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return productItem(
                    product: productList[index],
                  );
                }),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewProductScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getProductList() async {
    productList.clear();
    _getproductListInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodedData=jsonDecode(response.body);
      print(decodedData['status']);
      for(Map<String,dynamic> p in decodedData['data']){
        Product product=Product(
        id:p["_id"],
        ProductName:p["Product Name"],
        ProductCode: p['ProductCode'],
    Qty: p['Qty'],
    UnitPrice: p['UnitPrice'],
    img: p['Img'],
    TotalPrice: p['TotalPrice'],
    CreateDate: p['CreatedDate'],
        );
        productList.add(product);
      }
      setState(() {});
    }
    _getproductListInProgress = false;
    setState(() {});
  }
}
