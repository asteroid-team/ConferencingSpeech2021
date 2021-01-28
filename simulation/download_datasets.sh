#!/bin/bash

#########################
## Samuele Cornell 2020 #
#########################

## NOTE: downloading for vctk does not check certificates

aishell1_dir=../source_datasets/aishell1
aishell3_dir=../source_datasets/aishell3
librispeech_dir=../source_datasets/libri
vctk_dir=../source_datasets/vctk
musan_dir=../noise_datasets/musan
audioset_dir=../noise_datasets/audioset

# Exit on error
set -e
set -o pipefail

if ! test -e $aishell1_dir; then
    echo "Downloading aishell-1 into $aishell1_dir"
    wget -c --tries=0 --read-timeout=20 https://www.openslr.org/resources/33/data_aishell.tgz -P $aishell1_dir
	  tar -xzf $aishell1_dir/data_aishell.tgz -C $aishell1_dir
	  rm -rf $aishell1_dir/data_aishell.tgz
    wget -c --tries=0 --read-timeout=20 https://www.openslr.org/resources/33/resource_aishell.tgz -P $aishell1_dir
          tar -xzf $aishell1_dir/resource_aishell.tgz -C $aishell1_dir
          rm -rf $aishell1_dir/resource_aishell.tgz
fi


if ! test -e $aishell3_dir; then
    echo "Downloading aishell-3 into $aishell3_dir"
    wget -c --tries=0 --read-timeout=20 https://www.openslr.org/resources/93/data_aishell3.tgz -P $aishell3_dir
          tar -xzf $aishell3_dir/data_aishell3.tgz -C $aishell3_dir
          rm -rf $aishell3_dir/data_aishell3.tgz

fi

if ! test -e $librispeech_dir; then
    echo "Downloading LibriSpeech/train-clean-360 into $librispeech_dir"
    wget -c --tries=0 --read-timeout=20 http://www.openslr.org/resources/12/train-clean-360.tar.gz -P $librispeech_dir
    tar -xzf $librispeech_dir/train-clean-360.tar.gz -C $librispeech_dir
    rm -rf $librispeech_dir/LibriSpeech/train-clean-360.tar.gz	
fi

#if ! test -e $vctk_dir; then
 #   echo "Downloading VCTK into $vctk_dir"
 #   wget -c --tries=0 --read-timeout=20 https://datashare.ed.ac.uk/download/DS_10283_3443.zip -P $vctk_dir --no-check-certificate
 #         tar -xzf $vctk_dir/DS_10283_3443.zip -d $vctk_dir
 #         rm -rf $vctk_dir/DS_10283_3443.zip
#fi


if ! test -e $musan_dir; then
    echo "Downloading MUSAN into $musan_dir"
    wget -c --tries=0 --read-timeout=20 https://www.openslr.org/resources/17/musan.tar.gz -P $musan_dir
          tar -xzf $musan_dir/musan.tar.tgz -C $musan_dir
          rm -rf $musan_dir/musan.tar.tgz

fi




git clone https://github.com/marc-moreaux/audioset_raw $audioset_dir
cd $audioset_dir/download/train
cat ../balanced_train_segments.csv | ../download.sh
cd ../validate 
cat ../eval_segments.csv | ../download.sh
