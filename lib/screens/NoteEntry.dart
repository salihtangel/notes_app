import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';

import '../models/note.dart';
import '../models/notes_database.dart';
import '../theme/note_colors.dart';


class NoteEntry extends StatelessWidget {
    final _textFieldController;

    NoteEntry(this._textFieldController);

    @override
    Widget build(BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
                controller: _textFieldController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: null,
                style: TextStyle(
                    fontSize: 19,
                    height: 1.5,
                ),
            ),
        );
    }
}