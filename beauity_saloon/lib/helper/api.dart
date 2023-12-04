class HttpUrl {
  static const String base = 'http://154.26.130.251:169/';

  // static const String base = 'http://154.26.130.251:302/';

  // static const String base = 'http://154.26.130.251:302/';

  // static const String base = 'https://stupefied-mirzakhani.154-26-130-251.plesk.page/';

  static String mobileCheckUrl = 'http://154.26.130.251:800';

  static const int org = 1;

  static const createCustomer = '${base}/CreateCustomer';

  static const getOrgDetalis = '${base}Organization/GetAllOrganization';

  static const loginApi = '${base}/api/Login';

  static const taxApi = '${base}/Tax/GetAll?';

  static const taxApiGetby = '${base}/Tax/Getbycode?';

  static const getPayMode = '${base}/Paymode/GetAll?';

  static const getCustomerList = '${base}/GetAllCustomers?';

  static const getCustomerListGetBy = '${base}/GetAllCustomers?';

  static String getAllCategory = '${base}Category/GetAll?';

  static String get getAllSubCategory => "$base/SubCategory/GetbyCategoryCode?";

  static String get getAllProduct =>
      "${base}/Product/GetAllWithImage?OrganizationId=${org}";

  static String get createPosInvoiceApi => "${base}/POSInvoice/Create";

  static String get getPosInvoiceDetails => "${base}/POSInvoice/Getbycode?";

  static String get getCashRegister => "${base}POSCashRegister/GetAll?";

  static String get getSettlementDetail => "${base}POSCashRegister/GetSettlementDetail?";

  static String get getTerminalName => "${base}POSCashRegister/GetAllTerminalName?";

  static String get getCashInOutDetail => "${base}POSCashRegister/GetCashInOutDetail?";

  static String get getPosSettlementHeaderSearch => "${base}POSSettlement/GetHeaderSearch?";

  static String get createPosSettlement => "${base}POSSettlement/Create";

  static String get getSupplierList => "${base}GetAllSupplier?";
}
