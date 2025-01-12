## Hyperbolic Vision Transformers: Combining Improvements in Metric Learning

[![PWC](https://img.shields.io/endpoint.svg?url=https://paperswithcode.com/badge/hyperbolic-vision-transformers-combining/metric-learning-on-cars196)](https://paperswithcode.com/sota/metric-learning-on-cars196?p=hyperbolic-vision-transformers-combining)
[![PWC](https://img.shields.io/endpoint.svg?url=https://paperswithcode.com/badge/hyperbolic-vision-transformers-combining/metric-learning-on-cub-200-2011-4)](https://paperswithcode.com/sota/metric-learning-on-cub-200-2011-4?p=hyperbolic-vision-transformers-combining)

**CVPR 2022** &nbsp;&nbsp;
[arxiv.org/abs/2203.10833](https://arxiv.org/abs/2203.10833) &nbsp;&nbsp;
[Papers With Code](https://paperswithcode.com/paper/hyperbolic-vision-transformers-combining)

![scheme](https://github.com/htdt/hyp_metric/blob/master/scheme.png?raw=true)

![results](https://github.com/htdt/hyp_metric/blob/master/results.png?raw=true)


### Code includes 
- [Proxy-Anchor](https://github.com/tjddus9597/Proxy-Anchor-CVPR2020) for datasets and evaluation (uses `pytorch_metric_learning`);
- [hyperbolic-image-embeddings](https://github.com/leymir/hyperbolic-image-embeddings) for hyperbolic operations;
- `train.py` - main training;
- `eval_pretrain.py` - encoder evaluation without training;
- `delta.py` - δ-hyperbolicity evaluation.


### Run training
```
python -m torch.distributed.launch --nproc_per_node=4 train.py  # multi GPU
python -m train --help  # single GPU
```

### Configs
```
python -m train --ds CUB --model vit_small_patch16_224 --num_samples 9 --lr 3e-5 --ep 50 --eval_ep "[50]" --resize 256
python -m train --ds CUB --model dino_vits16 --num_samples 9 --lr 1e-5 --ep 50 --eval_ep "[50]" --resize 256
python -m train --ds CUB --model deit_small_distilled_patch16_224 --num_samples 9 --lr 3e-5 --ep 50 --eval_ep "[50]" --resize 256

python -m train --ds Cars --model vit_small_patch16_224 --num_samples 9 --bs 882 --lr 3e-5 --ep 300 --eval_ep "[300]"
python -m train --ds Cars --model dino_vits16 --num_samples 9 --bs 882 --lr 1e-5 --ep 300 --eval_ep "[300]"
python -m train --ds Cars --model deit_small_distilled_patch16_224 --num_samples 9 --bs 882 --lr 3e-5 --ep 300 --eval_ep "[300]"

python -m train --ds SOP --model vit_small_patch16_224 --lr 3e-5 --ep 200 --eval_ep "[200]"
python -m train --ds SOP --model dino_vits16 --lr 1e-5 --ep 200 --eval_ep "[200]"
python -m train --ds SOP --model deit_small_distilled_patch16_224 --lr 3e-5 --ep 200 --eval_ep "[200]"

python -m train --ds Inshop --model vit_small_patch16_224 --lr 3e-5 --ep 400 --eval_ep "[400]"
python -m train --ds Inshop --model dino_vits16 --lr 1e-5 --ep 400 --eval_ep "[400]"
python -m train --ds Inshop --model deit_small_distilled_patch16_224 --lr 3e-5 --ep 400 --eval_ep "[400]"

# add --hyp_c 0 --t 0.1 for sphere version
# use --clip_r 0 to disable clipping
# use --eval_ep "r(300,410,10)" to evaluate every 10 epoch between 300 and 400
```

### Setup
```
pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

git clone --branch 22.04-dev --single-branch https://github.com/NVIDIA/apex

pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./apex

pip install tqdm wandb timm typed-argument-parser pytorch_metric_learning

pip uninstall -y scipy && pip install scipy

wandb login
```

### Datasets
- [CUB-200](http://www.vision.caltech.edu/visipedia-data/CUB-200-2011/CUB_200_2011.tgz)
- Stanford Online Products ftp://cs.stanford.edu/cs/cvgl/Stanford_Online_Products.zip
- [In-shop Clothes Retrieval](http://mmlab.ie.cuhk.edu.hk/projects/DeepFashion.html)
    (In-shop Clothes Retrieval Benchmark -> Img -> img.zip, Eval/list_eval_partition.txt)
- [Cars-196](http://ai.stanford.edu/~jkrause/car196/car_ims.tgz) [labels](http://ai.stanford.edu/~jkrause/car196/cars_annos.mat)
