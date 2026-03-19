import subprocess
import pandas as pd
import matplotlib.pyplot as plt
import os

def extract_logs():
    print("Extracting Windows logs (limited to the last 4000 events for speed)...")
    ps_script = """
    $sys = Get-WinEvent -LogName 'System' -MaxEvents 2000 -ErrorAction SilentlyContinue
    $sec = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624,4625} -MaxEvents 2000 -ErrorAction SilentlyContinue
    $events = $sys + $sec
    $events | Select-Object TimeCreated, Id, LevelDisplayName, ProviderName | Export-Csv -Path 'windows_logs.csv' -NoTypeInformation -Encoding UTF8
    """
    subprocess.run(["powershell", "-Command", ps_script], capture_output=True)

def process_and_visualize_logs():
    print("Processing data with pandas and creating visualizations...")
    df = pd.read_csv('windows_logs.csv')
    
    # Setting dayfirst=True removes the warning you saw earlier
    df['TimeCreated'] = pd.to_datetime(df['TimeCreated'], errors='coerce', dayfirst=True)
    df.dropna(subset=['TimeCreated'], inplace=True)
    df['LevelDisplayName'] = df['LevelDisplayName'].fillna('Information')
    
    if not os.path.exists('screenshots'):
        os.makedirs('screenshots')

    # 1. Bar chart (Error frequency) - Searching for both EN and FR terms
    plt.figure(figsize=(10, 6))
    error_terms = ['Error', 'Erreur', 'Warning', 'Avertissement', 'Critical', 'Critique']
    errors_df = df[df['LevelDisplayName'].isin(error_terms)]
    
    if not errors_df.empty:
        errors_df['LevelDisplayName'].value_counts().plot(kind='bar', color=['red', 'orange', 'darkred'])
    else:
        plt.text(0.5, 0.5, 'No errors or warnings found in recent logs', ha='center', va='center', fontsize=12)
        plt.axis('off')
        
    plt.title('Error and Warning Frequency')
    plt.tight_layout()
    plt.savefig('screenshots/bar_chart_errors.png')
    plt.close()

    # 2. Time series (Login activity)
    plt.figure(figsize=(12, 6))
    logins_df = df[df['Id'].isin([4624, 4625])].copy()
    if not logins_df.empty:
        logins_df.set_index('TimeCreated', inplace=True)
        logins_df.resample('h').size().plot(kind='line', marker='o', color='blue')
    else:
        plt.text(0.5, 0.5, 'No login events found', ha='center', va='center')
        plt.axis('off')
        
    plt.title('Login Activity Over Time (Hourly)')
    plt.tight_layout()
    plt.savefig('screenshots/time_series_logins.png')
    plt.close()

    # 3. Pie chart (Event distribution)
    plt.figure(figsize=(8, 8))
    df['LevelDisplayName'].value_counts().plot(kind='pie', autopct='%1.1f%%', cmap='Set3')
    plt.title("Distribution of Event Types")
    plt.ylabel('')
    plt.tight_layout()
    plt.savefig('screenshots/pie_chart_events.png')
    plt.close()

def generate_html_report():
    print("Generating HTML report...")
    html_content = """
    <html>
    <head>
        <title>System Log Analysis Report</title>
        <style>body { font-family: Arial, sans-serif; margin: 40px; } img { max-width: 100%; border: 1px solid #ddd; margin-bottom: 20px; }</style>
    </head>
    <body>
        <h1>System Log Analysis Report</h1>
        <h2>1. Error Frequency (Bar Chart)</h2>
        <img src="screenshots/bar_chart_errors.png" alt="Error Frequency Bar Chart">
        
        <h2>2. Login Activity (Time Series)</h2>
        <img src="screenshots/time_series_logins.png" alt="Login Activity Time Series">
        
        <h2>3. Event Type Distribution (Pie Chart)</h2>
        <img src="screenshots/pie_chart_events.png" alt="Event Distribution Pie Chart">
    </body>
    </html>
    """
    with open('report.html', 'w', encoding='utf-8') as f:
        f.write(html_content)

if __name__ == '__main__':
    extract_logs()
    process_and_visualize_logs()
    generate_html_report()
    print("Analysis completed successfully!")