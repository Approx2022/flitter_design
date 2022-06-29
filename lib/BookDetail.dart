import 'package:flitter_design/Case_entry.dart';
import 'package:flitter_design/database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'model/Information_model.dart';

class BookDetail extends StatefulWidget {
  String bookname;
  int bookId;

  BookDetail(this.bookname, this.bookId);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  List<Information_model> list = [];
  double netBalence = 0;
  double totalIn = 0;
  double totalout = 0;

  @override
  void initState() {
    super.initState();
    print(widget.bookId);
    getData();
  }

  getData() async {
    var result = await DatabaseHelper.db.getAllBookEntriesById(widget.bookId);
    print(result);
    if (result != null) {
      list.clear();
      list = (result as List<Information_model>).reversed.toList();
      for (int i = 0; i < list.length; i++) {
        if (list[i].isCash_In) {
          netBalence += list[i].cash;
          totalIn += list[i].cash;
        } else {
          netBalence -= list[i].cash;
          totalout += list[i].cash;
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookname),
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: 100.w,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 30.h,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 5.h,
                            child: Text(
                              "Net Balance",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 5.h,
                            child: Text(
                              netBalence.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 5.h,
                            child: Text(
                              "Total in(+)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 5.h,
                            child: Text(
                              totalIn.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 5.h,
                            child: Text(
                              "Total out(-)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 5.h,
                            child: Text(
                              totalout.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 5.h,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text(
                        "View Reports",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  primary: true,
                  itemBuilder: (context, index) => Container(
                    child: ListTile(
                      title: Text("Cash : ${list[index].cash}"),
                      subtitle:
                          Text(list[index].isCash_In ? "Cash In" : "Cash Out"),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Case_entry(true, widget.bookId)));
                getData();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 5.h,
                  alignment: Alignment.center,
                  child: Text(
                    "Case in",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Case_entry(false, widget.bookId)));
                getData();
              },
              child: Container(
                height: 5.h,
                alignment: Alignment.center,
                child: Text(
                  "Case out",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
