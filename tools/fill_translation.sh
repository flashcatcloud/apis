#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <translation_mapping_file> <target_json_file>"
    exit 1
fi

translation_file=$1
target_file=$2

# 检查输入文件
if [ ! -f "$translation_file" ]; then
    echo "Error: Translation file not found: $translation_file"
    exit 1
fi

if [ ! -f "$target_file" ]; then
    echo "Error: Target file not found: $target_file"
    exit 1
fi

# 验证输入文件是否为有效的JSON
echo "Validating input files..."
if ! jq empty "$translation_file" 2>/dev/null; then
    echo "Error: Invalid JSON in translation file"
    exit 1
fi

if ! jq empty "$target_file" 2>/dev/null; then
    echo "Error: Invalid JSON in target file"
    exit 1
fi

echo "Processing files..."

# 读取翻译映射
translations=$(jq '.' "$translation_file")

# 使用更简单的jq命令进行替换，保持原始格式
jq --argjson trans "$translations" '
    def replace_translations:
        walk(
            if type == "string" and test("^##\\d+##$") 
            then
                if $trans[.] != null then
                    $trans[.]
                else
                    .
                end
            else
                .
            end
        );
    
    replace_translations
' "$target_file" > "${target_file}.tmp"

# 检查输出是否为有效的JSON
if jq empty "${target_file}.tmp" 2>/dev/null; then
    mv "${target_file}.tmp" "$target_file"
    echo "Translation completed successfully"
else
    echo "Error: Failed to generate valid JSON output"
    echo "Debug: Showing first few lines of output:"
    head -n 5 "${target_file}.tmp"
    rm "${target_file}.tmp"
    exit 1
fi 