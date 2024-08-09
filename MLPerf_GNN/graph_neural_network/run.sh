CUDA_VISIBLE_DEVICES=0,1 python train_rgnn_multi_gpu.py --model='rgat' --dataset_size='small' --layout='CSC' --use_fp16 --path ../datasets/igb_small_hetero

# make sure container shm is at least 8GB, otherwise we will see wired errors like "Bus error (core dumped)"