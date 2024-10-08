# export PYTORCH_CUDA_ALLOC_CONF=garbage_collection_threshold:0.8,max_split_size_mb:1024
accelerate launch --config_file configs/default_config.yaml scripts/train.py \
--dataset_path "/nfs_container/MLPerf_Llama2/lora_finetune_dataset" \
--model_path "/nfs_container/MLPerf_Llama2/llama2-7b-hf" \
--max_seq_len 8192 \
--bf16 True \
--logging_steps 24 \
--eval_steps 48 \
--output_dir "./results/llama-70b_scrolls_gov_report_r16_$1" \
--per_device_train_batch_size 1 \
--gradient_accumulation_steps 1 \
--lr_scheduler_type "cosine" \
--learning_rate 4e-4 \
--weight_decay 0.0001 \
--warmup_ratio 0 \
--max_grad_norm 0.3 \
--use_gradient_checkpointing True \
--target_eval_loss 0.925 \
--use_peft_lora True \
--lora_r 16 \
--lora_alpha 32 \
--lora_dropout 0.1 \
# --max_steps 1024 \
--seed 100 \
--lora_target_modules "qkv_proj,o_proj"
