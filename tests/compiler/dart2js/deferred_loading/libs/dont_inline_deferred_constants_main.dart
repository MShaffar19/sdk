// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dont_inline_deferred_constants_lib1.dart' deferred as lib1;
import 'dont_inline_deferred_constants_lib2.dart' deferred as lib2;

/*strong.element: c:OutputUnit(main, {})*/
const c = "string3";

/*class: C:OutputUnit(main, {})*/
class C {
  /*element: C.p:OutputUnit(main, {})*/
  final p;

  /*strong.element: C.:OutputUnit(main, {})*/
  const C(this.p);
}

/*element: foo:OutputUnit(2, {lib1, lib2})*/
foo() => print("main");

/*strong.element: main:OutputUnit(main, {})*/
/*strongConst.element: main:
 OutputUnit(main, {}),
 constants=[
  ConstructedConstant(C(p=IntConstant(1)))=OutputUnit(main, {}),
  ConstructedConstant(C(p=IntConstant(1010)))=OutputUnit(1, {lib1}),
  ConstructedConstant(C(p=IntConstant(2)))=OutputUnit(2, {lib1, lib2}),
  ConstructedConstant(C(p=StringConstant("string1")))=OutputUnit(1, {lib1}),
  ConstructedConstant(C(p=StringConstant("string2")))=OutputUnit(1, {lib1})]
*/
void main() {
  lib1.loadLibrary().then(/*OutputUnit(main, {})*/ (_) {
    lib2.loadLibrary().then(/*OutputUnit(main, {})*/ (_) {
      lib1.foo();
      lib2.foo();
      print(lib1.C1);
      print(lib1.C1b);
      print(lib1.C2);
      print(lib1.C2b);
      print(lib1.D.C3);
      print(lib1.D.C3b);
      print(c);
      print(lib1.C4);
      print(lib2.C4);
      print(lib1.C5);
      print(lib2.C5);
      print(lib1.C6);
      print(lib2.C6);
      print("string4");
      print(const C(1));
    });
  });
}
