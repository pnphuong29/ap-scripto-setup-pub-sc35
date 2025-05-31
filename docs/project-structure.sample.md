# Project Structure

This document outlines the structure of the Template-based Project Initializer application.

## Directory Structure

```plaintext
app/
├── cmd/
│   └── cli/
│       └── main.go                 # Command-line interface entry point
├── internal/
│   ├── config/
│   │   └── config.go               # Configuration parsing and handling
│   ├── fileops/
│   │   └── fileops.go              # File operations and processing
│   ├── progress/
│   │   └── progress.go             # Progress tracking
│   └── template/
│       └── template.go             # Template processing and variable substitution
├── pkg/
│   ├── fileutil/
│   │   └── fileutil.go             # File utility functions
│   ├── logger/
│   │   └── logger.go               # Logging utilities
│   └── pathutil/
│       └── pathutil.go             # Path utility functions
├── scripts/
│   └── build.sh                    # Build script
├── Dockerfile                      # Docker configuration
├── go.mod                          # Go module definition
└── README.md                       # Application README
```

## Component Overview

### Command Line Interface (`cmd/cli/`)

- **main.go**: Entry point for the application, handles command-line arguments and flags using Cobra

### Internal Packages (`internal/`)

- **config/config.go**:

  - Parses the YAML configuration file
  - Defines the structure for file configurations
  - Handles destination path resolution with variable substitution

- **fileops/fileops.go**:

  - Manages file operations (copy, create)
  - Controls parallel processing with semaphores
  - Implements the project processor

- **progress/progress.go**:

  - Tracks operation progress
  - Manages statistics (completed, failed, skipped)
  - Thread-safe counters for concurrent operations

- **template/template.go**:
  - Processes template files
  - Handles variable substitution
  - Uses Go's template package

### Utility Packages (`pkg/`)

- **fileutil/fileutil.go**:

  - File copying
  - Directory management
  - Script detection and permission handling

- **logger/logger.go**:

  - Multi-level logging (info, error, warning, debug)
  - Thread-safe logging operations

- **pathutil/pathutil.go**:
  - Path manipulation and normalization
  - Home directory expansion
  - Directory checks

## Flow of Execution

1. User runs the command with specified flags
2. Application parses command-line arguments
3. For each target project:
   a. Load and parse the configuration file
   b. Generate a list of file tasks
   c. Process each file in parallel (up to concurrency limit)
4. For each file task:
   a. Check if the destination file exists
   b. Apply the existence policy (skip or overwrite)
   c. Process template variables if needed
   d. Copy the file to the destination
   e. Set executable permissions if it's a script
5. Display progress summary
