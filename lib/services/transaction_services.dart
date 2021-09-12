part of 'services.dart';

class TransactionServices {
  static Future<ApiReturnValue<List<Transaction>>> getTransactions(
      {http.Client client}) async {
    client ??= http.Client();

    String url = baseURL + '/api/transaction?limit=1000';

    var response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${User.token}'
      },
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    var data = jsonDecode(response.body);

    List<Transaction> transactions = (data['data']['data'] as Iterable)
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();

    return ApiReturnValue(value: transactions);
  }

  static Future<ApiReturnValue<Transaction>> changeStatusTransaction(
      Transaction transaction,
      {http.Client client}) async {
    client ??= http.Client();

    String url = baseURL + '/api/transaction/${transaction.id}';

    var response = await client.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${User.token}'
      },
      body: jsonEncode(<String, dynamic>{
        'status': (transaction.status == TransactionStatus.pending)
            ? 'PENDING'
            : (transaction.status == TransactionStatus.delivered)
                ? 'DELIVERED'
                : (transaction.status == TransactionStatus.cancelled)
                    ? 'CANCELLED'
                    : 'ON_DELIVERY',
      }),
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    return ApiReturnValue(value: transaction);
  }

  static Future<ApiReturnValue<Transaction>> submitTransaction(
      Transaction transaction,
      {http.Client client}) async {
    client ??= http.Client();

    String url = baseURL + '/api/checkout';

    var response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${User.token}'
      },
      body: jsonEncode(<String, dynamic>{
        'food_id': transaction.food.id,
        'user_id': transaction.user.id,
        'quantity': transaction.quantity,
        'total': transaction.total,
        'status': 'PENDING',
      }),
    );

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    var data = jsonDecode(response.body);

    Transaction value = Transaction.fromJson(data['data']);

    return ApiReturnValue(value: value);
  }
}
