
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<Map<String, dynamic>> signInWithGoogle() async {
  try{
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    Map<String, dynamic> userDetails = {
      "name": user.displayName,
      "email": user.email,
      "photoUrl": user.photoUrl
    };

//    assert(user.email != null);
//    assert(user.displayName != null);
//    assert(user.photoUrl != null);
//    assert(!user.isAnonymous);
//    assert(await user.getIdToken() != null);
//
//    final FirebaseUser currentUser = await _auth.currentUser();
//    assert(user.uid == currentUser.uid);

    return userDetails;
  } catch(err) {
    print(err);
  }
}

Future loggedInUser() async {
  await googleSignIn.currentUser;
}

void signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Sign Out");
}