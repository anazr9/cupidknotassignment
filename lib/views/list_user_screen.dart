import 'dart:convert';
import 'dart:io';
import 'package:cupidknot/views/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cupidknot/models/users_model.dart';
import 'package:http/http.dart' as http;

// Map<String, String> get requestHeaders => {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization':
//           'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiZTliZDM1YTMyNWQ4ZjMxNGNjMjY3NThlYjdiMTJiZTE2MTUxNWI5NGRkMzhhYmI5Yzg3NzYzMTllYWRlNzk3OGFjZTI4ODg0OWRmZmY5ZjkiLCJpYXQiOjE2Mzc1ODcyMzIsIm5iZiI6MTYzNzU4NzIzMiwiZXhwIjoxNjM3NjczNjMyLCJzdWIiOiI3MyIsInNjb3BlcyI6W119.sImGDeF2pRcmp5Qlx_KBlVER4B9Uc-ah87LF6-5FFtkvssAi1CLycWQNSZhJ23gYQGozGsvI-1eETu7-cpYeRfSlW15EtUU18AN_gb0URgtsOPXKJBMcsjvmxesIkttFo33_uRMWpmwRSv_eLUoz1JO3RWt9vZT006qI-Zi33OLWgVjuNVXCTdVsYg6OTz1qbwTX0nvEgEsBOOM__-HcfCRqMOR5NnWWxHOWnc_TqBpwRVTaQriMTG_hgFPKhaBju_knbewhqPUy7c8wdFBjqFahfDvPXFPOjBpOXMSDx6gZNUQXGBFh6iRLvWnjGBPE77L5kkmysFEoOvOs0KUyKf0JEaa_5rR6NAjxHw5vEPGn974THhoAnjOp3BQAn8bJuNklbgqrs8Um3ypDfB5NuY3-tl5neF5faRRESc5bqEYv5o89xx9td_dzDWfMwwycV_tAtvhC0lGT0txVyoCNreVEosPYzUto8W_7QvYKzq0s0ka9ULN0ZNKwB23jupepY9_wiM9fF5PhWerhisxazrY2o6qg7I0KxcOZbvimZeTLSE41OvISqQ8vi_tNnuO0VNU9t2uSeG4MjgMwIVZqbMvu5QXqqMi0O0noCHLBUXobPWkuTg0nlmbnnqcGRtsoo1JSOp_9zgUtajmcYM7XBLgH_H9xouTdvSrGv94W5fs',
//     };
Future<List<UsersModel>>? fetchUsers(String accessToken) async {
  final String apiUrl = 'https://cupidknot.kuldip.dev/api/users';
  final response = await http.get(Uri.parse(apiUrl), headers: {
    HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json'
  });
  if (response.statusCode == 200) {
    List responseString = jsonDecode(response.body)["data"]["data"];
    List<UsersModel> usersModel =
        responseString.map((item) => UsersModel.fromJson(item)).toList();
    return usersModel;
  } else {
    throw {};
  }
}

class UsersScreen extends StatelessWidget {
  final String accessToken;
  const UsersScreen({Key? key, required this.accessToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      drawer: NavDrawer(),
      body: FutureBuilder<List<UsersModel>>(
        future: fetchUsers(accessToken),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('${snapshot.error}');
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 0.0,
                                offset: Offset(5.0, 5.0),
                              )
                            ]),
                        child: Column(
                          children: [
                            snapshot.data![index].userImages!.length == 0
                                ? Icon(
                                    Icons.person,
                                    size: 200,
                                  )
                                : Image.network(
                                    snapshot.data![index].userImages![0].path! +
                                        snapshot
                                            .data![index].userImages![0].name!,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].name!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text('Gender :' +
                                        (snapshot.data![index].gender == null
                                            ? 'Not Specified'
                                            : snapshot.data![index].gender!)),
                                    Text('Born on: ' +
                                        (snapshot.data![index].birthDate == null
                                            ? 'Not Specified'
                                            : snapshot.data![index].birthDate!
                                                .toString())),
                                    Text('Religion :' +
                                        (snapshot.data![index].religion == null
                                            ? 'Not Specified'
                                            : snapshot.data![index].religion!))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserDetailScreen(
                                      images: snapshot.data![index].userImages,
                                      firstName:
                                          snapshot.data![index].firstName,
                                      lastName: snapshot.data![index].lastName,
                                      email: snapshot.data![index].email,
                                      religion: snapshot.data![index].religion,
                                      gender: snapshot.data![index].gender,
                                      birthDate: snapshot.data![index].birthDate
                                          .toString(),
                                    )));
                      },
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<UsersModel>? fetchUser() async {
  final String apiUrl = 'https://cupidknot.kuldip.dev/api/user';
  final response = await http.get(Uri.parse(apiUrl), headers: {
    HttpHeaders.authorizationHeader:
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiZjJmNDlkYjkxY2JjMjQyOTRkYzg4NTQ3MWY0MjMxMWNjOTI2ODEzMGU2NzE0YjUyY2Y2NWIxMDg3NTRlNTBkMWRhMmU2NDhjZTkyYTJlOWUiLCJpYXQiOjE2Mzc3NTM0OTIsIm5iZiI6MTYzNzc1MzQ5MiwiZXhwIjoxNjM3ODM5ODkyLCJzdWIiOiI3MyIsInNjb3BlcyI6W119.oj0oIC-NCqJH7tFmxbmnl4PazKiLdQFzBvVWwjgVL-KzXCB4CRR4A7MW5aZT9I6iL_JaBibTaeswsMrSOZE6ZxJk0duBu2bfanP6wvyOkyZ67eH99amSthkfGvCgytvvcb9XtrZje85QLqWcK71f8sVHiiJ4EcCyOk6ug9etuOJi1772KxB9p-P0Wloy47m_Qz27BetfE-hAqR5_sLwoRPP26VpDwVq0bsxOjFDa6SMLBbeLSazjOClqQB3jPR-TydRoHS6YMMJyw-3RSpOYzef4yw5ueXXqmhJyGTPzh8wBfK-KG46XyqGiYqiY7NUVz54-cG73VPqAhYLxlPN0lAE1GsANXAMJMC1ijCSutNVq0XXmu_9SoTCW2TsOPF6uEBkPHCasA1fvfXdRVzY89Aw6dDB4zuQyVvkr0wDbk8ccBmjhuDyN4onHUEJtpPkbNrPNbWGnTmcZe0rSlJrAWNPHQ8_7FN1sbef68ySiGMccPisyTYSkq3PiNfpXPwHVbMLPyixOBcJ93JYuQxGlZSIr6mVfBTC6YmaZg0AzMev44jIIxetL3XJ9CfLLCJvUOGZZmsAFnoaSFnjXnlGDjltKpomIHVYotVM4twkODztv1oiCkjU3lrIEgKV9ErpyC-jrwL6T-MFYkG4DOdHVfHE8SzTJNiyRJofq0hUjZ4Y',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json'
  });
  if (response.statusCode == 200) {
    var responseString = jsonDecode(response.body);
    UsersModel user = UsersModel.fromJson(responseString);
    return user;
  } else {
    throw {};
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<UsersModel>(
        future: fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('${snapshot.error}');
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(snapshot.data!.name == null
                      ? 'null'
                      : snapshot.data!.name!),
                  Text(snapshot.data!.email == null
                      ? 'null'
                      : snapshot.data!.email!),
                  Text(snapshot.data!.firstName == null
                      ? 'null'
                      : snapshot.data!.firstName!),
                  Text(snapshot.data!.lastName == null
                      ? 'null'
                      : snapshot.data!.lastName!),
                  Text(snapshot.data!.religion == null
                      ? 'null'
                      : snapshot.data!.religion!),
                  Text(snapshot.data!.birthDate == null
                      ? 'null'
                      : snapshot.data!.birthDate.toString()),
                  Text(snapshot.data!.gender == null
                      ? 'null'
                      : snapshot.data!.gender!),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
