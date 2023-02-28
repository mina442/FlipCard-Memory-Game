import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Details{
  String name;
  Color primaryColor;
  Color secondaryColor;
  Widget? goto;
  int noOfstar;
Details(this.name,this.primaryColor,this.secondaryColor,this.noOfstar,this.goto);
}