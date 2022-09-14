CUDA_VERSION_MAJOR_MINOR=$1

# Split the version.
# We (might/probably) don't know PATCH at this point - it depends which version gets installed.
export CUDA_MAJOR=$(echo "${CUDA_VERSION_MAJOR_MINOR}" | cut -d. -f1)
export CUDA_MINOR=$(echo "${CUDA_VERSION_MAJOR_MINOR}" | cut -d. -f2)
export CUDA_PATCH=$(echo "${CUDA_VERSION_MAJOR_MINOR}" | cut -d. -f3)
export CUDA_PATH="${HOME}/.kompile/$CUDA_VERSION_MAJOR_MINOR"

if [[ "$CUDA_VERSION_MAJOR_MINOR" == *"11.2"* ]]; then
 wget -O cudnn.tgz https://developer.download.nvidia.com/compute/redist/cudnn/v8.1.0/cudnn-11.2-linux-x64-v8.1.0.77.tgz
fi

if [[ "$CUDA_VERSION_MAJOR_MINOR" == *"11.0"* ]]; then
 wget -O cudnn.tgz https://developer.download.nvidia.com/compute/redist/cudnn/v8.0.4/cudnn-11.0-linux-x64-v8.0.4.30.tgz
fi

if [[ "$CUDA_VERSION_MAJOR_MINOR" == *"11.4"* ]]; then
 wget -O cudnn.tgz https://developer.download.nvidia.com/compute/redist/cudnn/v8.2.2/cudnn-11.4-linux-x64-v8.2.2.26.tgz
fi

if [[ "$CUDA_VERSION_MAJOR_MINOR" == *"11.6"* ]]; then
 wget -O cudnn.tgz https://developer.download.nvidia.com/compute/redist/cudnn/v8.3.2/local_installers/11.5/cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive.tar.xz
fi


if [[ "$CUDA_VERSION_MAJOR_MINOR" == *"10.2"* ]]; then
 wget -O cudnn.tgz https://developer.download.nvidia.com/compute/redist/cudnn/v8.2.2/cudnn-10.2-linux-x64-v8.2.2.26.tgz
 
fi

tar -hxvf cudnn.tgz -C "$CUDA_PATH"
if [[ "$CUDA_VERSION_MAJOR_MINOR" == *"11.6"* ]]; then
   echo "Listing base Cuda Path at $CUDA_PATH"
   ls "$CUDA_PATH"
   echo "Listing cuda path with archive"
   ls "$CUDA_PATH/cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive/"
   cp -rf  "$CUDA_PATH/cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive/include/"* "$CUDA_PATH/include"
   echo "Listing cuda include dir after cudnn copy"
   ls "$CUDA_PATH/include"
   cp -rf  "$CUDA_PATH/cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive/lib/"* "$CUDA_PATH/lib64"
   echo "Listing cuda lib directory after cudnn copy"
   ls "$CUDA_PATH/lib64"

fi
