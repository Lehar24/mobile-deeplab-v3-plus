#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

#export CUDA_VISIBLE_DEVICES=''
# Update PYTHONPATH.
export PYTHONPATH=$PYTHONPATH:`pwd`

MODEL_TYPE='deeplab-v3-plus'
PRETRAINED_MODEL_DIR='pretrained_model'
PRETRAINED_BACKBONE_MODEL_DIR='pretrained_backbone_model'
# Set up the working environment.
CURRENT_DIR=$(pwd)
WORK_DIR="${CURRENT_DIR}"

# Run model_test first to make sure the PYTHONPATH is correctly set.
# python "${WORK_DIR}"/deeplab_v3_plus_test.py -v

# Go to datasets folder and download PASCAL VOC 2012 segmentation dataset.
DATASET_DIR="/content/mobile-deeplab-v3-plus/datasets/scripts/Batch_1_training_ds_spatialAI"                                                       #already converted
#cd "${WORK_DIR}/${DATASET_DIR}"
#sh download_and_convert_voc2012.sh

# Go back to original directory.
cd "${CURRENT_DIR}"

# Set up the working directories.
DATASET_FOLDER="/content/mobile-deeplab-v3-plus/datasets/scripts/Batch_1_training_ds_spatialAI/images"
EXP_FOLDER="exp"
TRAIN_LOGDIR="${WORK_DIR}/${DATASET_DIR}/${DATASET_FOLDER}/${EXP_FOLDER}/${MODEL_TYPE}/train"
mkdir -p "${TRAIN_LOGDIR}"

DATASET_FOLDER_CONVERTED="${WORK_DIR}/${DATASET_DIR}/${DATASET_FOLDER}/content/mobile-deeplab-v3-plus/datasets/scripts/output/segmentation"

python run.py --dataset_dir="${DATASET_FOLDER_CONVERTED}"\
  --dataset_name="/content/mobile-deeplab-v3-plus/datasets/scripts/Batch_1_training_ds_spatialAI/images" \
  --logdir="${TRAIN_LOGDIR}" \
  --model_type="${MODEL_TYPE}" \
  --base_learning_rate=0.007 \
  --num_clones=1 \
  --training_number_of_steps=10000 \
  --pretrained_backbone_model_dir="${PRETRAINED_BACKBONE_MODEL_DIR}"

#  --pretrained_model_dir="${PRETRAINED_MODEL_DIR}" \
#  --training_number_of_steps=10
