cd dataset

if [ -f train_labels.csv ]; then
    echo "Dataset already available"
    exit
fi

# Download dataset
echo "Downloading dataset..."


if [ ! -f histopathologic-cancer-detection.zip ]; then
    kaggle competitions download -c histopathologic-cancer-detection
else
    echo "histopathologic-cancer-detection.zip already downloaded"
fi

# unzip
echo "Unzip files..."
unzip histopathologic-cancer-detection.zip

echo "Removing zip file..."
rm histopathologic-cancer-detection.zip

echo "Done!"