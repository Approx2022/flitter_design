import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class generatePdf extends StatefulWidget {
  int bookid;

  generatePdf(this.bookid);

  @override
  State<generatePdf> createState() => _generatePdfState();
}

class _generatePdfState extends State<generatePdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        width: 100.w,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
