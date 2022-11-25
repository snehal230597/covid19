import 'dart:convert';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;
import '../../models/WorldStatesModel.dart';


class StatesServices  {
  /*--------------------------- deaths api----------------------------------------*/
  Future<WorldStatesModel> fetchWorldStatesRecords () async {
     final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
     var data = jsonDecode(response.body.toString());

     if(response.statusCode == 200){
      return  WorldStatesModel.fromJson(data);
     }else{
       throw Exception('Error');
     }
  }
/*--------------------------- countries list api---------------------------------------*/
  Future<List<dynamic>> countriesListApi () async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
      return  data;
    }else{
      throw Exception('Error');
    }
  }
}