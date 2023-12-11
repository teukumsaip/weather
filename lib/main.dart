import 'package:flutter/material.dart';
import 'package:weather_api/repository_api.dart';
import 'package:weather_api/weather_response_model.dart';
void main(){
 runApp(
 const MaterialApp(
 home: ApiWeather(),
 debugShowCheckedModeBanner: false,
 ),);
}
class ApiWeather extends StatefulWidget {
 const ApiWeather({Key? key}) : super(key: key);
 @override
 State<ApiWeather> createState() => _ApiWeatherState();
}
class _ApiWeatherState extends State<ApiWeather> {
 List<String> list = <String>['Kuningan','Bandung', 'Jakarta',
'Semarang'];
 String? dropdownValue;
 RepositoryApi repositoryApi = RepositoryApi();
 WeatherResponseModel weatherResponseModel = WeatherResponseModel();
 bool isLoading = true;
 @override
 void initState() {
 dropdownValue = list.first;
 getApiWeather();
 super.initState();
 }
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title : const Text('get API Weather')
 ),
 body: SafeArea(
 child: isLoading ? Center(
 child: Column(
 mainAxisSize: MainAxisSize.min,
 children: const [
 CircularProgressIndicator(),
 SizedBox(height: 12),
 Text('Mengambil Data Ramalan Cuaca')
 ],
 ),
 ) : SingleChildScrollView(
 child: Column(
 mainAxisAlignment: MainAxisAlignment.center,
 children: [
 const SizedBox(height: 12),
 Row(
 mainAxisAlignment: MainAxisAlignment.center,
children: [
 const Text('Pilih Kota : ',style: TextStyle(color:
Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
 DropdownButton<String>(
 value: dropdownValue,
icon: const
Icon(Icons.arrow_drop_down_circle_outlined),
 elevation: 16,
style: const TextStyle(color: Colors.deepPurple),
 //underline: Container(height: 2, color:
Colors.deepPurpleAccent,),
 onChanged: (String? value) {
 setState(() {isLoading = true;});
 dropdownValue = value!;
 getApiWeather();
 },
items: list.map<DropdownMenuItem<String>>((String
value) {
 return DropdownMenuItem<String>(
 value: value,
 child: Text(value),
 );
 }).toList(),
 ),
 ],
 ),
 const SizedBox(height: 12),
 if(!isLoading)...[
 Container(
 margin: const EdgeInsets.symmetric(vertical:
5,horizontal: 10),
 padding: const EdgeInsets.all(10),
 decoration: const BoxDecoration(
 color: Colors.blue,
 borderRadius:
BorderRadius.all(Radius.circular(10.0))
 ),
child: Column(
 children: [
 const Text('Perkiraan Cuaca Hari ini',style:
TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
 const SizedBox(height: 10),
 Text('Deskripsi :
${weatherResponseModel.description}',style: const TextStyle(color:
Colors.white,fontSize: 12,fontWeight: FontWeight.normal),),
 Text('Suhu :
${weatherResponseModel.temperature}',style: const TextStyle(color:
Colors.white,fontSize: 12,fontWeight: FontWeight.normal)),
 Text('Kecepatan Angin :
${weatherResponseModel.wind}',style: const TextStyle(color:
Colors.white,fontSize: 12,fontWeight: FontWeight.normal)),
 ],
 ),
 ),
const SizedBox(height: 10),
 const Text('Perkiraan Cuaca selama 3 Hari : ',style:
TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
 const SizedBox(height: 10),
 ListView.builder(
 padding: EdgeInsets.zero,
 itemCount: weatherResponseModel.forecast!.length,
 scrollDirection: Axis.vertical,
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
 itemBuilder: (BuildContext context, int index) {
 return Container(
 margin: const EdgeInsets.symmetric(vertical:
5,horizontal: 10),
 padding: const EdgeInsets.all(10),
 decoration: const BoxDecoration(
 color: Colors.black12,
borderRadius:
BorderRadius.all(Radius.circular(10.0))
 ),
child: Column(
 crossAxisAlignment: CrossAxisAlignment.start,
children: [
 const SizedBox(height: 2),
 Text('Hari ke :
${weatherResponseModel.forecast![index].day}',style: const TextStyle(color:
Colors.black,fontSize: 12,fontWeight: FontWeight.normal)),
 Text('Angin :
${weatherResponseModel.forecast![index].wind}',style: const
TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal)),
 Text('Suhu :
${weatherResponseModel.forecast![index].temperature}',style: const
TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal)),
 const SizedBox(height: 2),
 ],
 ),
 );
 }),
 ]
 ],
 ),
 )
 ),
 );
 }
 getApiWeather(){
 repositoryApi.getWeather(path: dropdownValue!).then((value) {
 weatherResponseModel = value;
 setState(() {isLoading = false;});
 });
 }
}