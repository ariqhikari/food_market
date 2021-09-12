part of 'models.dart';

enum TransactionStatus { delivered, on_delivery, pending, paid, cancelled }

class Transaction extends Equatable {
  final int id;
  final String code;
  final User user;
  final Food food;
  final int quantity;
  final int total;
  final DateTime dateTime;
  final TransactionStatus status;
  final String paymentURL;

  Transaction(
      {this.id,
      this.code,
      this.user,
      this.food,
      this.quantity,
      this.total,
      this.dateTime,
      this.status,
      this.paymentURL});

  factory Transaction.fromJson(Map<String, dynamic> data) => Transaction(
        id: data['id'],
        code: data['code'],
        user: User.fromJson(data['user']),
        food: Food.fromJson(data['food']),
        quantity: int.parse(data['quantity']),
        total: int.parse(data['total']),
        dateTime: DateTime.fromMillisecondsSinceEpoch(data['created_at']),
        paymentURL: data['payment_url'],
        status: (data['status'] == 'PENDING')
            ? TransactionStatus.pending
            : (data['status'] == 'PAID')
                ? TransactionStatus.paid
                : (data['status'] == 'DELIVERED')
                    ? TransactionStatus.delivered
                    : (data['status'] == 'CANCELLED')
                        ? TransactionStatus.cancelled
                        : TransactionStatus.on_delivery,
      );

  Transaction copyWith({
    int id,
    String code,
    User user,
    Food food,
    int quantity,
    int total,
    DateTime dateTime,
    TransactionStatus status,
  }) {
    return Transaction(
      id: id ?? this.id,
      code: code ?? this.code,
      user: user ?? this.user,
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [id, code, user, food, quantity, total, total, dateTime, status];
}
