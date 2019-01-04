extension String {
    /*usage :
         let s = "hello"
         s[0..<3] // "hel"
         s[3..<s.count] // "lo"
         s[0..<s.count-1] // "hell"
     */
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
