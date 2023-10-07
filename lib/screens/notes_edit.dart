import 'package:flutter/material.dart';
import 'package:notes_app/screens/ColorPalette.dart';

import '../models/note.dart';
import '../models/notes_database.dart';
import '../theme/note_colors.dart';

import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';
import 'NoteEntry.dart';
import 'NoteTitleEntry.dart';



const c1 = 0xFFFDFFFC, c2 = 0xFFFF595E, c3 = 0xFF374B4A, c4 = 0xFF00B1CC, c5 = 0xFFFFD65C, c6 = 0xFFB9CACA,
    c7 = 0x80374B4A;

class NotesEdit extends StatefulWidget {
    _NotesEdit createState() => _NotesEdit();
}

class _NotesEdit extends State<NotesEdit> {

    Future<void> _insertNote(Note note) async {
    NotesDatabase notesDb = NotesDatabase();
    await notesDb.initDatabase();
    int result = await notesDb.insertNote(note);
    await notesDb.closeDatabase();
  }



    String noteTitle = '';
    String noteContent = '';
    String noteColor = 'red';

    TextEditingController _titleTextController = TextEditingController();
    TextEditingController _contentTextController = TextEditingController();

void handleBackButton() async {
    if (noteTitle.length == 0) {
        // Go Back without saving
        if (noteContent.length == 0) {
            Navigator.pop(context);
            return;
        }
        else {
            String title = noteContent.split('\n')[0];
            if (title.length > 31) {
                title = title.substring(0, 31);
            }
            setState(() {
                noteTitle = title;
            });
        }
    }

    // Save New note
    Note noteObj = Note(
        title: noteTitle, 
        content: noteContent, 
        noteColor: noteColor
    );

    try {
        await _insertNote(noteObj);
    } catch (e) {
        print('Error inserting row: $e'); // Hata mesajını yazdır
    } finally {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: control_flow_in_finally
        return;
    }
}

    void handleTitleTextChange() {
        setState(() {
            noteTitle = _titleTextController.text.trim();
        });
    }

    void handleNoteTextChange() {
        setState(() {
            noteContent = _contentTextController.text.trim();
        });
    }

    @override
    void initState() {
        super.initState();
        _titleTextController.addListener(handleTitleTextChange);
        _contentTextController.addListener(handleNoteTextChange);
    }

    @override
    void dispose() {
        _titleTextController.dispose();
        _contentTextController.dispose();
        super.dispose();
    }

    void handleColor(currentContext) {
    showDialog(
        context: currentContext,
        builder: (context) => ColorPalette(
            parentContext: currentContext,
        ),
    ).then((colorName) {
        if (colorName != null) {
            setState(() {
                noteColor = colorName;
            });
        }
    });
}

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Color(NoteColors[noteColor]!['l']!),
            appBar: AppBar(
                backgroundColor: Color(NoteColors[noteColor]!['b']!),

                leading: IconButton(
                    icon: const Icon(
                        Icons.arrow_back,
                        color: const Color(c1),
                    ),
                    tooltip: 'Back',
                    onPressed: () => { 
                      handleBackButton()
                    },
                ),
                actions: [
              IconButton(
                  icon: const Icon(
                      Icons.color_lens,
                      color: const Color(c1),
                  ),
                  tooltip: 'Color Palette',
                  onPressed: () => handleColor(context),
              ),
          ],

                title: NoteTitleEntry(_titleTextController),
            ),

            body: NoteEntry(_contentTextController),
        );
    }

}

