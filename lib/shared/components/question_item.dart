import 'package:flutter/material.dart';

class QuestionsItem extends StatefulWidget {
  final String QuestionText;
  final String AnswerText1;
  final String AnswerText2;
  final String AnswerText3;

  QuestionsItem({
    required this.QuestionText,
    required this.AnswerText1,
    required this.AnswerText2,
    this.AnswerText3 = '',
  });

  @override
  State<QuestionsItem> createState() => _QuestionsItemState();
}

class _QuestionsItemState extends State<QuestionsItem> {
  int? _selectedvalue;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('${widget.QuestionText}'),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.AnswerText1}'),
                  Radio(
                      value: 0,
                      groupValue: _selectedvalue,
                      onChanged: (value) {
                        setState(() {
                          _selectedvalue = value as int?;
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.AnswerText2}'),
                  Radio(
                      value: 1,
                      groupValue: _selectedvalue,
                      onChanged: (value) {
                        setState(() {
                          _selectedvalue = value as int?;
                        });
                      }),
                ],
              ),
              if (widget.AnswerText3.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${widget.AnswerText3}'),
                    Radio(
                        value: 2,
                        groupValue: _selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            _selectedvalue = value as int?;
                          });
                        }),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}