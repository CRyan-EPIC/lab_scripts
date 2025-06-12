#!/bin/bash
# Safe shutdown script for Proxmox 8 without HA
# Gracefully shuts down all VMs and containers, waits for them to stop, then shuts down the host.

TIMEOUT=300  # seconds to wait for guests to shutdown

echo "Starting safe shutdown of all VMs and containers..."

# Shutdown all VMs gracefully
for vmid in $(qm list | awk 'NR>1 {print $1}'); do
  echo "Shutting down VM ID $vmid..."
  qm shutdown $vmid
done

# Shutdown all containers gracefully
for ctid in $(pct list | awk 'NR>1 {print $1}'); do
  echo "Shutting down container ID $ctid..."
  pct shutdown $ctid
done

echo "Waiting up to $TIMEOUT seconds for all guests to stop..."

SECONDS=0
while [ $SECONDS -lt $TIMEOUT ]; do
  running_vms=$(qm list | awk 'NR>1 && $2=="running" {print $1}')
  running_cts=$(pct list | awk 'NR>1 && $2=="running" {print $1}')
  if [ -z "$running_vms" ] && [ -z "$running_cts" ]; then
    echo "All guests have shut down cleanly."
    break
  fi
  sleep 5
done

# Force stop any guests still running after timeout
if [ -n "$running_vms" ] || [ -n "$running_cts" ]; then
  echo "Timeout reached. Forcing stop of remaining guests..."
  for vmid in $running_vms; do
    echo "Forcing stop of VM ID $vmid"
    qm stop $vmid
  done
  for ctid in $running_cts; do
    echo "Forcing stop of container ID $ctid"
    pct stop $ctid
  done
fi

echo "All guests stopped. Proceeding to shutdown the Proxmox host..."

shutdown now
