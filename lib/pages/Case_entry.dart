import 'package:flitter_design/database/DatabaseHelper.dart';
import 'package:flitter_design/model/Information_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

String category = "Salary";
String mode = "Cash";

TextEditingController amount = TextEditingController();

class Case_entry extends StatefulWidget {
  bool isCashIn;
  int book_id;

  Case_entry(this.isCashIn, this.book_id, {Key? key}) : super(key: key);

  @override
  State<Case_entry> createState() => _Case_entryState();
}

class _Case_entryState extends State<Case_entry> {
  late DateTime date;
  late TimeOfDay day;

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    day = TimeOfDay.now();
  }

  getDate() async {
    showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        date = pickedDate;
      }
      setState(() {});
    });
  }

  getTime() async {
    showTimePicker(
            context: context,
            initialTime: day,
            initialEntryMode: TimePickerEntryMode.dial,
            confirmText: "CONFIRM",
            cancelText: "NOT NOW",
            helpText: "BOOKING TIME")
        .then((value) {
      if (value != null) day = value;
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Cash in Entry"),
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
      ),
      body: Container(
          width: 100.w,
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text("${day.hour}:${day.minute}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => getTime(),
                              child: Container(
                                child: Icon(Icons.timelapse_rounded),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                  "${date.day}-${date.month}-${date.year}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => getDate(),
                              child: Container(
                                child: Icon(Icons.calendar_today_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 7.h,
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Enter Amount"),
                  controller: amount,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    new LengthLimitingTextInputFormatter(8)
                  ],
                ),
              ),
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                          height: 50.h,
                          width: 100.w,
                          child: Radiobutto_catagory()),
                    );
                  },
                ),
                child: Container(
                  height: 5.h,
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("Payment Category",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18)),
                ),
              ),
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                          height: 70.h,
                          width: 100.w,
                          child: RadioButton_mode()),
                    );
                  },
                ),
                child: Container(
                  height: 7.h,
                  padding: EdgeInsets.all(10.0),
                  child: Text("Payment Mode",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18)),
                ),
              ),
              InkWell(
                onTap: () async {
                  await DatabaseHelper.db.insertInfo(Information_model(
                      //time: day,
                      date: DateTime(date.year, date.month, date.day, day.hour,
                          day.minute),
                      category: category,
                      book_id: widget.book_id,
                      cash: double.parse(amount.text),
                      isCash_In: widget.isCashIn,
                      mode: mode));
                  Fluttertoast.showToast(msg: "Save successfully.");
                  Navigator.pop(context);
                },
                child: Container(
                  height: 7.h,
                  padding: EdgeInsets.all(8.0),
                  child: Text("Save",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18)),
                ),
              ),
            ],
          )),
    );
  }
}

class Radiobutto_catagory extends StatefulWidget {
  const Radiobutto_catagory({Key? key}) : super(key: key);

  @override
  State<Radiobutto_catagory> createState() => _Radiobutto_catagoryState();
}

class _Radiobutto_catagoryState extends State<Radiobutto_catagory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Container(
              height: 5.h,
              child: Text("Category of Payments",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          ListTile(
            title: Text("Salary"),
            leading: Radio(
                value: "Salary",
                groupValue: category,
                onChanged: (value) {
                  setState(() {
                    category = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Bills"),
            leading: Radio(
                value: "Bills",
                groupValue: category,
                onChanged: (value) {
                  setState(() {
                    category = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Sale"),
            leading: Radio(
                value: "Sale",
                groupValue: category,
                onChanged: (value) {
                  setState(() {
                    category = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Bonus"),
            leading: Radio(
                value: "Bonus",
                groupValue: category,
                onChanged: (value) {
                  setState(() {
                    category = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Profit"),
            leading: Radio(
                value: "Profit",
                groupValue: category,
                onChanged: (value) {
                  setState(() {
                    category = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Deposit"),
            leading: Radio(
                value: "Deposit",
                groupValue: category,
                onChanged: (value) {
                  setState(() {
                    category = value.toString();
                  });
                }),
          ),
        ],
      ),
    );
  }
}

class RadioButton_mode extends StatefulWidget {
  const RadioButton_mode({Key? key}) : super(key: key);

  @override
  State<RadioButton_mode> createState() => _RadioButton_modeState();
}

class _RadioButton_modeState extends State<RadioButton_mode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Container(
              height: 5.h,
              child: Text("Mode of Payments",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          ListTile(
            title: Text("Cash"),
            leading: Radio(
                value: "Cash",
                groupValue: mode,
                onChanged: (value) {
                  setState(() {
                    mode = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Google Pay"),
            leading: Radio(
                value: "Google Pay",
                groupValue: mode,
                onChanged: (value) {
                  setState(() {
                    mode = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Phone Pay"),
            leading: Radio(
                value: "Phone Pay",
                groupValue: mode,
                onChanged: (value) {
                  setState(() {
                    mode = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Paytm"),
            leading: Radio(
                value: "Paytm",
                groupValue: mode,
                onChanged: (value) {
                  setState(() {
                    mode = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Bank Account"),
            leading: Radio(
                value: "Bank Accoynt",
                groupValue: mode,
                onChanged: (value) {
                  setState(() {
                    mode = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Net Banking"),
            leading: Radio(
                value: "Net Banking",
                groupValue: mode,
                onChanged: (value) {
                  setState(() {
                    mode = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Credit Card"),
            leading: Radio(
                value: "Credit Card",
                groupValue: mode,
                onChanged: (value) {
                  setState(() {
                    mode = value.toString();
                  });
                }),
          ),
          ListTile(
            title: Text("Debit Card"),
            leading: Radio(
                value: "Debit Card",
                groupValue: mode,
                onChanged: (value) {
                  setState(() {
                    mode = value.toString();
                  });
                }),
          ),
        ],
      ),
    );
  }
}
