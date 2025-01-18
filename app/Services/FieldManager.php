<?php

namespace App\Services;

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class FieldManager
{
    /**
     * 添加字段
     */
    public static function addFieldToTable(string $tableName, string $fieldName, int $fieldTypeId, int $fieldLength, bool $isUnique)
    {
        if (!Schema::hasTable($tableName)) {
            throw new \Exception("Table '{$tableName}' does not exist.");
        }

        if (Schema::hasColumn($tableName, $fieldName)) {
            throw new \Exception("The field '{$fieldName}' already exists in table '{$tableName}'.");
        }

        Schema::table($tableName, function (Blueprint $table) use ($fieldName, $fieldTypeId, $fieldLength, $isUnique) {
            self::applyFieldDefinitionForAdd($table, $fieldName, $fieldTypeId, $fieldLength, $isUnique);
        });
    }

    /**
     * 字段添加逻辑
     */
    private static function applyFieldDefinitionForAdd($table, string $fieldName, int $fieldTypeId, int $fieldLength, bool $isUnique)
    {
        switch ($fieldTypeId) {
            case 1: case 2: case 11: case 12: case 13: case 15: case 16: case 25: case 29: case 3: case 9:
            $field = $table->string($fieldName, $fieldLength ?? 255)->nullable();
            break;

            case 4: case 5: case 7: case 10:
            $field = $table->json($fieldName)->nullable();
            break;

            case 6: case 8:
            $field = $table->text($fieldName)->nullable();
            break;

            case 14:
                $field = $table->ipAddress($fieldName)->nullable();
                break;

            case 17:
                $field = $table->time($fieldName)->nullable();
                break;

            case 18:
                $field = $table->date($fieldName)->nullable();
                break;

            case 19:
                $field = $table->dateTime($fieldName)->nullable();
                break;

            case 20: case 21:
            $field = $table->text($fieldName)->nullable();
            break;

            case 22: case 23:
            $field = $table->longText($fieldName)->nullable();
            break;

            case 24:
                $field = $table->boolean($fieldName)->default(false);
                break;

            case 26: case 28:
            $field = $table->decimal($fieldName, $fieldLength ?? 10, 2)->nullable();
            break;

            case 30:
                $field = $table->unsignedBigInteger($fieldName)->nullable();
                break;

            case 27:
                // 分割线不存储
                break;

            default:
                throw new \Exception("Unsupported field type ID: {$fieldTypeId}");
        }

        // 如果是唯一字段，添加唯一索引
        if ($isUnique) {
            $field->unique();
        }
    }


    /**
     * 修改字段名和类型
     */
    public static function modifyFieldInTable(string $tableName, string $oldFieldName, string $newFieldName, int $fieldTypeId, int $fieldLength, bool $isUnique)
    {
        if (!Schema::hasTable($tableName)) {
            throw new \Exception("Table '{$tableName}' does not exist.");
        }

        if (!Schema::hasColumn($tableName, $oldFieldName)) {
            throw new \Exception("The field '{$oldFieldName}' does not exist in table '{$tableName}'.");
        }

        try {
            Schema::table($tableName, function (Blueprint $table) use ($oldFieldName, $newFieldName, $fieldTypeId, $fieldLength, $isUnique) {
                if ($oldFieldName !== $newFieldName) {
                    $table->renameColumn($oldFieldName, $newFieldName);
                }

                self::applyFieldDefinitionForModify($table, $oldFieldName, $newFieldName, $fieldTypeId, $fieldLength, $isUnique);
            });
        } catch (\Exception $e) {
            Log::error("Error during schema modification: " . $e->getMessage());
            throw $e; // 抛出异常，确保问题能够被捕获
        }
    }

    /**
     * 修改字段逻辑
     */
    /**
     * 统一定义字段修改逻辑
     */
    private static function applyFieldDefinitionForModify($table, string $oldFieldName, string $fieldName, int $fieldTypeId, int $fieldLength = null, bool $isUnique)
    {
        // 获取表名
        $tableName = $table->getTable();

        // 查询该字段的所有索引
        $indexes = DB::select("SHOW INDEX FROM {$tableName} WHERE Column_name = ?", [$oldFieldName]);
        $existingIndexNames = array_map(fn($index) => $index->Key_name, $indexes);

        // 如果有多个索引，删除多余的，只保留一个
        if (count($existingIndexNames) > 1) {
            foreach (array_slice($existingIndexNames, 1) as $indexName) {
                Schema::table($tableName, function (Blueprint $table) use ($indexName) {
                    $table->dropIndex($indexName); // 删除多余索引
                });
            }
        }

        // 如果需要唯一索引且不存在唯一索引，则添加
        if ($isUnique) {
            $uniqueIndexExists = false;

            foreach ($indexes as $index) {
                if ($index->Non_unique == 0) { // Non_unique == 0 表示唯一索引
                    $uniqueIndexExists = true;
                    break;
                }
            }

            if (!$uniqueIndexExists) {
                Schema::table($tableName, function (Blueprint $table) use ($fieldName) {
                    $table->unique($fieldName); // 添加唯一索引
                });
            }
        } else {
            // 如果不需要唯一索引但存在唯一索引，删除
            foreach ($indexes as $index) {
                if ($index->Non_unique == 0) {
                    Schema::table($tableName, function (Blueprint $table) use ($index) {
                        $table->dropUnique($index->Key_name); // 删除唯一索引
                    });
                }
            }
        }

        // 根据字段类型和长度重新定义字段
        switch ($fieldTypeId) {
            case 1: case 2: case 11: case 12: case 13: case 15: case 16: case 25: case 29: case 3: case 9:
            $field = $table->string($fieldName, $fieldLength ?? 255)->nullable()->change();
            break;
            case 4: case 5: case 7: case 10:
            $field = $table->json($fieldName)->nullable()->change();
            break;
            case 6: case 8:
            $field = $table->text($fieldName)->nullable()->change();
            break;
            case 14:
                $field = $table->ipAddress($fieldName)->nullable()->change();
                break;
            case 17:
                $field = $table->time($fieldName)->nullable()->change();
                break;
            case 18:
                $field = $table->date($fieldName)->nullable()->change();
                break;
            case 19:
                $field = $table->dateTime($fieldName)->nullable()->change();
                break;
            case 20: case 21:
            $field = $table->text($fieldName)->nullable()->change();
            break;
            case 22: case 23:
            $field = $table->longText($fieldName)->nullable()->change();
            break;
            case 24:
                $field = $table->boolean($fieldName)->default(false)->change();
                break;
            case 26: case 28:
            $field = $table->decimal($fieldName, $fieldLength ?? 10, 2)->nullable()->change();
            break;
            case 30:
                $field = $table->unsignedBigInteger($fieldName)->nullable()->change();
                break;
            case 27:
                // 分割线不存储
                break;
            default:
                throw new \Exception("Unsupported field type ID: {$fieldTypeId}");
        }
    }


}
