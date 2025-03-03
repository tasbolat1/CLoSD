#!/bin/bash


# run environments

export WANDB_MODE=offline
export WANDB_HOST=http://47.115.95.211:8080
export WANDB_BASE_URL=http://47.115.95.211:8080
export HF_HOME=/workspace/huggingface

# run WANDB sync in the background
rm -rf ~/.cache/wandb/
./wandb_sync.sh &  
PID=$!
echo "Background Script $PID started."

wandb login --host=http://47.115.95.211:8080
# enter your WANDB_KEY

# Run the program
python -m closd.diffusion_planner.eval.eval_humanml\
 --guidance_param 7.5\
 --model_path closd/diffusion_planner/save/DiP_no-target_10steps_context20_predict40/model000600343.pt\
 --autoregressive\
 --train_platform_type WandBPlatform

### kill the background process
kill -9 $PID

echo "syncing wandb..."
wandb sync --sync-all # final sync
echo "Wandb Sync completed."


python -m closd.diffusion_planner.eval.eval_humanml\
 --guidance_param 7.5\
 --model_path closd/diffusion_planner/save/my_DiP/model000600343.pt\
 --autoregressive\
 --train_platform_type WandBPlatform
