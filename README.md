# 📦 Infrastructure Backup & Restore Script

A Bash-based automation tool to back up and restore directories using compressed `.tar.gz` archives.

🔁 Supports backup and restoration via simple CLI flags.  
🪵 Logs all actions to a timestamped log file in the `logs/` directory.  
🧩 Designed to be modular and callable from other tools like Terraform or Python.

---

## 🚀 Features

- Backup any directory as `.tar.gz`
- Restore archive to target location
- Modular Bash functions with error handling
- Logging for all actions
- Reusable in DevOps automation pipelines

---

## 📂 Project Structure

```bash
infra-backup/
├── infra_backup.sh       # Main backup & restore script
├── logs/                 # Logs saved with date-based filenames
└── README.md             # You’re reading it!
