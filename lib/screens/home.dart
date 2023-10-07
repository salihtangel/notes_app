import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes_database.dart';
import 'package:notes_app/screens/AllNoteLists.dart';
import 'package:notes_app/screens/home.dart';
import './notes_edit.dart';
import '../theme/note_colors.dart';

const c1 = 0xFFFDFFFC, c2 = 0xFFFF595E, c3 = 0xFF374B4A, c4 = 0xFF00B1CC, c5 = 0xFFFFD65C, c6 = 0xFFB9CACA,
    c7 = 0x80374B4A, c8 = 0x3300B1CC, c9 = 0xCCFF595E;

// Home Screen
class Home extends StatefulWidget{
    @override
    _Home createState() => _Home();
}







class _Home extends State<Home> {

  Future<List<Map<String, dynamic>>> readDatabase() async {
    try {
      NotesDatabase notesDb = NotesDatabase();
      await notesDb.initDatabase();
      print(notesDb);
      List<Map> notesList = await notesDb.getAllNotes();
      await notesDb.closeDatabase();
      List<Map<String, dynamic>> notesData = List<Map<String, dynamic>>.from(notesList);
        notesData.sort((a, b) => (a['title']).compareTo(b['title']));
      return notesData;
    } catch(e) {
        print('Error retrieving notes');
        return [{}];
    }
}

late List<Map<String, dynamic>>? notesData;
List<int> selectedNoteIds = [];



    // Render the screen and update changes
  void afterNavigatorPop() {
      setState(() {});
  }

  // Long Press handler to display bottom bar
  void handleNoteListLongPress(int id) {
      setState(() {
          if (selectedNoteIds.contains(id) == false) {
              selectedNoteIds.add(id);
          }
      });
  }

  // Remove selection after long press
  void handleNoteListTapAfterSelect(int id) {
      setState(() {
          if (selectedNoteIds.contains(id) == true) {
              selectedNoteIds.remove(id);
          }
      });
  }

  // Delete Note/Notes
  void handleDelete() async {
      try {
          NotesDatabase notesDb = NotesDatabase();
          await notesDb.initDatabase();
          for (int id in selectedNoteIds) {
              int result = await notesDb.deleteNote(id);
          }
          await notesDb.closeDatabase();
      } catch (e) {

      } finally {
          setState(() {
              selectedNoteIds = [];
          });
      }
  }



  @override
  void initState() {
    super.initState();
    loadNotes();
  }

   Future<void> loadNotes() async {
    try {
      NotesDatabase notesDb = NotesDatabase();
      await notesDb.initDatabase();
      List<Map> notesList = await notesDb.getAllNotes();
      await notesDb.closeDatabase();

      notesData = List<Map<String, dynamic>>.from(notesList);

      setState(() {});
    } catch (e) {
      print('Error retrieving notes');
    }
  }
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Super Note',
            home: Scaffold(
                backgroundColor: Color(c6),
                appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: const Color(c2),

                    title: const Text(
                        'Super Note',
                        style: TextStyle(
                            color: Color(c5),
                        ),
                    ), systemOverlayStyle: SystemUiOverlayStyle.light,
                ),

                  //Floating Button
                  floatingActionButton: FloatingActionButton(
                      tooltip: 'New Notes',
                      backgroundColor: const Color(c4),
                      // Go to Edit screen
                      onPressed: () {
                        Navigator.push(
                          context,     
                          MaterialPageRoute(builder: (context) => NotesEdit()),
                        );
                       },
                      child: const Icon(
                          Icons.add,
                          color:  Color(c5),
                      )
                      ),
                    body: FutureBuilder(
                    future: readDatabase(),


                    builder: (context, snapshot) {
                        if (snapshot.hasData) {
                            notesData = snapshot.data;
                            return Stack(
                                children: <Widget>[
                                    // Display Notes
                                    AllNoteLists(
                                        snapshot.data,
                                        this.selectedNoteIds,
                                        afterNavigatorPop,
                                        handleNoteListLongPress,
                                        handleNoteListTapAfterSelect,
                                    ),
                                ],
                            );
                        } 
                      else {
                            return const Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Color(c3),
                                ),
                              );
                      }
                  }
              ),
                                  
            ),
        );
    }
}