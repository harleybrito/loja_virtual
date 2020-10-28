import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  const DrawerTile({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.controller,
    @required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          this.controller.jumpToPage(this.page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(
                this.icon,
                size: 32,
                color: this.controller.page.round() == this.page ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 32),
              Text(
                this.text,
                style: TextStyle(
                  fontSize: 16,
                  color: this.controller.page.round() == this.page ? Theme.of(context).primaryColor : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
