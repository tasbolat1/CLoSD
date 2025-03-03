#!/bin/bash

export WANDB_MODE=offline
export WANDB_HOST=http://47.115.95.211:8080
export WANDB_BASE_URL=http://47.115.95.211:8080
export HF_HOME=/workspace/huggingface

# Run the program
python -m closd.diffusion_planner.train.train_mdm\
 --save_dir closd/diffusion_planner/save/my_DiP\
 --dataset humanml --arch trans_dec --text_encoder_type bert\
 --diffusion_steps 10 --context_len 20 --pred_len 40\
 --mask_frames --eval_during_training --gen_during_training\
 --overwrite --use_ema --autoregressive\
 --train_platform_type WandBPlatform --lambda_target_loc 0