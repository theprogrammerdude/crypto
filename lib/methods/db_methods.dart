import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_plus/models/market_model.dart';
import 'package:crypto_plus/models/trade_model.dart';
import 'package:crypto_plus/models/user_model.dart';
import 'package:uuid/uuid.dart';

class DbMethods {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var uuid = const Uuid();

  addUser(String firstName, String lastName, String email, String uid,
      String phone, String username) {
    return _db.doc('users/$uid').set({
      'firstName': firstName,
      'lastName': lastName,
      'uid': uid,
      'email': email,
      'username': username,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'amount': 100000000,
      'netCommission': 0,
      'commission': .02,
      'phone': phone.trim()
    });
  }

  Stream<DocumentSnapshot> getUserData(String uid) {
    return _db.doc('users/$uid').snapshots();
  }

  Future buy(MarketModel _coinData, String uid, num coins, num amount) {
    String transactionId = uuid.v4().split('-').join();

    return _db.doc('users/$uid').collection('trades').doc(transactionId).set({
      'baseMarket': _coinData.baseMarket,
      'quoteMarket': _coinData.quoteMarket,
      'buy': num.parse(_coinData.sell),
      'sell': num.parse(_coinData.buy),
      'high': num.parse(_coinData.high),
      'low': num.parse(_coinData.low),
      'coins': coins,
      'volume': num.parse(_coinData.volume),
      'at': DateTime.now().millisecondsSinceEpoch,
      'uid': uid,
      'transactionId': transactionId,
      'trade': 'buy',
      'amount': amount
    });
  }

  Future sell(MarketModel _coinData, String uid, num coins, num amount) {
    String transactionId = uuid.v4().split('-').join();

    return _db.doc('users/$uid').collection('trades').doc(transactionId).set({
      'baseMarket': _coinData.baseMarket,
      'quoteMarket': _coinData.quoteMarket,
      'buy': num.parse(_coinData.sell),
      'sell': num.parse(_coinData.buy),
      'high': num.parse(_coinData.high),
      'low': num.parse(_coinData.low),
      'coins': coins,
      'volume': num.parse(_coinData.volume),
      'at': DateTime.now().millisecondsSinceEpoch,
      'uid': uid,
      'transactionId': transactionId,
      'trade': 'sell',
      'amount': amount
    });
  }

  updateUserOnTrade(UserModel _user, num amount) {
    _db.doc('users/${_user.uid}').update({
      'amount': _user.amount - amount,
      'netCommission': _user.netCommission + (amount * _user.commission) / 100,
    });
  }

  Stream<QuerySnapshot> getAllTrades(String uid) {
    return _db
        .doc('users/$uid')
        .collection('trades')
        .orderBy('at', descending: true)
        .snapshots();
  }

  Future squareOff(TradeModel trade, MarketModel coinData, String uid,
      num coins, num amount, String type) {
    return _db.doc('users/$uid').collection('history').add({
      'baseMarket': coinData.baseMarket,
      'quoteMarket': coinData.quoteMarket,
      'buy': num.parse(coinData.sell),
      'sell': num.parse(coinData.buy),
      'high': num.parse(coinData.high),
      'low': num.parse(coinData.low),
      'prevBuy': trade.buy,
      'prevSell': trade.sell,
      'coins': coins,
      'volume': num.parse(coinData.volume),
      'at': DateTime.now().millisecondsSinceEpoch,
      'uid': uid,
      'trade': type,
      'amount': amount,
    });
  }

  Future deleteTrade(String uid, String transactionId) {
    return _db
        .doc('users/$uid')
        .collection('trades')
        .doc(transactionId)
        .delete();
  }

  updateUserOnSquareOff(UserModel _user, num amount) {
    _db.doc('users/${_user.uid}').update({
      'amount': _user.amount + amount,
      'netCommission': _user.netCommission + (amount * _user.commission) / 100,
    });
  }

  Stream<QuerySnapshot> getHistory(String uid) {
    return _db
        .doc('users/$uid')
        .collection('history')
        .orderBy('at', descending: true)
        .snapshots();
  }

  Future updateEmail(String email, String uid) {
    return _db.doc('users/$uid').update({'email': email});
  }

  Future updateName(String firstName, String lastName, String uid) {
    return _db
        .doc('users/$uid')
        .update({'firstName': firstName, 'lastName': lastName});
  }
}
