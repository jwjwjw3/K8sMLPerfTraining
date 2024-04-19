# LoRA benchmark

LoRA benchmark on GPU (Nvidia A100 80GB). Inspired by [MLPerf Training Reference Implementation Release](https://github.com/mlcommons/training/releases/tag/v4.0) with code at [MLPerf Training GitHub guide page](https://github.com/mlcommons/training/tree/master/llama2_70b_lora).

## Setup

Run the following:
```
conda env create -f conda-env.yaml
```

> This will create a `deepspeed` conda environment with all dependencies for running Llama 2 fine-tuning. 

You will also need to run the following to install flash attention if conda solve environment fails to install it and you decide to use flash-attn (default is not to use flash-attn):
```
FLASH_ATTENTION_SKIP_CUDA_BUILD=TRUE pip install flash-attn==2.5.7 --no-build-isolation
```

> For flash attention, make sure that the following command returns 0:
> ```
> ninja --version >/dev/null && echo $?
> ```
> If not, run
> ```
> pip uninstall -y ninja && pip install ninja
> ```
> and install `flash-attn` again.
> More information [here](https://github.com/Dao-AILab/flash-attention?tab=readme-ov-file#installation-and-features).

Make sure to have requested permission for donwloading Llama2 weights on the Hugging Face Hub: https://huggingface.co/meta-llama/Llama-2-7b-hf
Then, you will need to be connected to your Hugging Face account with a read token running:
```
huggingface-cli login
```
Finally please install mlperf logger:
```
git clone https://github.com/mlperf/logging.git mlperf-logging
pip install -e mlperf-logging
```
## Download Data and Model
data can be downloaded from:
[mlperf drive - train data](https://drive.google.com/file/d/1-JgY1mEafcJ7qhggt6UR3OEKAciIPd5s/view?usp=sharing)
[mlperf drive - validation data](https://drive.google.com/file/d/1jrm6Lacrq49AYv0uB_Qy22xRmfPixQvs/view?usp=sharing)
[mlperf drive - llama-v2 model](https://drive.google.com/drive/folders/1sTeuxkPhwkNPKIPFnOLIYCcK53oB3Ypc?usp=sharing)
As defaults the scripts assume the model is under at ```./llama-v2-fused-qkv``` and the both train and validation are under ```dataset``` folder.

## Llama2-70B on 8 devices

Run fine-tuning:

```bash run_llama_70B_scrolls_r16.sh```

> Using flash attention with `--use_flash_attn` is necessary for training on 8k-token sequences.

Learning curves of such a run can be found here: https://huggingface.co/regisss/test_5/tensorboard


<!-- ## Evaluation

To run evaluation for summarizing texts, you can run:
- Without LoRA adapter weights:
   ```
   python scripts/eval.py --model_name meta-llama/Llama-2-70b-hf --max_new_tokens 900 --seq_length 8192 --do_sample --dataset_name "tau/scrolls" --dataset_config_name "gov_report"
   ```
- With LoRA adapter weights:
   ```
   python scripts/eval.py --peft_model_name path_to_my_lora_model --max_new_tokens 900 --seq_length 8192 --do_sample --dataset_name "tau/scrolls" --dataset_config_name "gov_report"
   ``` -->
## Expected outcome

A clean output (train and eval loss) of a singel run with 440 steps can be found under 
```
   convergence_example.txt
```