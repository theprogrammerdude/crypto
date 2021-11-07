import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_social/models/market_model.dart';
import 'package:crypto_social/models/user_model.dart';
import 'package:uuid/uuid.dart';

class DbMethods {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var uuid = const Uuid();

  addUser(String firstName, String lastName, String email, String uid,
      String phone) {
    return _db.doc('users/$uid').set({
      'firstName': firstName,
      'lastName': lastName,
      'uid': uid,
      'email': email,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'amount': 10000,
      'netCommission': 0,
      'commission': .002,
      'phone': phone.trim()
    });
  }

  Stream<DocumentSnapshot> getUserData(String uid) {
    return _db.doc('users/$uid').snapshots();
  }

  Future buy(MarketModel _coinData, String uid, num _coins) {
    String transactionId = uuid.v4().split('-').join();

    return _db.doc('users/$uid').collection('trades').doc(transactionId).set({
      'baseMarket': _coinData.baseMarket,
      'quoteMarket': _coinData.quoteMarket,
      'buy': _coinData.sell,
      'sell': _coinData.buy,
      'high': _coinData.high,
      'low': _coinData.low,
      'coins': _coins,
      'volume': _coinData.volume,
      'at': DateTime.now().millisecondsSinceEpoch,
      'uid': uid,
      'transactionId': transactionId,
      'trade': 'buy'
    });
  }

  Future sell(MarketModel _coinData, String uid, num _coins) {
    String transactionId = uuid.v4().split('-').join();

    return _db.doc('users/$uid').collection('trades').doc(transactionId).set({
      'baseMarket': _coinData.baseMarket,
      'quoteMarket': _coinData.quoteMarket,
      'buy': _coinData.sell,
      'sell': _coinData.buy,
      'high': _coinData.high,
      'low': _coinData.low,
      'coins': _coins,
      'volume': _coinData.volume,
      'at': DateTime.now().millisecondsSinceEpoch,
      'uid': uid,
      'transactionId': transactionId,
      'trade': 'sell'
    });
  }

  updateUserOnTrade(UserModel _user, num amount) {
    return _db.doc('users/${_user.uid}').update({
      'amount': _user.amount - amount,
      'netCommission': (amount * _user.commission) / 100,
    });
  }
}
