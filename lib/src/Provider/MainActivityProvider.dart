import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taskapp/src/Model/Employ.dart';
import 'package:taskapp/src/Model/Student.dart';
import 'package:http/http.dart' as http;

class MainActivityProvider extends ChangeNotifier {
  //http://www.mocky.io/v2/5cdf27653000002b00430d14
  var STUDENT_URL = "http://www.mocky.io/v2/5cdf2f353000004600430d29";
  var EMPLOY_URL = "http://www.mocky.io/v2/5cdf27653000002b00430d14";

  var _student_list;

 List<Student> get student_list => _student_list;

  MainActivityProvider() {
    futureStudent().then((value) {
      _student_list = value;
    });
  }

  Future<List<Student>> futureStudent() async {
    List<Student> student_list = new List();

    await http.get(STUDENT_URL).then((value) {
      print(value);
      if (value.body != null) {
        print(value.body);

        List students = json.decode(value.body);

        for (int i = 0; i < students.length; i++) {
          //  this.name,this.location,this.roll,this.tag_line
          student_list.add(new Student(
            name: students[i]["name"],
            location: students[i]["localtion"],
            roll: students[i]["roll"],
            tag_line: students[i]["tag_line"],
          ));
        }
      }
    });

    return student_list;
  }

  Stream<List<Employ>> getEmploy() {
    return Stream.fromFuture(futureEmploy());
  }

  Future<List<Employ>> futureEmploy() async {
    List<Employ> employ_list = new List();

    await http.get(EMPLOY_URL).then((value) {
      print(value);
      if (value.body != null) {
        print(value.body);

        List employs = json.decode(value.body);

        for (int i = 0; i < employs.length; i++) {
          //  this.name,this.location,this.roll,this.tag_line

          //  Employ({this.employee_age,this.employee_name,this.employee_salary,this.id,this.profile_image,});
          employ_list.add(new Employ(
              employee_age: employs[i]["employee_age"],
              employee_name: employs[i]["employee_name"],
              employee_salary: employs[i]["employee_salary"],
              profile_image: employs[i]["profile_image"]
              //id: students[i]["profile_image"],
              ));
        }
      }
    });

    return employ_list;
  }
}
