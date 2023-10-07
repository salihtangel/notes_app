import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';

import '../models/note.dart';
import '../models/notes_database.dart';
import '../theme/note_colors.dart';


class NoteTitleEntry extends StatelessWidget {
    final _textFieldController;

    NoteTitleEntry(this._textFieldController);

    @override
    Widget build(BuildContext context) {
        return TextField(
            controller: _textFieldController,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
                counter: null,
                counterText: "",
                hintText: 'Title',
                hintStyle: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                ),
            ),
            maxLength: 31,
            maxLines: 1,
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: Color(c1),
            ),
            textCapitalization: TextCapitalization.words,
        );
    }   
}