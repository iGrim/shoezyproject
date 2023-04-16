import 'package:flutter/material.dart';
import 'package:online_shop/views/shared/appstyle.dart';

class Delete extends StatelessWidget {
  const Delete({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("45", style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }
}
