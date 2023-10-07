// Display all notes
import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/theme/note_colors.dart';

// Display all notes
class AllNoteLists extends StatelessWidget {
    final data;
    final selectedNoteIds;
    final afterNavigatorPop;
    final handleNoteListLongPress;
    final handleNoteListTapAfterSelect;

    AllNoteLists(
        this.data, 
        this.selectedNoteIds,
        this.afterNavigatorPop,
        this.handleNoteListLongPress,
        this.handleNoteListTapAfterSelect,
    );

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
                dynamic item = data[index];
                return DisplayNotes(
                    item,
                    selectedNoteIds,
                    (selectedNoteIds.contains(item['id']) == false? false: true),
                    afterNavigatorPop, 
                    handleNoteListLongPress,
                    handleNoteListTapAfterSelect,
                );
            }
        );
    }
}


// A Note view showing title, first line of note and color
class DisplayNotes extends StatelessWidget {
    final notesData;
    final selectedNoteIds;
    final selectedNote;
    final callAfterNavigatorPop;
    final handleNoteListLongPress;
    final handleNoteListTapAfterSelect;

    DisplayNotes(
        this.notesData,
        this.selectedNoteIds,
        this.selectedNote,
        this.callAfterNavigatorPop,
        this.handleNoteListLongPress,
        this.handleNoteListTapAfterSelect,
    );

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Material(
                elevation: 1,
                color: (selectedNote == false? Color(c1): Color(c8)),
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(5.0),
                child: InkWell(
                    onTap: () {
                        if (selectedNote == false) {
                            if (selectedNoteIds.length == 0) {
                                // Go to edit screen to update notes
                            }
                            else {
                                handleNoteListLongPress(notesData['id']);
                            }
                        } 
                        else {
                            handleNoteListTapAfterSelect(notesData['id']);
                        }
                    },

                    onLongPress: () {
                        handleNoteListLongPress(notesData['id']);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: (selectedNote == false && notesData['noteColor'] != null && NoteColors.containsKey(notesData['noteColor']))
                                                    ? Color(NoteColors[notesData['noteColor']]!['b']!)
                                                    : Color(c9),

                                                    shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: (
                                                        selectedNote == false?
                                                        Text(
                                                          (notesData != null && notesData['title'] != null && notesData['title'].isNotEmpty)
                                                              ? notesData['title'][0]
                                                              : "",
                                                          style: TextStyle(
                                                            color: Color(c1),
                                                            fontSize: 21,
                                                          ),
                                                        ):

                                                        Icon(
                                                            Icons.check,
                                                            color: Color(c1),
                                                            size: 21,
                                                        )
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),

                                Expanded(
                                    flex: 5,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children:<Widget>[
                                          Text(
                                            (notesData != null && notesData['title'] != null && notesData['title'].isNotEmpty)
                                                ? notesData['title'][0]
                                                : "", // Eğer null veya boşsa boş bir dize döndür
                                            style: TextStyle(
                                              color: Color(c1),
                                              fontSize: 21,
                                            ),
                                          ),


                                            Container(
                                                height: 3,
                                            ),

                                            Text(
                                            (notesData != null && notesData['content'] != null && notesData['content'].isNotEmpty)
                                                ? notesData['content'].split('\n')[0]
                                                : "",
                                            style: TextStyle(
                                              color: Color(c7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),

                                        ],
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}