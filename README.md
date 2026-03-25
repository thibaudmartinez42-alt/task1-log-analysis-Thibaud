# System Log Analysis Pipeline

**Author:** Thibaud Martinez
**Project:** Assignment I - Local Data Analysis of System Logs
**Branch:** `task1-thibaudmartinez42-alt`

---

## 1. Project Overview

This repository contains an automated workflow designed to extract, process, and visualize local system logs in a Windows environment. The pipeline specifically targets the Windows Event Viewer to identify system errors and monitor login attempts, outputting the results into an interactive HTML report.

## 2. Technical Architecture

The pipeline is structured into four distinct phases to ensure modularity and performance:

### 2.1. Data Extraction
- **Component:** `log_analyzer.py` (Subprocess & PowerShell)
- **Target:** Windows Event Viewer (`System` and `Security` logs).
- **Extraction Scope:** Captures the most recent 4,000 events to ensure optimal performance without overloading system memory. It specifically filters for Event IDs `4624` (Successful Logon) and `4625` (Failed Logon), alongside system warnings and errors.
- **Output:** Raw data is temporarily dumped into `windows_logs.csv` using UTF-8 encoding.

### 2.2. Data Processing
- **Component:** `pandas`
- **Operations:**
  - Parses raw timestamps into structured `datetime` objects for chronological sorting.
  - Cleans missing values and standardizes event level names.
  - Segregates data into specific subsets for error tracking and login monitoring.

### 2.3. Data Visualization
- **Component:** `matplotlib`
- **Outputs:**
  - **Error Frequency (Bar Chart):** Quantifies occurrences of 'Error', 'Warning', and 'Critical' events.
  - **Login Activity (Time Series):** Maps login attempts over time aggregated by hour.
  - **Event Distribution (Pie Chart):** Illustrates the proportion of different event types across the system.

### 2.4. Automation & Reporting
- **Reporting:** Compiles the generated PNG visualizations into a responsive `report.html` dashboard.
- **Automation:** Includes a PowerShell script (`setup_automation.ps1`) to deploy a Windows Scheduled Task, enabling periodic execution of the pipeline.

---

## 3. Installation and Prerequisites

This script must be executed on a Windows operating system.

**Required Dependencies:**
- Python 3.x
- `pandas`
- `matplotlib`

**Installation Command:**
```bash
pip install pandas matplotlib
