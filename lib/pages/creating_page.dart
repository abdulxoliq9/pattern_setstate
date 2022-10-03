import 'package:flutter/material.dart';
import 'package:pattern_setstate/pages/home_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);
static const String id = 'create_page';
  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  var titleController = TextEditingController();
  var contentController = TextEditingController();

  addPost(){
    String title = titleController.text.toString();
    String content = contentController.text.toString();
    if(title.isEmpty || content.isEmpty)return;
    apiAddPost(title,content);
  }

  apiAddPost(String title,String content){
    setState(() {
      Navigator.of(context).pop({'data':'done'});
    });
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Post'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Content'
              ),
            ),
            SizedBox(height: 25,),
            Container(
              width: double.infinity,
              height: 45,
              child: FlatButton(
                onPressed: (){
                  addPost();
                  Navigator.pushReplacementNamed(context, HomePage.id);
                },
                color: Colors.blue,
                child: const Text('Create',style:
                  TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
