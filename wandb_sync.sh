#!/bin/bash

wandb login --host=http://47.115.95.211:8080

while true; do
  wandb sync --sync-all
done