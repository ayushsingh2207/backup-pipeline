# 🚀 Automated Backup Pipeline

A DevOps project that automates data backup using **Jenkins running inside Docker**, verifies backup integrity using **SHA-256 checksum**, and provides **real-time monitoring and alerting** using **Prometheus** and **Grafana**.

The project demonstrates how **Scheduling**, **Containerization**, and **Monitoring** work together to build a reliable automated backup solution.

---

# 📖 Project Overview

Manual backups are time-consuming and prone to human error. Even scheduled backups can fail silently if they are not continuously monitored.

This project solves these problems by creating an automated backup pipeline that:

- Runs backups automatically using Jenkins scheduling
- Executes backup operations inside Docker containers
- Verifies backup integrity using SHA-256 checksum
- Exposes backup metrics through a custom metrics exporter
- Monitors backup health using Prometheus and Grafana
- Detects backup failures independently of Jenkins
- Sends email notifications when verification fails

---

# 🎯 Objectives

The project fulfills the following objectives:

- ✅ Automated Scheduling
- ✅ Jenkins Running Inside Docker
- ✅ Containerized Backup Execution
- ✅ Backup Integrity Verification
- ✅ Continuous Monitoring
- ✅ Independent Alerting
- ✅ Email Notifications
- ✅ Concurrent Build Protection

---

# 🏗️ Project Architecture

```
                 GitHub Repository
                        │
                        ▼
           Jenkins Pipeline (Docker)
                        │
      (Scheduled or Manual Trigger)
                        │
                        ▼
          Build Backup Docker Image
                        │
                        ▼
           Run Backup Docker Container
                        │
                        ▼
        Inside Backup Container
   ────────────────────────────────────
   • Compress Source Data
   • Generate Backup Archive
   • Generate SHA-256 Checksum
   • Generate Backup Metrics
   ────────────────────────────────────
                        │
                        ▼
     Copy Backup & Metrics to Host
                        │
                        ▼
     Jenkins Verifies SHA-256 Checksum
                        │
            ┌───────────┴────────────┐
            │                        │
            ▼                        ▼
     Metrics Exporter         Email Notification
            │                 (On Verification Failure)
            ▼
       Prometheus
            │
            ▼
        Grafana Dashboard
            │
            ▼
 Independent Watchdog Alert
```

---

# ⚙️ Technology Stack

| Technology | Purpose |
|------------|----------|
| Docker | Containerization |
| Docker Compose | Multi-container orchestration |
| Jenkins | Pipeline automation & scheduling |
| Shell Script | Backup automation |
| Python | Metrics exporter |
| Prometheus | Metrics collection |
| Grafana | Monitoring dashboard |
| Git & GitHub | Version control |

---

# ✨ Key Features

## 🔹 Automated Scheduling

- Jenkins automatically triggers backup jobs using Cron scheduling.
- Manual execution is also supported.

---

## 🔹 Jenkins Inside Docker

Jenkins itself runs inside a Docker container instead of being installed directly on the host operating system, making the pipeline portable and reproducible.

---

## 🔹 Containerized Backup Pipeline

Each pipeline execution:

- Builds the backup image
- Creates a fresh backup container
- Performs the backup
- Generates checksum
- Produces monitoring metrics
- Exits after completion

---

## 🔹 Backup Integrity Verification

Every backup generates a SHA-256 checksum.

Before marking the pipeline successful, Jenkins independently verifies the checksum to ensure that the backup has not been corrupted.

---

## 🔹 Metrics Exporter

A custom Python metrics exporter exposes backup information in Prometheus format.

Metrics include:

- Last Backup Timestamp
- Backup Size
- Backup Success Status

---

## 🔹 Real-Time Monitoring

Prometheus continuously scrapes backup metrics and Grafana visualizes them through a live dashboard.

Dashboard panels include:

- Last Backup Run Time
- Last Backup Size
- Backup Health (Time Since Last Run)
- Backup Size Trend

---

## 🔹 Independent Watchdog Alert

A Grafana alert continuously checks whether a successful backup has occurred within the configured time threshold.

Unlike Jenkins notifications, this alert continues to detect backup inactivity even if Jenkins itself is stopped.

---

## 🔹 Email Notifications

If checksum verification fails, Jenkins automatically sends an email notification containing build details and failure information.

---

## 🔹 Concurrent Build Protection

The Jenkins pipeline uses:

```groovy
disableConcurrentBuilds()
```

to prevent overlapping backup executions and avoid backup corruption.

---

# 📂 Repository Structure

```
backup-pipeline/
│
├── backup-script/
│   ├── backup.sh
│   └── restore.sh
│
├── sample-data/
│
├── Dockerfile
├── Dockerfile.exporter
├── Jenkinsfile
├── docker-compose.yml
├── metrics_exporter.py
├── prometheus.yml
└── README.md
```

---

# 🔄 Pipeline Workflow

```
GitHub Repository
        │
        ▼
Jenkins Pipeline Trigger
(Scheduled or Manual)
        │
        ▼
Build Backup Docker Image
        │
        ▼
Run Backup Container
        │
        ▼
Create Backup Archive
        │
        ▼
Generate SHA-256 Checksum
        │
        ▼
Generate Backup Metrics
        │
        ▼
Copy Backup & Metrics to Host
        │
        ▼
Verify Backup Integrity
        │
        ▼
Metrics Exporter
        │
        ▼
Prometheus
        │
        ▼
Grafana Dashboard
        │
        ▼
Alert Rules & Notifications
```

---

# 📊 Monitoring Dashboard

Grafana provides real-time visibility into the backup pipeline through the following panels:

- Last Backup Run Time
- Last Backup Size (Bytes)
- Backup Health (Time Since Last Run)
- Backup Size Trend

These visualizations help identify abnormal backup behaviour quickly.

---

# 🚨 Alerting

The project includes an independent watchdog alert.

If no successful backup occurs within the configured threshold, Grafana changes the alert status from **Normal** to **Firing**, allowing backup failures to be detected even when Jenkins is unavailable.

---

# 🔐 Backup Verification

Every backup is verified using a SHA-256 checksum before the Jenkins pipeline is marked successful.

This ensures backup integrity and prevents corrupted backups from being treated as valid.

---

# 📚 Learning Outcomes

This project demonstrates practical understanding of:

- Docker Containerization
- Docker Compose
- Jenkins Pipelines
- CI/CD Concepts
- Automated Scheduling
- Backup Automation
- SHA-256 Integrity Verification
- Prometheus Monitoring
- Grafana Dashboard Development
- Alert Rule Configuration
- DevOps Workflow Integration

---

# 🔮 Future Enhancements

Possible future improvements include:

- Cloud Backup (AWS S3 / Azure Blob Storage)
- Incremental Backups
- Backup Encryption
- Backup Retention Policies
- Slack / Microsoft Teams Notifications
- Multi-server Backup Support

---

# 👨‍💻 Author

**Ayush Singh**

DevOps Internship Project

**Project Title:** Automated Backup Pipeline

