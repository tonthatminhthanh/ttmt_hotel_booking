List<String> cities = [
  "Tất cả",
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

List<String> starOptions = [
  "Tất cả",
  "1 sao",
  "2 sao",
  "3 sao",
  "4 sao",
  "5 sao"
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

  factory MyFilter.setStars({required int star})
  {
    _filter.stars = star;
    return _filter;
  }

  MyFilter._internal();
}