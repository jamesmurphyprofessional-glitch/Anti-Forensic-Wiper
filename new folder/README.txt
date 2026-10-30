================================================================================
                    DATA CORRUPTOR v1.0 - Systematic Data Corruption
================================================================================

OVERVIEW:
---------
DataCorruptor is a systematic data corruption engine designed to render files
on a drive unrecoverable by rewriting file contents with random data, deleting
metadata, and renaming files to obfuscate their original locations.

FEATURES:
---------
• Random Data Overwrite: Rewrites file contents with cryptographically random
  data (0-255 byte values) to destroy original content
• Metadata Deletion: Removes original file attributes and metadata
• File Renaming: Renames corrupted files with random alphanumeric strings
  to prevent easy identification of original files
• Recursive Corruption: Processes all files in a target directory
• Memory Clearing: Clears sensitive data from memory after corruption

CORRUPTION PROCESS:
-------------------
1. Scans target directory for all files (excluding system files)
2. Generates random data buffer (default: 4KB per file)
3. Writes random data to a new file with random name
4. Deletes original file
5. Repeats for all files in directory

TARGETED FILES:
---------------
• All regular files in the target directory
• Excludes: Hidden files (.), .DS_Store, .Spotlight-V100, .fseventsd

USAGE:
------
1. Compile: swift build
2. Run: swift run DataCorruptor
3. Enter target directory path (or press Enter for current directory)

EXAMPLES:
---------
• Corrupt current directory: (press Enter)
• Corrupt specific folder: /Users/jamesmurphy/Documents

TECHNICAL DETAILS:
------------------
• Language: Swift
• Platform: macOS
• Memory: Uses secure memory clearing after each operation
• Randomization: Uses arc4random_uniform() for filename generation
• Data Generation: Uses UInt8.random() for random byte generation

WARNING:
--------
This tool is designed for data destruction. Once files are corrupted,
recovery is extremely difficult to impossible. Use with caution!

AUTHOR:
-------
DataCorruptor Team

VERSION:
--------
v1.0 - Initial Release

================================================================================
