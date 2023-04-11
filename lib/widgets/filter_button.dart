// ignore_for_file: prefer_const_constructors

import '../main_export.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.onTap, required this.child});
  final Function() onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: TextButton(
        onPressed: () => onTap(),
        child: child,
      ),
    );
  }
}

class FilterText extends StatelessWidget {
  const FilterText({super.key, required this.isSelected, required this.text});
  final bool isSelected;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: isSelected ? Colors.blue : Colors.transparent, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.blue)),
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
      ),
    );
  }
}
