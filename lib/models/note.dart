class Note {
    int id;
    String title;
    String content;
    String noteColor;

    Note({
        this.id = 0,
        this.title = "Note", 
        this.content = "Text", 
        this.noteColor = 'red'
    });

    Map<String, dynamic> toMap() {
        Map<String, dynamic> data = Map<String, dynamic>();
        // ignore: unnecessary_null_comparison
        if (id != null) {
            data['id'] = id;
        }
        data['title'] = title;
        data['content'] = content;
        data['noteColor'] = noteColor;
        return data;
    }

    @override toString() {
        return {
            'id': id,
            'title': title,
            'content': content,
            'noteColor': noteColor,
        }.toString();
    }
}