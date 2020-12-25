/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
*/

struct Trie<Element: Hashable>: Hashable {
	var isNode: Bool = false
	var children: Dictionary<Element, Trie<Element>> = [:]
}

extension Trie {
	func contains<C: Collection>(_ col: C) -> Bool where C.Element == Element {
		guard let nextElem = col.first else { return self.isNode }
		return self.children[nextElem]?.contains(col.dropFirst()) ?? false
	}
	
	mutating func insert<C: Collection>(_ value: C) where C.Element == Element {
		guard let nextElem = value.first else { self.isNode = true; return }
		
		if var existing = self.children[nextElem] {
			existing.insert(value.dropFirst())
			self.children[nextElem] = existing
		} else {
			var new = Trie(isNode: false, children: [:])
			new.insert(value.dropFirst())
			self.children[nextElem] = new
		}
	}
}
