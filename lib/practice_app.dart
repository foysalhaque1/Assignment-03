import 'package:flutter/material.dart';
import 'package:ui_project_04/models/practice_update_product_list_screen.dart';
import 'package:ui_project_04/models/product.dart';
import 'models/practice_addNewProduct.dart';
import 'models/prctice_product_list_screen.dart';

class CRUDApp extends StatelessWidget{
  const CRUDApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings){
        late Widget widget;
        if(settings.name=='/'){
          widget=const productListScreen();
        }else if(settings.name==AddNewProductScreen.name){
          widget=const AddNewProductScreen();
        }else if(settings.name==UpdateProductListScreen.name){
          final Product product=settings.arguments as Product;
          widget=UpdateProductListScreen(product:product);
        }
        return MaterialPageRoute(builder: (context){
          return widget;
        });
      },
    );
  }

}