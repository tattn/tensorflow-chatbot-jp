#!/usr/bin/env bash

# create and own the directories to store results locally
save_dir='mydata'
sudo mkdir -p $save_dir'/data/'
sudo mkdir -p $save_dir'/nn_models/'
sudo mkdir -p $save_dir'/results/'
sudo chown -R "$USER" $save_dir

# copy train and test data with proper naming
data_dir='tf_seq2seq_chatbot/data/train'
cp $data_dir'/movie_lines_cleaned.txt' $save_dir'/data/chat.in'
cp $data_dir'/movie_lines_cleaned_10k.txt' $save_dir'/data/chat_test.in'

# build and install the tweaked Seq2Seq_Upgrade_TensorFlow package
cd $save_dir
git clone git@github.com:nicolas-ivanov/Seq2Seq_Upgrade_TensorFlow.git
cd Seq2Seq_Upgrade_TensorFlow
sudo python3 setup.py build & sudo python3 setup.py install