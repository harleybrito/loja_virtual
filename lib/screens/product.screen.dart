import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product.data.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  const ProductScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
