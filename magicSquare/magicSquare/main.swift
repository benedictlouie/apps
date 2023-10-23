//
//  main.swift
//  magicSquare
//
//  Created by Ben Lou on 11/12/2017.
//  Copyright © 2017 Ben Lou. All rights reserved.
//
let source = "https://www.wikihow.com/Solve-a-Magic-Square"

import Foundation

let n = Int(readLine()!)!
var arr = [Int]()

print("Sum = \(n*n*(n*n+1)/2/n)")
if n == 1 {
    print(1)
}
else if n < 3 {
   print("Magic Square cannot be formed.")
} else if n%2 != 0 {
    
    print("Odd-numbered Magic Square")
    for _ in 1...n*n { arr += [0] }
    var b = n/2
    arr[b] = 1
    for i in 2...n*n {
        if b >= 0 && b < n-1 { b += n*n-n+1 }
        else if b == n-1 { b += n }
        else if (b+1)%n == 0 { b -= n*2-1 }
        else if arr[b-n+1] != 0 { b += n }
        else { b -= n-1 }
        arr[b] = i
    }
    
} else if n%4 != 0 {
    
    var qa = [Int](), qc = [Int](), qd = [Int](), qb = [Int]()
    let size = n/2
    for _ in 1...size*size { qa += [0] }
    var b = size/2
    qa[b] = 1
    for i in 2...size*size {
        if b >= 0 && b < size-1 { b += size*size-size+1 }
        else if b == size-1 { b += size }
        else if (b+1)%size == 0 { b -= size*2-1 }
        else if qa[b-size+1] != 0 { b += size }
        else { b -= size-1 }
        qa[b] = i
    }
    for i in qa { qb += [i+size*size] }
    for i in qb { qc += [i+size*size] }
    for i in qc { qd += [i+size*size] }
    for i in 0..<size {
        for j in 1...(n-2)/4 {
            if i == size/2 { swap(&qa[i*size+j], &qd[i*size+j]) }
            else { swap(&qa[i*size+j-1], &qd[i*size+j-1]) }
        }
    }
    if n > 6 {
        for i in 0..<size {
            for j in 1...(n-2)/4-1 {
                swap(&qc[(size-j)+size*i], &qb[(size-j)+size*i])
            }
        }
    }
    for i in 0..<size { for k in [qa, qc] {
        for j in 1...size { arr += [k[i*size+j-1]] }
    } }
    for i in 0..<size { for k in [qd, qb] {
        for j in 1...size { arr += [k[i*size+j-1]] }
    } }
    print("Singly Even Magic Square")
    
} else {
    
    for i in 1...n*n {
        if i > 1 && i < n { arr += [n*n+1-i] }
        else if i > n*n-n+1 && i < n*n { arr += [n*n+1-i] }
        else if i%n == 1 && i != 1 && i != n*n-n+1 { arr += [n*n+1-i] }
        else if i%n == 0 && i != n && i != n*n { arr += [n*n+1-i] }
        else { arr += [i] }
    }
    print("Doubly Even Magic Square")
    
}
if arr.count != 0 {
    for i in 0..<n {
        var o = ""
        for j in 1...n {
            o += "\t\(arr[i*n+j-1])"
        }
        o.removeFirst()
        print(o)
    }
}
