import 'package:adminridex/commons/CommonMethods.dart';
import 'package:adminridex/global/globalVars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
CommonMethods commonMethods=CommonMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainTheme,
      ),
      backgroundColor: mainTheme,
      body:FirebaseAnimatedList(
        query: FirebaseDatabase.instance.ref().child("owners"),
        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
          return
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xffe9e9e9),
                  borderRadius: BorderRadius.circular(12)
              ),
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Container(
                        height: 150,
                        width:MediaQuery.of(context).size.width/3,
                        child: CachedNetworkImage(
                          imageUrl:
                          snapshot.child("logo").value.toString(),
                          placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                          imageBuilder: (context, imageprovider) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: imageprovider,
                                      fit: BoxFit.fill)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("BlockStatus : ${snapshot.child("blockstatus").value.toString()}"),
                        ElevatedButton(onPressed: (){
                          changeBlockStatusToApproved(snapshot);
                        }, child: const Text("  Approve ")),
                        ElevatedButton(onPressed: (){
                          changeBlockStatusToDisapproved(snapshot);
                        }, child: const Text("Disapprove"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  changeBlockStatusToApproved(DataSnapshot snapshot) async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context)=>const LinearProgressIndicator());
  Map<String,Object> value={
    "blockstatus":"no"
  };
 DatabaseReference databaseReference=FirebaseDatabase.instance.ref().child("owners").child(snapshot.key.toString());
    await databaseReference.update(value).whenComplete(() {
      Navigator.pop(context);
      commonMethods.displaySnackBar("Approved", context);
    });
  }

  changeBlockStatusToDisapproved(DataSnapshot snapshot) async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context)=>const LinearProgressIndicator());
    Map<String,Object> value={
      "blockstatus":"yes"
    };
    DatabaseReference databaseReference=FirebaseDatabase.instance.ref().child("owners").child(snapshot.key.toString());
    await databaseReference.update(value).whenComplete(() {
      Navigator.pop(context);
      commonMethods.displaySnackBar("Rejected", context);
    });
  }
}


