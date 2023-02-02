import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/date_provider.dart';
import '../../screens/profile/create_profile.dart';

class BirthDayPicker extends StatefulWidget {
  const BirthDayPicker({super.key, this.restorationId});

  final String? restorationId;
  @override
  State<BirthDayPicker> createState() => _BirthDayPickerState();
}

class _BirthDayPickerState extends State<BirthDayPicker>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;
  String myDate = "";

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1972),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));


      });
    }
  }
  String cebo(){
    return myDate;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
            context.read<DatePicked>().dateIt('Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}');
            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreateProfile(myDate: 'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',)));
           // CreateProfile(myDate: 'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',);
            _restorableDatePickerRouteFuture.present();
          },
          child: const Text('BirthDay',style: TextStyle(fontSize: 20,color: Colors.grey),),
        ),
        //Text('Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',style: TextStyle(fontSize: 20,color: Colors.grey),),
      ],
    );
  }
}

