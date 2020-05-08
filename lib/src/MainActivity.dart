import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/src/Model/Employ.dart';
import 'package:taskapp/src/Provider/MainActivityProvider.dart';

import 'Model/Student.dart';

class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainActivityProvider>(context);

    return Scaffold(
      body: StreamBuilder(
          stream: provider.getEmploy(),
          builder: (context, AsyncSnapshot<List<Employ>> snapshot) {
            print("The data is ${snapshot.data}");

            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        snapshot.data[i].profile_image,
                                      ),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Name : ${snapshot.data[i].employee_name}"),
                                        Text(
                                            "Salary : ${snapshot.data[i].employee_salary}"),
                                        Text(
                                            "Age : ${snapshot.data[i].employee_age}"),
                                      ],
                                    )
                                  ],
                                ),
                                provider.student_list.length <= (i + 1)
                                    ? Container()
                                    : student_card(provider, i)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }

  student_card(MainActivityProvider provider, int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Roll   : ${provider.student_list[i].roll}"),
            Text("Name   : ${provider.student_list[i].name}"),
            Text("Location   : ${provider.student_list[i].location}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tag Line   : "),
                Flexible(
                    child: new Text(
                  "${provider.student_list[i].tag_line}",
                  softWrap: true,
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
