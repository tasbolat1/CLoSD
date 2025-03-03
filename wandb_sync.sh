#!/bin/bash

export WANDB_HOST=http://47.115.95.211:8080
export WANDB_BASE_URL=http://47.115.95.211:8080

wandb login --host=http://47.115.95.211:8080
wandb sync --sync-all
