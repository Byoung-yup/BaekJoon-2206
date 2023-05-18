//
//  main.swift
//  BaekJoon#2206
//
//  Created by 김병엽 on 2023/05/17.
//
// Reference: https://velog.io/@aurora_97/백준-2206번-벽-부수고-이동하기-Swift

import Foundation

struct Queue<T> {
    
    private var input: [T] = []
    private var output: [T] = []
    
    var isEmpty: Bool {
        return input.isEmpty && output.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        input.append(element)
    }
    
    mutating func dequeue() -> T {
        
        if output.isEmpty {
            output = input.reversed()
            input.removeAll()
        }
        return output.removeLast()
    }
    
}

struct Element {
    let x: Int
    let y: Int
    let wall: Int
}

func solution() -> Int {
    
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, m) = (input[0], input[1])
    
    var graph: [[Int]] = []
    
    for _ in 0..<n {
        let array = Array(readLine()!).map { Int(String($0))! }
        graph.append(array)
    }
    
    let dx = [1, -1, 0, 0]
    let dy = [0, 0, 1, -1]
    
    var visit = Array(repeating: Array(repeating: [0, 0], count: m), count: n)
    visit[0][0][0] = 1
    
    var queue = Queue<Element>()
    queue.enqueue(Element(x: 0, y: 0, wall: 0))
    
    while !queue.isEmpty {
        let cur = queue.dequeue()
        
        if cur.x == n - 1 && cur.y == m - 1 {
            return visit[cur.x][cur.y][cur.wall]
        }
        
        for i in 0..<4 {
            let nx = cur.x + dx[i]
            let ny = cur.y + dy[i]
            
            if (0..<n).contains(nx) && (0..<m).contains(ny) {
                if graph[nx][ny] == 1 && cur.wall == 0 {
                    visit[nx][ny][1] = visit[cur.x][cur.y][cur.wall] + 1
                    queue.enqueue(Element(x: nx, y: ny, wall: 1))
                } else if graph[nx][ny] == 0 && visit[nx][ny][cur.wall] == 0 {
                    visit[nx][ny][cur.wall] = visit[cur.x][cur.y][cur.wall] + 1
                    queue.enqueue(Element(x: nx, y: ny, wall: cur.wall))
                }
            }
        }
    }
    return -1
}

print(solution())


