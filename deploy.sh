#!/bin/bash

# Create Lambda Layers - Split layers (Layer size limit 250 MB)

# Input file (original requirements.txt)
input_file="requirements.txt"

# Output files (split 2)
output_file1="layers/core/requirements.txt"
output_file2="layers/extra/requirements.txt"

# Function to remove specified files and directories from a folder
remove_files_and_directories() {
    folder="$1"
    echo "Removing files and directories from $folder..."
    rm -rf "$folder/numpy" "$folder/numpy.dist-info" "$folder/numpy.libs"
}

# Function to install dependencies for a layer
install_dependencies() {
    layer_folder="$1"
    echo "Installing dependencies for $layer_folder..."
    (cd "$layer_folder" && pip install -r requirements.txt --target . --upgrade --upgrade-strategy=only-if-needed)
}


# Create layers/core/requirements.txt file with the core packages
grep -v 'scikit-learn==' "$input_file" > "$output_file1"

# Create layers/extra/requirements.txt with only scikit-learn
grep 'scikit-learn==' "$input_file" > "$output_file2"

echo "Splitting complete."

# Install dependencies for each layer
install_dependencies "layers/core"
install_dependencies "layers/extra"
echo "Installing dependencies complete."

# Remove folders containing numpy
echo "Removing folders containing numpy from layers/extra..."
find "layers/extra" -type d -name 'numpy*' -exec rm -rf {} \;

# Deploy the serverless framework
echo "Deploying serverless framework..."
sls deploy
echo "Deployment complete."