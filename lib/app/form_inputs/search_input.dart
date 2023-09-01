import 'package:formz/formz.dart';

enum SearchInputError { empty }

class SearchInput extends FormzInput<String, SearchInputError> {
  const SearchInput.pure() : super.pure('');

  const SearchInput.dirty([String value = '']) : super.dirty(value);

  @override
  SearchInputError? validator(String value) {
    return value.isEmpty ? SearchInputError.empty : null;
  }
}
