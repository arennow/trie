import XCTest
@testable import Trie

final class TrieTests: XCTestCase {
	var trie: Trie<Character>!
	
	override func setUp() {
		super.setUp()
		self.trie = .init()
	}
	
	func testInsert() {
		XCTAssertFalse(trie.contains("spoon"))
		XCTAssertFalse(trie.contains("spoons"))
		
		trie.insert("spoon")
		XCTAssertTrue(trie.contains("spoon"))
		XCTAssertFalse(trie.contains("spoons"))
		
		trie.insert("spoon")
		XCTAssertTrue(trie.contains("spoon"))
		XCTAssertFalse(trie.contains("spoons"))
		
		trie.insert("spoons")
		XCTAssertTrue(trie.contains("spoon"))
		XCTAssertTrue(trie.contains("spoons"))
	}
	
	func testRetroactiveInsert() {
		trie.insert("cartoon")
		XCTAssertFalse(trie.contains("car"))
		
		trie.insert("car")
		XCTAssertTrue(trie.contains("car"))
	}
	
	func testElementList() {
		trie.insert("cartoon")
		trie.insert("spoon")
		XCTAssertEqual(Set(trie.strings()), ["cartoon", "spoon"])
		
		trie.insert("car")
		XCTAssertEqual(Set(trie.strings()), ["cartoon", "spoon", "car"])
	}
	
	static var allTests = [
		("testInsert", testInsert),
		("testRetroactiveInsert", testRetroactiveInsert),
		("testElementList", testElementList),
	]
}
