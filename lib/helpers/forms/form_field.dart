abstract class FormzField{
  final bool isValid;

  const FormzField(this.isValid);
}

class TextFormzField extends FormzField{
  final String field;
  const TextFormzField(this.field, bool isValid) : super(isValid);
}