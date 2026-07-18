class InputValidator{

  static String? validatePhone(value){
    if(value.length<11){
      return "The phone number should have 11 digits. Eg: 94771242341";
    }
    return null;
  }

  static String? validatePassword(value){
    if(value.length<8){
      return "The password should have at-least 8 characters";
    }
    return null;
  }


}