// to subtract the chosen date from now so it appears in days
String formatDateToDays(String date){
  try {
    DateTime taskDate=DateTime.parse(date);
    DateTime today=DateTime.now();

    // to remove time part
    taskDate = DateTime(taskDate.year, taskDate.month, taskDate.day);
    today = DateTime(today.year, today.month, today.day);
    int difference =taskDate.difference(today).inDays;
    if(difference==0) return "Today";
    if(difference==1) return "1 Day";
    if(difference==-1) return "Yesterday";
    if(difference>1) return "$difference days";
    return "${difference.abs()} days ago";

  }
  catch(e){
    return date;
  }
}

String monthAbbreviation(int month) {
  const months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  return months[month - 1];
}

String getDayName(int weekday) {
  const days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  return days[weekday - 1];
}
