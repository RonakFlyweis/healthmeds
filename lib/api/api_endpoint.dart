//const String baseUrlold = 'https://secure-river-15887.herokuapp.com';

import 'api_provider.dart';

// const String baseUrl = 'https://helthmade-1234.herokuapp.com';
const String baseUrl = 'http://mern.online:2002';

const String imagebaseurlold =
    "https://secure-river-15887.herokuapp.com/public/images/";

String imagebaseurl = "${ApiProvider.baseUrl}public/images/";

// const String newimages1 = "http://mern.online:5656";

String getbannerurl = "$baseUrl/getBanner";
// String gethandpickurl ="$baseUrl/getHandPickedProduct";
String gethandpickurl = "$baseUrl/viewHandPickedItem";
String getfeaturepickurl = "$baseUrl/viewFeaturedBrand";
String getDealOfDayUrl = "$baseUrl/getDealsOfTheDayProduct";
String getotpverifyUrl = "$baseUrl/verifyOtp";
//todo need to Change url
// String categoryitemUrl = "$baseUrl/viewTopCat";
String categoryitemUrl = "$baseUrl/viewCategory";
String adduserUrl = "$baseUrl/addUser";
String addAddressurl = '$baseUrl/addAddress';
String getSingledetailurl = '$baseUrl/getProductDetail/';
String getaddcarturl = '$baseUrl/user/cart/addtocart';
String getcartitemurl = '$baseUrl/user/cart/getCartItems';
//todo need to change url
String getProductListurl = '$baseUrl/viewTopCategoryProduct/';
String getSearchProducturl = '$baseUrl/filterProduct?title=';
//String getHealthCarePDurl = '$baseUrl/viewHealthCareCat';
String getHealthCarePDurl = '$baseUrl/viewHealthCareProduct';
String getphoneNumberUrl = '$baseUrl/viewNeedHelp';
String getAllProducts = '$baseUrl/getAllProduct';
