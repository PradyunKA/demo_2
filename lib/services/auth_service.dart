import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //sign in with google

  signInWithGoogle() async {
    //begin interactice sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth detaisl from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );


    //sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}