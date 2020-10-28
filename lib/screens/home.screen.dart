import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home.tab.dart';
import 'package:loja_virtual/tabs/products.tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.widget.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(pageController: _pageController),
          body: ProductsTab(),
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.purple,
        ),
      ],
    );
  }
}
