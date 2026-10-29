# Linux Desktop Backup

## Goal =
- Create an automated personal backup of my Ubuntu OS.
- Learn the Git and GitHub workflow.
- Lab and become more comfortable with the terminal and troubleshooting.

## Setup
- **Client:** Ubuntu ThinkPad, runs the backup script as root.
- **Backup server:** Debian 13 (no GUI), currently running on a VM for testing (next step: move it to a Lenovo M93p mini PC).
- **Connection:** SSH key login, no password, so the script can run unattended.

## What gets backed up
- `/home/user` (except `.cache`)
- `/etc` (except password hashes and private keys)
- `/usr/local`

rsync only sends files that changed since the last run.

## Problems / troubleshooting along the way

**No DNS after switching to a static IP**
apt couldn't reach the Debian mirrors on the server. With DHCP, libvirt gave the VM its DNS server (the host, `192.168.122.1`). With the static IP, only the IP and default gateway were set, so the VM had nowhere to send name lookups. Fixed by adding `nameserver 192.168.122.1` to `/etc/resolv.conf`.

**Permission denied on /etc**
Running as my user failed on root-only files inside `/etc`. This was eye-opening: the errors showed files that shouldn't be in the backup at all, since on the server they would lose their root protection. These are now excluded in the script.

The script now runs as root from a root-owned copy in `/usr/local/sbin` (so my user can't edit what root runs), and root has its own SSH key to connect to the server.

## Next steps
- Move the setup to the mini PC, with dedicated partitions for the backups.
- Change the backup server to a RHEL enviroment since it complements better my RHCSA studying.
- Schedule it weekly with a systemd timer or cron job.
