#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_json_file> <mapping_output_file>"
    exit 1
fi

input_file=$1
mapping_file=$2

# 检查输入文件是否存在
if [ ! -f "$input_file" ]; then
    echo "Error: Input file $input_file does not exist"
    exit 1
fi

# 一次性处理所有内容
echo "Processing file: $input_file"

# 使用单个jq命令完成所有操作
jq -r '
def process_chinese:
  def has_chinese: type == "string" and test("[一-龥]");
  
  # 先获取所有需要处理的路径和值
  [paths(scalars) as $p 
    | select(getpath($p) | has_chinese)
    | { path: $p, value: getpath($p) }
  ] as $items
  
  # 初始化状态对象
  | {
      mapping: {},
      current: .,
      counter: 1
    }
  
  # 处理每个项目
  | reduce $items[] as $item (
      .;
      # 为当前项目创建替换ID
      . as $state
      | ($state.counter | tostring) as $id
      | .mapping += { 
          ("##" + $id + "##"): $item.value 
        }
      | .current |= setpath($item.path; "##" + $id + "##")
      | .counter += 1
    );

# 执行处理并输出结果
process_chinese | {mapping: .mapping, result: .current}
' "$input_file" > temp.json

# 检查处理结果
if jq -e . >/dev/null 2>&1 <<<"$(cat temp.json)"; then
    # 从临时文件中提取映射和结果
    jq '.mapping' temp.json > "$mapping_file"
    jq '.result' temp.json > "$input_file"
    echo "Process completed successfully"
else
    echo "Error: JSON processing failed"
    exit 1
fi

# 清理临时文件
rm temp.json