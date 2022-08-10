import 'package:flutter/material.dart';

class CustomListtileLibrary extends StatelessWidget {
  final String? titleNew;
  final IconData leadingNew;
  // final PopupMenuButton? trailingNew;
  final Function()? ontapNew;
  const CustomListtileLibrary(
      {Key? key,
      required this.titleNew,
      required this.leadingNew,
      // this.trailingNew,
      this.ontapNew})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: 
         InkWell(
           child: Text(
            titleNew!,
            style: const TextStyle(
                fontSize: 25, fontFamily: 'Poppins', color: Colors.white),
                 ),
         ),
      
      leading: Icon(
        leadingNew,
        color: Colors.white,
      ),
      onTap: ontapNew,
    );
  }
}
