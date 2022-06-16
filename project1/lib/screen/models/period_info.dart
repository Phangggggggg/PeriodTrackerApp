class PeriodInfo {
  DateTime date;
  int numDayInCycle;
  int cycleNum;
  int numDay;
  bool hasPeriod;
  bool isFertile;
  bool isFirstDay;
  bool isLastDay;

  PeriodInfo(
      {this.date,
      this.numDayInCycle,
      this.cycleNum,
      this.hasPeriod,
      this.isFertile,
      this.isFirstDay,
      this.isLastDay,
      this.numDay});
}
