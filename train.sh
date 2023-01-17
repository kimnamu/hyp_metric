python -m train --ds SOP \
--model vit_small_patch16_224 \
--lr 3e-5 \
--ep 200 \
--eval_ep "[200]" \
--path ../../dataset \
--bs 300 \
--weight "/home/jovyan/models/similar_product/hyp_metric_vit_small_221214.pt"
