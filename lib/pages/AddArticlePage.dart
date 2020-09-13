import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artickle/implementation/PictureHandler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';


class AddArticlePage extends StatefulWidget{

  @override
  State createState() => AddArticlePageState();
}

class AddArticlePageState extends State<AddArticlePage>{

      //controller untuk input data admin
      TextEditingController authorC = TextEditingController();
      TextEditingController titleC = TextEditingController();
      TextEditingController topicC = TextEditingController();
      TextEditingController contentC = TextEditingController();
      TextEditingController linkC = TextEditingController();
      File imageFile;
      final _formKey = GlobalKey<FormState>();
      DateTime now = DateTime.now();
      String formattedDate = DateTime.now().toString();

      //submit article, upload gambar ke firebase storage belum berhasil
      void submitArticle() async{
        if(imageFile == null)
          {
            Toast.show("Gagal upload gambar", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        else
          {
            await Firebase.initializeApp();
            var imageFileName =
                "gambarartikel" + DateTime.now().millisecondsSinceEpoch.toString();


            StorageUploadTask _uploadTask;
            _uploadTask = FirebaseStorage.instance.ref().child(imageFileName).putFile(imageFile);

            print('cek _uploadTask');
            //print(_uploadTask.events.data.);
            //final StorageReference firebaseStorageRef =
            //FirebaseStorage.instance.ref().child(imageFileName);
            //StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
            //StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

//            var downloadUrl = await storageSnapshot.ref.getDownloadURL();
            var urlgambar = "";
//            if (uploadTask.isComplete) {
//              urlgambar = downloadUrl.toString();
//
//            }

            if(urlgambar == ""){
              Toast.show("Gagal upload gambar", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            }
            else
            {
              FirebaseFirestore.instance.collection("artikel").doc().set({
                'pengarang': authorC.text,
                'judul': titleC.text,
                'topik': topicC.text,
                'konten': contentC.text,
                'sumber': linkC.text,
                'waktu upload': formattedDate,
                'gambar': urlgambar

              });
              authorC.text = '';
              titleC.text = '';
              topicC.text = '';
              contentC.text = '';
              linkC.text = '';
              formattedDate = '';
              urlgambar = "";
            }
          }
      }

      //popup dialog untuk mengambil gambar dari galery
      showAlertDialog(BuildContext context) {
        // buttons
        Widget cancelButton = FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        Widget galeryButton = FlatButton(
          child: Text("Gallery"),
          onPressed: () async {
            await PictureHandler.openGallery().then((value) => imageFile = value);
            if (imageFile != null) {
              setState(() {
                // do something if you want
                Toast.show("Gambar dipilih", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                print(imageFile.path);
              });
            } else {
              // give some toast here that image null because the user press back button or other error
              Toast.show("Gagal mendapatkan gambar", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            }
            Navigator.of(context).pop();
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Ambil gambar dari"),
          actions: [cancelButton, galeryButton],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }

      //State untuk gambar, akan muncul button jika image state masih null dan menampilakn gambar jika tidak null
      Widget imageState() {
        if (imageFile == null) {
          return Container(
            margin: EdgeInsets.only( top:10,),
            child: RaisedButton(
              color: Colors.grey,
              padding: EdgeInsets.all(100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.plus),
                  Text("Unggah sebuah gambar"),
                ],
              ),
              onPressed: () {
                showAlertDialog(context);
              },
            ),
          );
        } else {
          return Container(
              margin: EdgeInsets.all(2.0),
              child: Card(
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)) ) ,
                child: InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.file(
                            imageFile,
                            height: 333,
                            fit:BoxFit.fill
                        ),
                      ),
                    ],
                  ),
                ),
              )
          );
        }
      }


      @override
      Widget build(BuildContext context) {
        // TODO: implement build
        return Scaffold(
            appBar: AppBar(
              title: new Text('Tambah Artikel Baru'),
              elevation: 0.7,
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    imageState(),
                    TextFormField(
                      controller: authorC,
                      decoration: InputDecoration(
                          hintText: "Steve Rodgers",
                          labelText: "Penulis"
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Input tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: linkC,
                      decoration: InputDecoration(
                          prefix: Text('http://www.'),
                          hintText: "google.com",
                          labelText: 'link'
                      ),
                      keyboardType: TextInputType.url,
                      maxLines: null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Input tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: titleC,
                      decoration: InputDecoration(
                          hintText: "Avengers telah bersatu",
                          labelText: "Judul"
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Input tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: topicC,
                      decoration: InputDecoration(
                          hintText: "Stroke, Covid-19, dll",
                          labelText: 'Topik'
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Input tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: contentC,
                      decoration: InputDecoration(
                          hintText: "Captain amerika berhasil mengalahkan thanos",
                          labelText: 'Konten'
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Input tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            child: Text("Cancel"),
                              onPressed: () {
                                Toast.show("Tambah artikel dibatalkan", context,
                                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                Navigator.pop(context);
                              },
                        ),
                        RaisedButton(
                          child: Text("Submit"),
                          onPressed: submitArticle,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
        );
      }
    }
