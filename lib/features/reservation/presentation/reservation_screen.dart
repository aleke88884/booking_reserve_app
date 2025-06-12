import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});
  static const String routeName = '/reservation';

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  // Состояние для забронированных слотов
  Set<String> bookedSlots = {};

  // Данные формы бронирования
  int selectedGuests = 1;
  String customerName = '';
  String customerPhone = '';
  String customerEmail = '';
  String customerComment = '';

  // Выбранный слот
  Map<String, dynamic>? selectedSlot;

  // Генерация дат на неделю вперед
  List<Map<String, dynamic>> generateDates() {
    List<Map<String, dynamic>> dates = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().add(Duration(days: i));
      dates.add({
        'date': date,
        'dayName': _getDayName(date.weekday),
        'dayNumber': date.day,
        'month': _getMonthName(date.month),
        'dateString':
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
      });
    }
    return dates;
  }

  // Генерация временных слотов
  List<String> generateTimeSlots() {
    List<String> slots = [];
    for (int hour = 9; hour <= 18; hour++) {
      slots.add('${hour.toString().padLeft(2, '0')}:00');
    }
    return slots;
  }

  // Проверка доступности слота
  bool isSlotAvailable(String dateString, String time) {
    String slotKey = '$dateString-$time';
    return !bookedSlots.contains(slotKey);
  }

  // Обработка клика по слоту
  void onSlotTap(
      String dateString, String time, Map<String, dynamic> dateInfo) {
    if (isSlotAvailable(dateString, time)) {
      setState(() {
        selectedSlot = {
          'dateString': dateString,
          'time': time,
          'dateInfo': dateInfo,
        };
      });
      _showBookingDialog();
    }
  }

  // Показать диалог бронирования
  void _showBookingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Подтверждение бронирования',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Информация о бронировании
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Дата: ${selectedSlot!['dateInfo']['dayNumber']} ${selectedSlot!['dateInfo']['month']}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Время: ${selectedSlot!['time']}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Стоимость: 3000₸/час',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.green.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Количество гостей
                    Text(
                      'Количество гостей',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: selectedGuests,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: List.generate(8, (index) => index + 1)
                          .map((int value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text(
                                    '$value ${value == 1 ? 'человек' : 'человека'}'),
                              ))
                          .toList(),
                      onChanged: (int? newValue) {
                        setDialogState(() {
                          selectedGuests = newValue ?? 1;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Имя
                    Text(
                      'Ваше имя *',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Введите ваше имя',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        customerName = value;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Телефон
                    Text(
                      'Телефон *',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: '+7 (___) ___-__-__',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        customerPhone = value;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email
                    Text(
                      'Email',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'your@email.com',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        customerEmail = value;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Комментарий
                    Text(
                      'Комментарий',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Дополнительные пожелания...',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      maxLines: 3,
                      onChanged: (value) {
                        customerComment = value;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetBookingData();
                  },
                  child: Text(
                    'Отмена',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: customerName.isNotEmpty && customerPhone.isNotEmpty
                      ? () {
                          _confirmBooking();
                          Navigator.of(context).pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Подтвердить',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Подтверждение бронирования
  void _confirmBooking() {
    String slotKey = '${selectedSlot!['dateString']}-${selectedSlot!['time']}';
    setState(() {
      bookedSlots.add(slotKey);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Бронирование успешно подтверждено!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    _resetBookingData();
  }

  // Сброс данных бронирования
  void _resetBookingData() {
    setState(() {
      selectedSlot = null;
      selectedGuests = 1;
      customerName = '';
      customerPhone = '';
      customerEmail = '';
      customerComment = '';
    });
  }

  // Получение названия дня недели
  String _getDayName(int weekday) {
    const List<String> days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return days[weekday - 1];
  }

  // Получение названия месяца
  String _getMonthName(int month) {
    const List<String> months = [
      'янв',
      'фев',
      'мар',
      'апр',
      'май',
      'июн',
      'июл',
      'авг',
      'сен',
      'окт',
      'ноя',
      'дек'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dates = generateDates();
    final List<String> timeSlots = generateTimeSlots();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Бронирование',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // Заголовок с инструкцией
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Выберите дату и время',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Зеленые ячейки - свободно, красные - занято',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Календарь бронирования
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DataTable(
                  headingRowColor:
                      MaterialStateProperty.all(Colors.grey.shade50),
                  columns: [
                    DataColumn(
                      label: Container(
                        width: 80,
                        child: Text(
                          'Время',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    ...dates
                        .map((date) => DataColumn(
                              label: Container(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      date['dayName'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                    Text(
                                      '${date['dayNumber']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      date['month'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ],
                  rows: timeSlots
                      .map((time) => DataRow(
                            cells: [
                              DataCell(
                                Container(
                                  width: 80,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    time,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ),
                              ...dates.map((date) {
                                final bool available =
                                    isSlotAvailable(date['dateString'], time);
                                return DataCell(
                                  GestureDetector(
                                    onTap: () => onSlotTap(
                                        date['dateString'], time, date),
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      decoration: BoxDecoration(
                                        color: available
                                            ? Colors.green.shade100
                                            : Colors.red.shade100,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: available
                                              ? Colors.green.shade300
                                              : Colors.red.shade300,
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          available ? 'Свободно' : 'Занято',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: available
                                                ? Colors.green.shade700
                                                : Colors.red.shade700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
