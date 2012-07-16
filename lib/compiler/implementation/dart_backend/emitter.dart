// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/**
 * Dart backend helper for converting program IR back to source code.
 */
class Emitter {

  final Compiler compiler;
  final StringBuffer sb;

  Emitter(this.compiler) : sb = new StringBuffer();

  /**
   * Outputs given class element with selected inner elements.
   */
  void outputClass(ClassElement classElement, Set<Element> innerElements) {
    // TODO(smok): Very soon properly print out correct class declaration with
    // extends, implements, etc.
    sb.add(classElement.beginToken.slowToString());  // 'class' or 'interface'.
    sb.add(' ');
    sb.add(classElement.name.slowToString());
    if (classElement.isInterface() && classElement.defaultClause !== null) {
      sb.add(' default ');
      sb.add(classElement.defaultClause.unparse());
    }
    if (!classElement.interfaces.isEmpty()) {
      sb.add(' implements ');
      classElement.interfaces.printOn(sb, ',');
    }
    sb.add('{');
    innerElements.forEach((element) {
      // TODO(smok): Filter out default constructors here.
      outputElement(element);
    });
    sb.add('}');
  }

  void outputElement(Element element) {
    // TODO(smok): Figure out why AbstractFieldElement appears here,
    // we have used getters/setters resolved instead of it.
    if (element is SynthesizedConstructorElement
        || element is AbstractFieldElement) return;
    if (element.isField()) {
      // Add modifiers first.
      sb.add(element.modifiers.unparse());
      sb.add(' ');
      // Figure out type.
      if (element is VariableElement) {
        VariableListElement variables = element.variables;
        if (variables.computeType(compiler) !== null) {
          sb.add(variables.type);
          sb.add(' ');
        }
      }
      // TODO(smok): Maybe not rely on node unparsing,
      // but unparse initializer manually.
      sb.add(element.parseNode(compiler).unparse());
      sb.add(';');
    } else {
      sb.add(element.parseNode(compiler).unparse());
    }
  }

  String toString() => sb.toString();
}
