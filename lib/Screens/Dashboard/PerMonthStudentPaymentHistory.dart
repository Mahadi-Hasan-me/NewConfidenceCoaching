import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Permonthstudentpaymenthistory extends StatefulWidget {
  final TeacherAcademyName;
  final BatchName;

  const Permonthstudentpaymenthistory({super.key, required this.TeacherAcademyName, required this.BatchName});

  @override
  State<Permonthstudentpaymenthistory> createState() =>
      _PermonthstudentpaymenthistoryState();
}

class _PermonthstudentpaymenthistoryState
    extends State<Permonthstudentpaymenthistory> {
  // এখানে Date দিয়ে Data fetch করতে হবে।

  var VisiblePaymentDate =
      "${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here

    if (args.value is PickerDateRange) {
      try {
        final DateTime rangeStartDate = args.value.startDate;
        var adminSetDay = rangeStartDate.day;
        var adminSetMonth = rangeStartDate.month;
        var adminSetYear = rangeStartDate.year;

        var paymentDate = "${adminSetMonth}/${adminSetYear}";

        VisiblePaymentDate = paymentDate;

        print("${adminSetDay}/${adminSetMonth}/${adminSetYear}");

        getData(paymentDate);

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
      "${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";

  var DataLoad = "";
  // Firebase All Customer Data Load

  bool loading = false;

  List AllData = [];
  int moneyAdd = 0;

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('PerTeacherStudentPayment');

  Future<void> getData(String paymentDate) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });

    Query query = _collectionRef.where("month", isEqualTo: paymentDate).where("TeacherAcademyName", isEqualTo: widget.TeacherAcademyName).where("BatchName", isEqualTo: widget.BatchName);
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

      for (var i = 0; i < AllData.length; i++) {
        var money = AllData[i]["PaymentAmount"];
        int moneyInt = int.parse(money);

        setState(() {
          moneyAdd = moneyAdd + moneyInt;
          AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
          loading = false;
        });
      }

      print(moneyAdd);
    }

    print(AllData);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData(PaymentDate);
    super.initState();
  }

  Future refresh() async {
    setState(() {
      getData(PaymentDate);
    });
  }

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
          title: const Text(
            "Per Month Payment History",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                                  "${VisiblePaymentDate} তারিখে ${moneyAdd}৳ টাকা Fee নেওয়া হয়েছে।",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
                            SizedBox(
                              height: 10,
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
                : RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.separated(
                      itemCount: AllData.length,
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
                              "${AllData[index]["PaymentAmount"]}৳",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,MaterialPageRoute(builder: (context) => ServiceMemoPDFPreview(CreditData: [AllData[index]],)),
                                  //   );
                                },
                                child: Text("Print")),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("SID No:${AllData[index]["SIDNo"]}"),

                                Text(
                                    "Teacher Academy Name:${AllData[index]["TeacherAcademyName"]}"),

                                // Text("NID:${AllData[index]["CustomerNID"]}"),

                                Text(
                                    "Discount Amount:${AllData[index]["DiscountAmount"]}"),

                                Text("Date Time:${AllData[index]["DateTime"]}"),

                                Text("Date: ${AllData[index]["Date"]}"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ));
  }
}
