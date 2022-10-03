import 'package:flutter/material.dart';
import 'package:pattern_setstate/pages/home_page.dart';
import 'package:pattern_setstate/pages/models/posts.dart';
import 'package:pattern_setstate/services/NetWork.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  static final String id = 'update_page';
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  List<Post> items = [];
   String data = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var post = Post(id: 1,title: "PDP",body: "Online",userId: 1);
    apiUpdatePost(post);
  }

  apiUpdatePost(Post post)async{
    String response = await NetWork.PUT(NetWork.API_UPDATE, NetWork.paramsUpdate(post));
    setState(() {
      print(data);
      data == '' ? 'No data' : data = response ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update'),
        actions: [
          IconButton(
              onPressed: (){Navigator.pushReplacementNamed(context, HomePage.id);},
              icon: Icon(Icons.keyboard_arrow_left_rounded))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[400],
        child: Column(
          children: [
            Text(data),
          ],
        ),
      ),
    );
  }
}
