import 'package:flutter/material.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/library/widgets/library_playlist_widget.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xff29225a), Color(0xff2b234e)])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Your Libraries',
              style: TextStyle(
                fontFamily: 'assets/fonts/Inter-Medium.ttf',
                fontSize: 26,
                color: Color(0xffFFFDFD),
                fontWeight: FontWeight.bold,
              ),
            ),
            //**//     // actions: [
            //**//       //   IconButton(
            //**//           //     onPressed: () {},
            //**//           //     icon: const Icon(
            //**//          //       Icons.search,
            //**//           //       color: Colors.white,
            //**//            //       size: 26,
            //**//          //     ),
            //**//          //   ),
            //**//        //   IconButton(
            //**//       //     onPressed: () {
            //**//        //       showAlertDialog(context);
            //**//        //     },
            //**//       //     icon: const Icon(
            //**//       //       Icons.add,
            //**//       //       color: Colors.white,
            //**//      //       size: 28,
            //**//       //     ),
            //**//        //   ),
            //**//       //  ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            //for crearing default tabbar fix column children in child property
            // child:
            // Column(children: [

            //   Container(
            // height: 39,
            //**//  // width: 100,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(15.0),
            //   color: Colors.white,
            // ),
            // child: TabBar(
            //   indicator: BoxDecoration(
            //     color: Colors.green[300],
            //     borderRadius: BorderRadius.circular(15.0),
            //   ),
            //   labelColor: Colors.white,
            //   labelStyle: const TextStyle(
            //     fontSize: 18,
            //   ),
            //   unselectedLabelColor: Colors.black,
            //   tabs: const [
            //     Tab(
            //       text: 'Playlists',
            //     ),
            //**//   // Tab(text: 'Artists'),
            //   ],
            // ),
            //   ),
            //  const Expanded(
            //   child: TabBarView(children: [
            //**//    // Center(
            //**//    // child:

            // LibraryPlaylist(),
            //**//    // ),
            // Artist(),
            //   ]),
            //  )
            // ]),
            //calling library screen by second method//
            child: SingleChildScrollView(
              child: Column(
                children:const[
                  TabBar(
                    tabs: [
                      Text(
                        'Playlists',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.green,
                  ),
                  LibraryPlaylistWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //creatin a alert Dialoge for playlist add button
  showAlertDialog(BuildContext context) async {
    //set up the buttons
    Widget CancelButton = await TextButton(
      child: const Text('Cancel'),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget addButton = await TextButton(
      child: const Text('Create'),
      onPressed: () {},
    );
    //Setting the alert Dialogue
    AlertDialog alert = AlertDialog(
      content: const Text('Create Playlist a name'),
      actions: [
        CancelButton,
        addButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //Creating AlertDialogue for delete button
  alertDialogDelete(BuildContext context) async {
    //set up the buttons
    Widget CancelButton = await TextButton(
      child: const Text('Cancel'),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget addButton = await TextButton(
      child: const Text('OK'),
      onPressed: () {},
    );
    //Setting the alert Dialogue
    AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xffB4AFEF),
      content: const Text('Are you sure want to Remove the playlist'),
      actions: [
        CancelButton,
        addButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
