List<String> cities = [
  "",
"Nha Trang",
"Cam Ranh",
"Ninh Hòa",
"Đầm Môn",
"Vạn Ninh",
"Cam Lâm",
"Khánh Vĩnh",
"Diên Khánh",
"Khánh Sơn",
"Trường Sa"
];

class MyFilter
{
  static final MyFilter _filter = MyFilter._internal();
  String? city, search;
  int? stars;

  factory MyFilter()
  {
    return _filter;
  }

  factory MyFilter.setSearch({required String search})
  {
    _filter.search = search;
    return _filter;
  }

  factory MyFilter.setCity({required String city})
  {
    _filter.city = city;
    return _filter;
  }

  MyFilter._internal();
}