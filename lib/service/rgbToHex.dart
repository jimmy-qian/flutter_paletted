String rgbToHex(int r, int g, int b) {
  return '#${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}';
}
