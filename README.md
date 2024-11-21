# Flashcat OpenAPI 文档

这是Flashcat的OpenAPI文档仓库，包含了所有API接口的定义和说明。本仓库同时提供了中文和英文两个版本的文档。

## OpenAPI.json 翻译流程

我们使用半自动化的方式来维护多语言API文档。翻译流程如下：

### 1. 创建mapping

使用提取脚本从中文OpenAPI文件中提取所有中文内容：

```bash
./tools/extract_chinese.sh zh-openapi.json mapping.json
```

这会生成两个文件：
- 带占位符的JSON文件（原始文件会被修改）
- mapping.json（包含所有需要翻译的中文文本）

### 2. 翻译mapping

1. 将生成的mapping.json内容复制到AI翻译助手（如ChatGPT、Claude）
2. 使用以下prompt进行翻译：

```
遵循 @instructions.md 的说明，翻译 @mapping.json ，将Values从中文翻译为英文。
```

### 3. 回写mapping

使用填充脚本将翻译后的内容替换回JSON文件：

```bash
./tools/fill_translation.sh mapping_en.json zh-openapi.json
```

## 工具依赖

- `jq` (JSON处理工具)
- `bash` 4.0+
- Unix-like 环境 (Linux/MacOS)
