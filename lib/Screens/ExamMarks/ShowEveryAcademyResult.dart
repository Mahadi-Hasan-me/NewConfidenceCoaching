import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidence/Screens/PDF/MoneyReceipt.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ShowEveryAcademyResult extends StatefulWidget {
  final TeacherAcademyName;
  final BatchName;
  final ExamDate;

  const ShowEveryAcademyResult(
      {super.key, required this.TeacherAcademyName, required this.BatchName, required this.ExamDate});

  @override
  State<ShowEveryAcademyResult> createState() => _ShowEveryAcademyResultState();
}

class _ShowEveryAcademyResultState extends State<ShowEveryAcademyResult> {
  // এখানে Date দিয়ে Data fetch করতে হবে।

  var DataLoad = "";
  // Firebase All Customer Data Load

  bool loading = false;

  List AllData = [];

  List positionedAllData = [];

  List positionData = [];

  int moneyAdd = 0;

  final List<String> TeachersAcademy = [
    'Rezuan Math Care',
    'Sazzad ICT',
    'MediCrack',
    'Protick Physics',
  ];
  String? selectedTeachersAcademyValue;

  List<String> BatchName = [
    'HSC261',
    'HSC262',
    'HSC263',
    'HSC263',
  ];
  String? selectedBatchNameValue;

  var VisiblePaymentDate =
      "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here

    if (args.value is PickerDateRange) {
      try {
        final DateTime rangeStartDate = args.value.startDate;
        var adminSetDay = rangeStartDate.day;
        var adminSetMonth = rangeStartDate.month;
        var adminSetYear = rangeStartDate.year;

        var paymentDate = "${adminSetDay}/${adminSetMonth}/${adminSetYear}";

        VisiblePaymentDate = paymentDate;

        print("${adminSetDay}/${adminSetMonth}/${adminSetYear}");

        getSearchData(
            paymentDate, selectedBatchNameValue, selectedTeachersAcademyValue);
        final DateTime rangeEndDate = args.value.endDate;
      } catch (e) {}
    } else if (args.value is DateTime) {
      final DateTime selectedDate = args.value;
      print(selectedDate);
    } else if (args.value is List<DateTime>) {
      final List<DateTime> selectedDates = args.value;
      print(selectedDates);
    } else {
      final List<PickerDateRange> selectedRanges = args.value;
      print(selectedRanges);
    }
  }

  var PaymentDate =
      "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('ResultInfo');

  Future<void> getData(String dateForResult) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });

    Query query = _collectionRef
        .where("BatchName", isEqualTo: widget.BatchName)
        .where("ExamDate", isEqualTo: dateForResult)
        .where("TeacherAcademyName", isEqualTo: widget.TeacherAcademyName);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

    moneyAdd = 0;

    if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
    } else {
      setState(() {
        DataLoad = "";
      });

      setState(() {
        // moneyAdd = moneyAdd + moneyInt;
        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        // loading = false;
      });

      for (var i = 0; i < AllData.length; i++) {
        var positionString = AllData[i]["Position"].toString();
        int positionInt = int.parse(positionString);

        positionData.add(positionInt);
      }

      // positionData.sort();

      for (var x = 1; x <= positionData.length; x++) {
        for (var a = 0; a < positionData.length; a++) {
          if (x == positionData[a]) {
            int indexPosition = positionData.indexOf(x);
            var singleData = AllData[indexPosition];
            positionedAllData.add(singleData);
          }
        }
      }

      setState(() {
        // moneyAdd = moneyAdd + moneyInt;
        // AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
    }

    print(AllData);
  }

// Get Search Information

  Future<void> getSearchData(
      String dateForResult, BatchName, TeacherAcademyName) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });

    Query query = _collectionRef
        .where("BatchName", isEqualTo: BatchName)
        .where("ExamDate", isEqualTo: dateForResult)
        .where("TeacherAcademyName", isEqualTo: TeacherAcademyName);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllData = [];
    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
    } else {
      setState(() {
        DataLoad = "";
      });

      setState(() {
        // moneyAdd = moneyAdd + moneyInt;
        AllData = [];
        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        // loading = false;
      });

      positionData = [];
      positionedAllData = [];

      for (var i = 0; i < AllData.length; i++) {
        var positionString = AllData[i]["Position"].toString();
        int positionInt = int.parse(positionString);

        positionData.add(positionInt);
      }

      // positionData.sort();

      for (var x = 1; x <= positionData.length; x++) {
        for (var a = 0; a < positionData.length; a++) {
          if (x == positionData[a]) {
            int indexPosition = positionData.indexOf(x);
            var singleData = AllData[indexPosition];
            positionedAllData.add(singleData);
          }
        }
      }

      setState(() {
        // moneyAdd = moneyAdd + moneyInt;
        // AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
    }

    print(AllData);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData(widget.ExamDate);
    super.initState();
  }

  //  Future refresh() async{

  //   setState(() {

  //        getData(PaymentDate);

  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //                 context,MaterialPageRoute(builder: (context) => PerDayBikeSalePDFPreview(BikesData: todaySalesData)),
            //               );
          },
          child: Text("Print"),
        ),
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: Theme.of(context).primaryColor, // Status bar
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date;${PaymentDate},Batch: ${widget.BatchName}, Academy: ${widget.TeacherAcademyName.toString().toUpperCase()} Exam Result History",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    elevation: 20,
                    child: Container(
                      width: 200,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Academy Name',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: TeachersAcademy.map(
                              (String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )).toList(),
                          value: selectedTeachersAcademyValue,
                          onChanged: (String? value) async {
                            CollectionReference _collectionBatchInfoRef =
                                FirebaseFirestore.instance
                                    .collection('AllBatchInfo');

                            Query BatchInfoRefquery = _collectionBatchInfoRef
                                .where("TeacherAcademyName",
                                    isEqualTo: selectedTeachersAcademyValue);

                            QuerySnapshot BatchInfoRefquerySnapshot =
                                await BatchInfoRefquery.get();

                            // Get data from docs and convert map to List
                            // AllStudentInfo =
                            //     StudentInfoquerySnapshot.docs.map((doc) => doc.data()).toList();

                            setState(() {
                              selectedTeachersAcademyValue = value;
                              BatchName.clear();

                              List AllBatchInfo = [];

                              AllBatchInfo = BatchInfoRefquerySnapshot.docs
                                  .map((doc) => doc.data())
                                  .toList();

                              for (var i = 0; i < AllBatchInfo.length; i++) {
                                BatchName.add(AllBatchInfo[i]["BatchName"]);
                              }
                              ;
                            });

                            // setState(() {
                            //   selectedTeachersAcademyValue = value;
                            // });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 20,
                    child: Container(
                      width: 200,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Batch Name',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: BatchName.map(
                              (String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )).toList(),
                          value: selectedBatchNameValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedBatchNameValue = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ElevatedButton(
                  //     onPressed: () async {
                  //       // getSearchProductInfo(SearchByStudentIDController
                  //       //     .text
                  //       //     .trim()
                  //       //     .toLowerCase());

                  //       // getSearchAllStudentInfo(
                  //       //     selectedTeachersAcademyValue!,
                  //       //     selectedBatchNameValue!);
                  //     },
                  //     child: Text("Search")),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "নিচে থেকে Date Select করুন।",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: SfDateRangePicker(
                                onSelectionChanged: _onSelectionChanged,
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                                todayHighlightColor:
                                    Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.date_range,
                  color: Theme.of(context).primaryColor,
                ))
          ],
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : DataLoad == "0"
                ? const Center(child: Text("No Data Available"))
                : ListView.separated(
                    itemCount: positionedAllData.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 15,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      //  DateTime paymentDateTime = (AllData[index]["PaymentDateTime"] as Timestamp).toDate();

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          title: Text(
                            "Marks: ${AllData[index]["TotalMarks"]}/${AllData[index]["ExamMarks"]}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,MaterialPageRoute(builder: (context) => MoneyReceiptPDF(SalesData: [AllData[index]],)),
                                //   );
                              },
                              child: Text("Print")),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("SID No:${AllData[index]["SIDNo"]}"),
                              Text(
                                  "Name:${AllData[index]["StudentName"].toString().toUpperCase()}"),

                              Text(
                                  "Teacher Academy Name:${AllData[index]["TeacherAcademyName"]}"),
                              Text("Batch Name:${AllData[index]["BatchName"]}"),
                              // Text("NID:${AllData[index]["CustomerNID"]}"),

                              Text("Topic Name:${AllData[index]["TopicName"]}"),

                              Text("Position:${AllData[index]["Position"]}"),

                              Text(
                                  "Topic Marks:${AllData[index]["TotalMarks"]}"),

                              Text(
                                  "HighestMarks:${AllData[index]["HighestMarks"]}"),

                              Text("Date & Time:${AllData[index]["DateTime"]}"),

                              Text("Date: ${AllData[index]["Date"]}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
  }
}
