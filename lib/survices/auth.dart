import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waldrop/custom_widget/local.dart';

final FirebaseAuth _auth=FirebaseAuth.instance;
final GoogleSignIn googleSignIn=GoogleSignIn();

//signin function

Future<User?> signInWithGoogle()async{
  try{
   final GoogleSignInAccount? googleSignInAccount=await googleSignIn.signIn();
   final GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount!.authentication;

   final AuthCredential credential= GoogleAuthProvider.credential(
     idToken: googleSignInAuthentication.idToken,
     accessToken: googleSignInAuthentication.accessToken,
   );
   final userCredential= await _auth.signInWithCredential(credential);
   final User?user=userCredential.user;

   assert(!user!.isAnonymous);
   assert(await user!.getIdToken()!=null);

   final User? currentUser=await _auth.currentUser;
   assert(currentUser!.uid==user!.uid);
   print(user);
   LocalData.savelog(true);
   LocalData.saveName(user!.displayName.toString());
   LocalData.saveEmail(user.email.toString());
   LocalData.saveImg(user.photoURL.toString());
   return user;


  }catch(e){
    print(e);
  }
}
Future<String> signOut()async{
  LocalData.savelog(false);
  await googleSignIn.signOut();
  await _auth.signOut();
  return"great success";
}