# Sysauto
# Automated Backup Script

This project provides a simple bash script to automate backups of important directories or files, compress them, and optionally send email notifications. It supports local and remote backups.

---

## Features

- Back up specified directories or files
- Timestamped compressed backups (`.tar.gz`)
- Option to copy backups to a remote server via SCP
- Email notification on success or failure
- Keeps only the latest N backups, cleaning old ones automatically

---

## Setup Instructions

### 1. Clone this repository

```bash
git clone https://github.com/yourusername/automated-backup-script.git
cd automated-backup-script
