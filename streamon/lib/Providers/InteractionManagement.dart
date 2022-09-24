import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:streamon/Entities/AdminStats.dart';
import 'package:streamon/Entities/LiveVideoObject.dart';
import 'package:streamon/data.dart';

import '../Entities/VideoObject.dart';

class InteractionManagement with ChangeNotifier, DiagnosticableTreeMixin {
  Set<String> likes = {};
  Set<String> bookmarks = {};

  List<VideoObject> videoObjects = [];
  List<LiveVideoObject> liveVideoObjects = [];

  Future<AdminStats> getAdminStats(String videoID) async {
    QuerySnapshot<Map<String, dynamic>> likeData = await FirebaseFirestore
        .instance
        .collection('userLike')
        .where('video_id', isEqualTo: videoID)
        .get();
    QuerySnapshot<Map<String, dynamic>> bookmarkData = await FirebaseFirestore
        .instance
        .collection('userBookmark')
        .where('video_id', isEqualTo: videoID)
        .get();
    QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('streams')
        .where('id', isEqualTo: videoID)
        .get();
    int view = userData.docs.first.data()["views"];
    int likes = likeData.docs.length;
    int bookmarks = bookmarkData.docs.length;
    int streaming = 0;
    return AdminStats(likes, bookmarks, streaming, view);
  }

  getLiveVideos() async {
    QuerySnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance.collection('live').get();
    liveVideoObjects = userData.docs
        .where((element) => element
            .data()["started"]
            .toDate()
            .add(Duration(hours: element.data()["length"]))
            .isAfter(DateTime.now()))
        .toList()
        .map((e) {
      return LiveVideoObject(
        e.data()["name"],
        e.data()["viewers"],
        e.data()["url"],
        e.data()["started"].toDate(),
        e.id,
      );
    }).toList();
    notifyListeners();
  }

  addStreamer(String streamID) async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance.collection('live').doc(streamID).get();
    if (userData.data() != null) {
      var view = userData.data()!["viewers"];
      print(view);
      await FirebaseFirestore.instance
          .collection('streams')
          .doc(userData.id)
          .update({
        "viewers": view + 1,
      });
    }
  }

  removeStreamer(String streamID) async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance.collection('live').doc(streamID).get();
    if (userData.data() != null) {
      var view = userData.data()!["viewers"];
      print(view);
      await FirebaseFirestore.instance
          .collection('streams')
          .doc(userData.id)
          .update({
        "viewers": view - 1,
      });
    }
  }

  getVideos() async {
    QuerySnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance.collection('streams').get();
    videoObjects = userData.docs.map((e) {
      return VideoObject(
        e.data()["name"].toString(),
        e.data()["id"].toString(),
        e.data()["url"].toString(),
        e.data()["views"],
      );
    }).toList();
    notifyListeners();
  }

  addViewer(String videoID) async {
    QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('streams')
        .where('id', isEqualTo: videoID)
        .get();
    var view = userData.docs.first.data()["views"];
    await FirebaseFirestore.instance
        .collection('streams')
        .doc(userData.docs.first.id)
        .update({
      "views": view + 1,
    });
  }

  getLikes() async {
    QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('userLike')
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    likes = userData.docs.map((e) => e.data()["video_id"].toString()).toSet();
    notifyListeners();
  }

  like(String videoID) async {
    if (likes.contains(videoID)) {
      await unlike(videoID);
    } else {
      await FirebaseFirestore.instance.collection('userLike').add({
        "user_id": FirebaseAuth.instance.currentUser?.uid,
        "video_id": videoID
      });
    }
    await getLikes();
  }

  unlike(String videoID) async {
    QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('userLike')
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('video_id', isEqualTo: videoID)
        .get();
    for (var element in userData.docs) {
      await FirebaseFirestore.instance
          .collection('userLike')
          .doc(element.id)
          .delete();
    }
    getLikes();
  }

  getBookmarks() async {
    QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('userBookmark')
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    bookmarks =
        userData.docs.map((e) => e.data()["video_id"].toString()).toSet();
    notifyListeners();
  }

  bookmark(String videoID) async {
    if (bookmarks.contains(videoID)) {
      await unBookmark(videoID);
    } else {
      await FirebaseFirestore.instance.collection('userBookmark').add({
        "user_id": FirebaseAuth.instance.currentUser?.uid,
        "video_id": videoID
      });
    }
    getBookmarks();
  }

  unBookmark(String videoID) async {
    QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('userBookmark')
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('video_id', isEqualTo: videoID)
        .get();
    for (var element in userData.docs) {
      await FirebaseFirestore.instance
          .collection('userBookmark')
          .doc(element.id)
          .delete();
    }
    getBookmarks();
  }

// setVideos() async {
//   var a = await FirebaseFirestore.instance.collection('streams').get();
//   for (var element in a.docs) {
//     await FirebaseFirestore.instance
//         .collection('streams')
//         .doc(element.id)
//         .delete();
//   }
//   for (var element in videos) {
//     await FirebaseFirestore.instance.collection('streams').add({
//       "name": element.name,
//       "id": element.id,
//       "url": element.url,
//       "views": 0,
//       "is_streaming": false,
//       "streaming": 0
//     });
//   }
// }
}
