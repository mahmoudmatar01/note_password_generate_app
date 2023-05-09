class NotesModel {
  NotesModel(
      {required this.noteTitle,
      required this.noteContent,
      this.imagePath = "images/logo.avif"});

  String noteTitle;
  String noteContent;
  String imagePath = "images/logo.avif";
}
