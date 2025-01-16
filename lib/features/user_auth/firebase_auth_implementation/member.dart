class Member {
  final String id;
  String name;
  bool isActive;
  double loanAmount;
  double repaymentAmount;

  Member({
    required this.id,
    required this.name,
    this.isActive = true,
    this.loanAmount = 0.0,
    this.repaymentAmount = 0.0,
  });
}
