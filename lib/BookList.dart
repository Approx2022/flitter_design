import 'package:flitter_design/BookDetail.dart';
import 'package:flitter_design/database/DatabaseHelper.dart';
import 'package:flitter_design/model/Book_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

class BookList extends StatefulWidget {
  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<Book_model> list = [];
  TextEditingController bookname = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var result = await DatabaseHelper.db.getAllBooks();
    if (result != null) {
      list.clear();
      list = (result as List<Book_model>).reversed.toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cash book"),
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        height: 30.h,
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 7.h,
                              padding: EdgeInsets.all(8.0),
                              child: Text("Add new Book",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 5.h,
                              child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "Enter book name"),
                                  controller: bookname),
                              padding: EdgeInsets.all(8.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  int i = await DatabaseHelper.db.insertBook(
                                      Book_model(name: bookname.text));
                                  Fluttertoast.showToast(
                                      msg: "Book Create successfully.");
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BookDetail(bookname.text, i)));
                                  Navigator.pop(context);
                                  getData();
                                },
                                child: Container(
                                  height: 5.h,
                                  color: Colors.greenAccent,
                                  child: Text("Save",
                                      style: TextStyle(color: Colors.white)),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              child: Container(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  "Add new book",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => Container(
                child: ListTile(
                  title: Text("${list[index].name}"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookDetail(list[index].name, list[index].id)));
                  },
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
