import 'package:flutter/material.dart';
import 'package:ui_project_04/models/practice_update_product_list_screen.dart';
import 'package:ui_project_04/models/product.dart';

class productItem extends StatelessWidget{
  final Product product;

  const productItem({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: Image.network(product.img ?? '',width: 40,),
      title: Text(product.ProductName ?? 'Unknown'),
      subtitle: Column(
        children: [
          Text('Product Code:${product.ProductCode ?? 'Unkwnon'}'),
          Text('Product Iamge:${product.img ??'Unknown'}'),
          Text('Unit Price ${product.UnitPrice ?? 'Unknown'}'),
          Text('Quantity:${product.Qty ?? 'Unknown'}'),
          Text('Total Price ${product.TotalPrice ?? 'Unknown'}'),
          Text('Create Date:${product.CreateDate ?? 'Unknown'}')
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, UpdateProductListScreen.name,arguments: product);
          } , icon: const Icon(Icons
              .edit))
        ],
      ),

    );
  }

}