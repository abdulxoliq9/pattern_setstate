

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:pattern_setstate/pages/creating_page.dart';
import 'package:pattern_setstate/pages/models/update_page.dart';
import 'package:pattern_setstate/services/NetWork.dart';

import 'models/posts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static final String id = 'home_page';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> items = [];
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPosts();
  }

 void apiPosts()async{
    setState(() {
      isloading = true;
    });
    var response = await NetWork.GET(NetWork.API_LIST, NetWork.paramsEmpty());
    setState(() {
      if(response != null) {
        items = NetWork.parsePostList(response);
      }
      isloading = false;
    });
  }

  void apiCreat(Post post)async{
    setState(() {
      isloading = true;
    });
    var response = await NetWork.POST(NetWork.API_CREATE, NetWork.paramsCreate(post));
    if(response != null)
      setState(() {
        items = NetWork.parsePostList(response);
        isloading = false;
      });
  }

  void apiPostsDelet(){
    setState(() {
      isloading = true;
    });
    NetWork.DEL(NetWork.API_DELETE, NetWork.paramsEmpty()).
    then((response) => {
    setState(() {
    if(response != null) {
    apiPosts();
    }
    isloading = false;
    })
    });
  }

  Future openDetail()async{
    Map results = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context){
          return const CreatePage();
        }));
    if(results != null && results.containsKey('data')){
      print(results['data']);
      apiPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Set State'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
              itemBuilder: (ctx, index){
              return itemOfPost(items[index]);
              }),
          isloading ?
              Center(
                child: CircularProgressIndicator(),
              ) :
              SizedBox.shrink()
        ],
      ),
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.pushReplacementNamed(context, CreatePage.id);
        },
      child: Icon(Icons.add),
    ),
    );

    }
  }
  Widget itemOfPost(Post post){
    return Slidable(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title!.toUpperCase(),style:
              TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(post.body!)
            ],
          ),
        ),
         endActionPane: ActionPane(
           motion: const ScrollMotion(),
           children: [
             SlidableAction(
               onPressed: ((context){

               }),
               backgroundColor: Colors.red,
               foregroundColor: Colors.white,
               icon: Icons.delete,
               label: 'Delete',
             ),
           ],
         ),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
              onPressed: ((context){
                Navigator.pushReplacementNamed(context, UpdatePage.id);
              }),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          )
        ],
      ),
    );
}
