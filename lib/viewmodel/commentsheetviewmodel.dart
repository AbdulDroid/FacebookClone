import 'package:facebook_clone/models/comment.dart';
import 'package:facebook_clone/services/dialog_service.dart';
import 'package:facebook_clone/services/firestoreservice.dart';
import 'package:facebook_clone/utils/locator.dart';
import 'package:facebook_clone/viewmodel/basemodel.dart';

class CommentBottomSheetViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  bool addBusy = false;

  List<Comment> _comments;

  List<Comment> get comments => _comments;
  String mId = "";

  Future addComment(String comment) async {
    setBusy(true);
    addBusy = true;
    var result;
    if (mId.isNotEmpty) {
      result = await _fireStoreService.addComment(Comment(
          userId == 'ing4YCI6gvRTbFtgH1HASoiFZTR2'
              ? 'Abdulrahman Abdul'
              : email,
          userId,
          comment,
          mId));
      addBusy = false;
      setBusy(false);
    } else {
      result = await _dialogService.showDialog(
          title: 'Comment Failed',
          description: 'Cannot find message to comment on');
    }

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Comment Failed',
        description: result,
      );
    }
  }

  void listenToComments(String messageId) {
    mId = messageId;
    getUserId();
    setBusy(true);
    _fireStoreService.realTimeComments(mId).listen((commentData) {
      List<Comment> freshComments = commentData;
      if (freshComments != null && freshComments.length > 0) {
        _comments = freshComments;
      }
      setBusy(false);
    });
  }
}
