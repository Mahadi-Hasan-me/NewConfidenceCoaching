import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidence/Screens/PDF/MoneyReceipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';





class Showperstudentexamresult extends StatefulWidget {

  final TeacherAcademyName;
  final SIDNo;

  
  const Showperstudentexamresult({super.key, required this.TeacherAcademyName, required this.SIDNo});

  @override
  State<Showperstudentexamresult> createState() => _ShowperstudentexamresultState();
}

class _ShowperstudentexamresultState extends State<Showperstudentexamresult> {


  // এখানে Date দিয়ে Data fetch করতে হবে। 




   var DataLoad = ""; 
  // Firebase All Customer Data Load

  bool loading = false;

List  AllData = [];
    int moneyAdd = 0;

  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('ResultInfo');

Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });


    Query query = _collectionRef.where("SIDNo", isEqualTo: widget.SIDNo).where("TeacherAcademyName", isEqualTo: widget.TeacherAcademyName);
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

       var money = AllData[i]["TotalMarks"].toString();
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
    getData();
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

       floatingActionButton: FloatingActionButton(onPressed: (){

        // Navigator.push(
        //                 context,MaterialPageRoute(builder: (context) => PerDayBikeSalePDFPreview(BikesData: todaySalesData)),
        //               );

      }, child: Text("Print"),),
      
      appBar: AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title:  Text("SID: ${widget.SIDNo}, Academy: ${widget.TeacherAcademyName.toString().toUpperCase()} Exam Result History", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
         actions: [
        IconButton(onPressed: (){


          showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Container(
            
            color:Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("মোটঃ ${moneyAdd} মার্কস পেয়েছে।", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),),


            SizedBox(height: 10,),



        
        ],
      );
    });

        }, icon: Icon(Icons.date_range, color: Theme.of(context).primaryColor,))

      ],
        
      ),
      body:loading?const Center(child: CircularProgressIndicator(),): DataLoad== "0"? const Center(child: Text("No Data Available")): ListView.separated(
            itemCount: AllData.length,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15,),
            itemBuilder: (BuildContext context, int index) {
            
                  //  DateTime paymentDateTime = (AllData[index]["PaymentDateTime"] as Timestamp).toDate();
            
            
              return   Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                           shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ), 
                    
                          title: Text("Marks: ${AllData[index]["TotalMarks"]}/${AllData[index]["ExamMarks"]}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          trailing: ElevatedButton(onPressed: (){
      
                  // Navigator.push(
                  //     context,MaterialPageRoute(builder: (context) => MoneyReceiptPDF(SalesData: [AllData[index]],)),
                  //   );
      
                          }, child: Text("Print")),
                          subtitle: Column(
            
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
      
      
                              Text("SID No:${AllData[index]["SIDNo"]}"),
                               Text("Name:${AllData[index]["StudentName"].toString().toUpperCase()}"),
      
      
                              Text("Teacher Academy Name:${AllData[index]["TeacherAcademyName"]}"),
                               Text("Batch Name:${AllData[index]["BatchName"]}"),
                              // Text("NID:${AllData[index]["CustomerNID"]}"),
            
                              Text("Topic Name:${AllData[index]["TopicName"]}"),

                              Text("Position:${AllData[index]["Position"]}"),

                              Text("Topic Marks:${AllData[index]["ExamMarks"]}"),

                              Text("HighestMarks:${AllData[index]["HighestMarks"]}"),
      
      
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