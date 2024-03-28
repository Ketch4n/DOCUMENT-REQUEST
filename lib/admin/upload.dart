import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import '../api/firebase_api.dart';
import '../model/file_upload.dart';
import '../model/firebase_file.dart';
import 'package:dio/dio.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late Future<List<FirebaseFile>> futureFiles;
  late Future<ListResult> filesDownload;
  Map<int, double> downloadProgress = {};
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${Upload.filename}/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
    setState(() {
      pickedFile = null;
    });
  }

  Future bottomsheet() async {
    showAdaptiveActionSheet(
      context: context,
      title: Text('Select and Upload File'),
      androidBorderRadius: 20,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Upload ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "NexaBold"),
                ),
                Text(
                  Upload.filename,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "NexaBold"),
                ),
              ],
            ),
            onPressed: (context) {
              Navigator.of(context).pop(false);
              selectFile();
            }),
      ],
      cancelAction: CancelAction(
          title: const Text(
        'CANCEL',
        style: TextStyle(fontSize: 18, fontFamily: "NexaBold"),
      )), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  @override
  void initState() {
    super.initState();
    filesDownload =
        FirebaseStorage.instance.ref('/files/${Upload.filename}').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          bottomsheet();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(Upload.filename),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              width: double.infinity,
              height: 420,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: FutureBuilder<ListResult>(
                future: filesDownload,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // return Center(child: Text(""));
                    final files = snapshot.data!.items;
                    return ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];
                        double? progress = downloadProgress[index];
                        return ListTile(
                          title: Text(file.name),
                          subtitle: progress != null
                              ? LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.blue,
                                )
                              : null,
                          trailing: IconButton(
                            icon: Icon(
                              Icons.download,
                              color: Colors.green,
                            ),
                            onPressed: () => downloadFILE(index, file),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error"));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            if (pickedFile != null)
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),

                        child: Text(pickedFile!.name),
                        // child: Image.file(
                        //   File(pickedFile!.path!),
                        //   width: double.infinity,
                        //   fit: BoxFit.scaleDown,
                        // ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            onPressed: uploadFile, child: Text("Upload File")),
                      ),
                    ),
                  ],
                ),
              ),
            buildProgress(),
          ],
        ),
      ),
    );
  }

  // Widget buildFile(BuildContext context, Firebase file) => ListTile(
  //       title: Text("file"),
  //     );

  // Widget buildHeader(int length) => ListTile(
  //     tileColor: Colors.green,
  //     leading: Container(
  //       width: 50,
  //       height: 50,
  //     ));

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData && pickedFile != null) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                height: 50,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.green,
                    ),
                    Center(
                      child: Text(
                        '${(100 * progress).roundToDouble()}%',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox(
              height: 0,
            );
          }
        },
      );
  Future downloadFILE(int index, Reference ref) async {
    // final dir = await getApplicationDocumentsDirectory();
    // final path2 = 'files/download/${Upload.filename}/${pickedFile!.name}';

    final url = await ref.getDownloadURL();
    final tempDir = await getTemporaryDirectory();
    final path2 = '${tempDir.path}/${ref.name}';
    await Dio().download(url, path2, onReceiveProgress: (received, total) {
      double progress = received / total;

      setState(() {
        downloadProgress[index] = progress;
      });
    });

    if (url.contains('.mp4')) {
      await GallerySaver.saveVideo(path2, toDcim: true);
    } else if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path2, toDcim: true);
    } else if (url.contains('.pdf')) {
      await GallerySaver.saveImage(path2, toDcim: true);
    }

    // await ref.writeToFile(file);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded ${ref.name}')),
    );
  }
}
