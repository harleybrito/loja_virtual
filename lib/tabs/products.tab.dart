import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category.tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection("products").get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            itemCount: snapshot.data.docs.length,
            separatorBuilder: (context, index) => Divider(height: 0),
            itemBuilder: (context, index) {
              QueryDocumentSnapshot category = snapshot.data.docs[index];
              return CategoryTile(snapshot: category);
            },
          );
        }
      },
    );
  }
}
