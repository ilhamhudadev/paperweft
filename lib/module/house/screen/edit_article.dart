// screens/edit_article.dart
import 'package:paperweft/module/house/data/model/article_model.dart';
import 'package:paperweft/module/house/data/model/database_helper.dart';
import 'package:flutter/material.dart';

class EditArticleScreen extends StatefulWidget {
  final Article? article;

  EditArticleScreen({this.article});

  @override
  _EditArticleScreenState createState() => _EditArticleScreenState();
}

class _EditArticleScreenState extends State<EditArticleScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.article != null) {
      titleController.text = widget.article!.title;
      contentController.text = widget.article!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article == null ? 'Tambah Artikel' : 'Edit Artikel'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Isi Artikel'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Article newArticle = Article(
                  title: titleController.text,
                  content: contentController.text,
                );

                if (widget.article == null) {
                  await DatabaseHelper.instance.insertArticle(newArticle);
                } else {
                  newArticle.id = widget.article!.id;
                  await DatabaseHelper.instance.updateArticle(newArticle);
                }

                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
