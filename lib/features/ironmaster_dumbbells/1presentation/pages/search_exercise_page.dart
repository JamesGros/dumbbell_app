// lib/search_exercise_page.dart
import 'dart:async';
import 'dart:convert';
import 'package:dumbbell_app/features/ironmaster_dumbbells/1presentation/pages/exercise_details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class SearchExercisePage extends StatefulWidget {
  const SearchExercisePage({Key? key}) : super(key: key);

  @override
  _SearchExercisePageState createState() => _SearchExercisePageState();
}

class _SearchExercisePageState extends State<SearchExercisePage> {
  List<dynamic> exercises = [];
  String searchQuery = '';
  bool isLoading = false;
  String? errorMessage; // To display error messages in the UI

  final _searchTextController = TextEditingController();
  final _textChanges = PublishSubject<String>();
  StreamSubscription<String>? _textChangesSubscription;

  @override
  void initState() {
    super.initState();
    _textChangesSubscription = _textChanges.stream
        .debounceTime(const Duration(milliseconds: 300))
        .listen((query) {
      if (query.isNotEmpty) {
        searchExercises(query);
      } else {
        setState(() {
          exercises = [];
        });
      }
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _textChanges.close();
    _textChangesSubscription?.cancel();
    super.dispose();
  }

  Future<void> searchExercises(String query) async {
    setState(() {
      isLoading = true;
      searchQuery = query;
      errorMessage = null; // Clear any previous error message
    });

    final apiKey =
        'fef8e49b66msh68a1bad8b411ca4p152abejsnf842b8ff9afc'; // Replace with your actua key
    // 'ab644ee9b7mshed7662cd12c6ac5p19aca1jsn0bc07dda31ae'; // Replace with your actual API key
    final apiUrl =
        'https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises?name=$query'; // Use String instead of Uri
    // 'https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises?muscle=$query'; // Use String instead of Uri
    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'exercises-by-api-ninjas.p.rapidapi.com'
    };

    try {
      final data = await makeApiRequest(apiUrl, headers);

      if (data != null) {
        setState(() {
          exercises = data;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch exercises. Please try again later.';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        errorMessage = 'An unexpected error occurred.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Exponential backoff function (separate from the class for clarity)
  Future<dynamic> makeApiRequest(String url, Map<String, String> headers,
      {int retryCount = 0}) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 429) {
        // Too Many Requests
        final delay = (retryCount + 1) * 2; // Exponential backoff (seconds)
        print('Rate limit exceeded. Retrying in $delay seconds...');
        await Future.delayed(Duration(seconds: delay));
        return makeApiRequest(url, headers,
            retryCount: retryCount + 1); // Recursive call
      } else {
        print('API Error: ${response.statusCode}');
        return null; // Or throw an exception
      }
    } catch (e) {
      print('Error: $e');
      return null; // Or throw an exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Search Exercise',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                hintText: 'Enter exercise name',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (text) {
                _textChanges.add(text);
              },
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return Card(
                      child: ListTile(
                        title: Text(exercise['name'] ?? 'Unknown Name'),
                        subtitle: Text(
                            'Type: ${exercise['type'] ?? 'Unknown'}, Difficulty: ${exercise['difficulty'] ?? 'Unknown'}'),
                        onTap: () {
                          // Navigate to the ExerciseDetailsPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ExerciseDetailsPage(exercise: exercise),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: exercises.length,
            //     itemBuilder: (context, index) {
            //       final exercise = exercises[index];
            //       return Card(
            //         child: ListTile(
            //           title: Text(exercise['name'] ?? 'Unknown Name'),
            //           subtitle: Text(
            //               'Type: ${exercise['type'] ?? 'Unknown'}, Difficulty: ${exercise['difficulty'] ?? 'Unknown'}'), // Adjust fields as needed
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// // lib/search_exercise_page.dart
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'dart:async';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// class SearchExercisePage extends StatefulWidget {
//   const SearchExercisePage({Key? key}) : super(key: key);

//   @override
//   _SearchExercisePageState createState() => _SearchExercisePageState();
// }

// class _SearchExercisePageState extends State<SearchExercisePage> {
//   List<dynamic> exercises = [];
//   String searchQuery = '';
//   bool isLoading = false;

//   Future<void> searchExercises(String query) async {
//     setState(() {
//       isLoading = true;
//       searchQuery = query;
//     });

//     final apiKey =
//         'ab644ee9b7mshed7662cd12c6ac5p19aca1jsn0bc07dda31ae'; // Replace with your actual API key
//     final apiUrl = Uri.parse(
//         'https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises?name=$query'); // Replace the domain if needed

//     try {
//       final response = await http.get(
//         apiUrl,
//         headers: {'X-Api-Key': apiKey},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         setState(() {
//           exercises = data;
//         });
//       } else {
//         print('API Error: ${response.statusCode}');
//         // Handle the error appropriately (e.g., show an error message)
//       }
//     } catch (e) {
//       print('Error: $e');
//       // Handle network errors, etc.
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<dynamic> makeApiRequest(String url, Map<String, String> headers,
//       {int retryCount = 0}) async {
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else if (response.statusCode == 429) {
//         // Too Many Requests
//         final delay = (retryCount + 1) * 2; // Exponential backoff (seconds)
//         print('Rate limit exceeded. Retrying in $delay seconds...');
//         await Future.delayed(Duration(seconds: delay));
//         return makeApiRequest(url, headers,
//             retryCount: retryCount + 1); // Recursive call
//       } else {
//         print('API Error: ${response.statusCode}');
//         return null; // Or throw an exception
//       }
//     } catch (e) {
//       print('Error: $e');
//       return null; // Or throw an exception
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Exercise'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const Text(
//               'Search Exercise',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Enter exercise name',
//                 border: const OutlineInputBorder(),
//                 prefixIcon: const Icon(Icons.search),
//               ),
//               onChanged: (text) {
//                 // You could debounce this to avoid excessive API calls
//                 if (text.isNotEmpty) {
//                   searchExercises(text);
//                 } else {
//                   setState(() {
//                     exercises =
//                         []; // Clear the list when the search query is empty
//                   });
//                 }
//               },
//             ),
//             const SizedBox(height: 20),
//             if (isLoading)
//               const CircularProgressIndicator()
//             else
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: exercises.length,
//                   itemBuilder: (context, index) {
//                     final exercise = exercises[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(exercise['name'] ?? 'Unknown Name'),
//                         subtitle: Text(
//                             'Type: ${exercise['type'] ?? 'Unknown'}, Difficulty: ${exercise['difficulty'] ?? 'Unknown'}'), // Adjust fields as needed
//                       ),
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // // lib/search_exercise_page.dart
// // import 'package:flutter/material.dart';

// // class SearchExercisePage extends StatelessWidget {
// //   const SearchExercisePage({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Search Exercise'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: Column(
// //           children: [
// //             const Text(
// //               'Search Exercise',
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 20),
// //             TextField(
// //               decoration: InputDecoration(
// //                 hintText: 'Enter exercise name',
// //                 border: OutlineInputBorder(),
// //                 prefixIcon: const Icon(Icons.search),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
