# Local Data Analysis of System Logs

This repository contains a complete data engineering workflow designed to extract, process, visualize, and automate the analysis of local system logs. This project fulfills the requirements for **Assignment I: Local Data Analysis of System Logs**.

## 📌 Project Architecture & Workflow

The pipeline is built specifically for a Windows environment, focusing on Event Viewer logs. It is divided into four main technical phases:

### 1. Data Extraction 
The system utilizes a Python script (`log_analyzer.py`) that leverages the `subprocess` module to interface directly with Windows PowerShell. 
* It queries the `System` and `Security` event logs using the `Get-WinEvent` cmdlet.
* To ensure performance and prevent memory overload on highly active machines, the query is optimized to fetch the most recent events.
* It specifically targets key information: **Login attempts** (Event IDs 4624 for success and 4625 for failure), **Errors**, and their respective **Timestamps**.
* The raw data is temporarily exported to a UTF-8 encoded CSV file.

### 2. Data Processing
Once extracted, the raw data is ingested using the **pandas** library.
* **Cleaning:** Timestamps are parsed into structured datetime objects (`pd.to_datetime`) for accurate chronological sorting. Missing values in event levels are handled and standardized.
* **Structuring:** The data is filtered and grouped into meaningful categories (Errors/Warnings, Login Events, and General Information) to prepare it for visual representation.

### 3. Data Visualization
Using **matplotlib**, the script generates three distinct analytical visualizations:
* **Bar Chart:** Displays the frequency of critical events, errors, and warnings to quickly identify system stability issues.
* **Time Series:** Tracks login activity over time, grouped by hour, to highlight traffic spikes or potential brute-force anomalies.
* **Pie Chart:** Shows the overall distribution of event types to provide a macro-level view of system behavior.

### 4. Output Generation & Automation
* **Reporting:** The script dynamically generates an HTML dashboard (`report.html`) that embeds the visualizations for easy stakeholder review.
* **Automation:** To support periodic execution (e.g., weekly log analysis), a dedicated PowerShell script (`setup_automation.ps1`) is provided. It automatically registers a task in the Windows Task Scheduler to run the Python analysis every Monday at 9:00 AM.

## 🛠️ Prerequisites & Installation

To run this project locally, you need:
- Windows OS (Required for Event Viewer access)
- Python 3.x
- Required Python data libraries:

```bash
pip install pandas matplotlib
