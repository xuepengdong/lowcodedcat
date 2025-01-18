<?php

namespace App\Admin\Controllers;

use App\Models\AdminModel;
use Dcat\Admin\Http\JsonResponse;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use Dcat\Admin\Http\Controllers\AdminController;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Dcat\Admin\Admin;


class AdminModelController extends AdminController
{
    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        return Grid::make(new AdminModel(), function (Grid $grid) {
//            $grid->column('model_id')->sortable();
            $grid->column('model_id')
                ->sortable()
                ->display(function ($value) {
                    $url = admin_url("admin_fields?model_id={$value}");
                    return "<a href='{$url}'>{$value}</a>";
                });

            $grid->column('model_name_en');
            $grid->column('model_name_cn');
            $grid->column('model_remarks');
            $grid->column('created_at');
            $grid->column('updated_at')->sortable();


            $grid->actions(function ($actions) {
                $url = admin_url("admin_fields?model_id={$actions->getKey()}");
                $actions->append('<a href="' . $url . '" class="btn btn-sm btn-info">Fields</a>');
            });

            $grid->actions(function ($actions) {
                $url = admin_url("admin_page?model_id={$actions->getKey()}");
                $actions->append('<a href="' . $url . '" class="btn btn-sm btn-info">Pages</a>');
            });

            //开启弹窗创建表单
            $grid->enableDialogCreate();

            // 设置弹窗宽高，默认值为 '700px', '670px'
            $grid->setDialogFormDimensions('50%', '50%');

            $grid->filter(function (Grid\Filter $filter) {
                $filter->equal('model_id');
            });
        });
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     *
     * @return Show
     */
    protected function detail($id)
    {
        return Show::make($id, new AdminModel(), function (Show $show) {
            $show->field('model_id');
            $show->field('model_name_en');
            $show->field('model_name_cn');
            $show->field('model_remarks');
            $show->field('created_at');
            $show->field('updated_at');
        });

    }
    protected $modelNameEn; // 用于保存临时字段值

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        return Form::make(new AdminModel(), function (Form $form) {
            $user = Admin::user();
            $userId = $user->id;
            $form->display('model_id');
            $form->text('model_name_en') ->required();
            $form->text('model_name_cn')->required();
            $form->text('model_remarks');
            $form->display('created_at');
            $form->display('updated_at');
            $form->saved(function (Form $form) {//saved生命周期之后
                if($form->isCreating()){
                    //保存后回调，更新创建人ID
                    $user = Admin::user();
                    $userId = $user->id;
                    DB::table('admin_model')->where('model_name_en', '=', $form->model_name_en) ->update(['created_by'=>$userId, 'updated_by'=> $userId]);

                    $tableArray = DB::table('admin_model')->where('model_name_en', '=', $form->model_name_en) ->first();
                    try {
                        AdminModelController::createTableStatic($form->model_name_en, $tableArray->model_id);
                    } catch (\Exception $e) {
                        $form->model()->delete();
                        throw new \Exception("创建表失败: " . $e->getMessage());
                    }
                }


                if ($form->isEditing()) {
                    // 获取新的 model_name_en
                    $newModelNameEn = $form->model_name_en;

                    // 获取旧的 model_name_en
                    $oldModelNameEn = $form->field('model_name_en')->original();

                    if ($oldModelNameEn) {
                        // 新的表名
                        $newTableName = strtolower($newModelNameEn);
                        $oldTableName = strtolower($oldModelNameEn); // 假设表名与 model_name_en 一致，小写

                        // 修改表名
                        if ($oldTableName !== $newTableName) {
                            // 在数据库中重命名表
                            Schema::rename($oldTableName, $newTableName);
                        }
                    } else {
                        // 如果未能找到旧的数据，可以选择处理这个错误
                        throw new \Exception("无法获取旧的 model_name_en 数据");
                    }
                }

            });
        });
    }


    /**
     * 根据输入的 model_name_en 创建表
     *
     * @param string $modelNameEn
     */
    public static function createTableStatic(string $modelNameEn ,int $modelId)
    {
        $user = Admin::user();
        $userId = $user->id;

        // 表名以 model_name_en 的小写值命名
        $tableName = strtolower($modelNameEn);

        // 检查表是否已存在
        if (Schema::hasTable($tableName)) {
            throw new \Exception("表已经存在，请更改表名重新创建！");
        }

        // 主键名为首拼大写字母 + 'ID'
        $primaryKey = $tableName . 'ID';

        // 创建表$modelNameEn
        Schema::create($tableName, function (Blueprint $table) use ($primaryKey, $userId) {
            $table->increments($primaryKey); // 主键
            $table->timestamp('created_at')->nullable(); // 创建时间
            $table->timestamp('updated_at')->nullable(); // 更新时间
            $table->unsignedInteger('created_by')->nullable(); // 创建人
            $table->unsignedInteger('updated_by')->nullable(); // 修改人

            // 设置外键关联到 admin_users 表
            $table->foreign('created_by')->references('id')->on('admin_users')->onDelete('set null');
            $table->foreign('updated_by')->references('id')->on('admin_users')->onDelete('set null');
        });


        // 类型映射
        $fieldTypeMap = [
            'zhujian' => 1,//主键类型
            'timestamp' => 2,//时间类型
            'internalObjects'=>3,//内部对象
        ];


        // 插入默认字段到 admin_field 表
        $fields = [
            [
                'fieldid' => null,
                'pk_admin_model_id' => $modelId,
                'field_name_cn' => "主键ID",
                'field_name_en' => $primaryKey,
                'field_type' => $fieldTypeMap['zhujian'],
                'field_unique' => "1",
                'field_remarks' => "主键",
                'created_at' => now(),
                'updated_at' => now(),
                'is_system' => 1,
                'created_by' => $userId,
                'updated_by' => $userId
            ],
            [
                'fieldid' => null,
                'pk_admin_model_id' => $modelId,
                'field_name_cn' => "创建时间",
                'field_name_en' => "created_at",
                'field_type' => $fieldTypeMap['timestamp'],
                'field_unique' => "0",
                'field_remarks' => "记录的创建时间",
                'created_at' => now(),
                'updated_at' => now(),
                'is_system' => 1,
                'created_by' => $userId,
                'updated_by' => $userId
            ],
            [
                'fieldid' => null,
                'pk_admin_model_id' => $modelId,
                'field_name_cn' => "更新时间",
                'field_name_en' => "updated_at",
                'field_type' => $fieldTypeMap['timestamp'],
                'field_unique' => "0",
                'field_remarks' => "记录的更新时间",
                'created_at' => now(),
                'updated_at' => now(),
                'is_system' => 1,
                'created_by' => $userId,
                'updated_by' => $userId
            ],
            [
                'fieldid' => null,
                'pk_admin_model_id' => $modelId,
                'field_name_cn' => "创建人",
                'field_name_en' => "created_by",
                'field_type' => $fieldTypeMap['internalObjects'],
                'field_unique' => "0",
                'field_remarks' => "记录的创建人",
                'created_at' => now(),
                'updated_at' => now(),
                'is_system' => 1,
                'created_by' => $userId,
                'updated_by' => $userId
            ],
            [
                'fieldid' => null,
                'pk_admin_model_id' => $modelId,
                'field_name_cn' => "修改人",
                'field_name_en' => "updated_by",
                'field_type' => $fieldTypeMap['internalObjects'],
                'field_unique' => "0",
                'field_remarks' => "记录的修改人",
                'created_at' => now(),
                'updated_at' => now(),
                'is_system' => 1,
                'created_by' => $userId,
                'updated_by' => $userId
            ],
        ];

        DB::table('admin_field')->insert($fields);

    }


    /**
     * 根据新的 model_name_en 修改表名
     *
     * @param string $oldModelNameEn
     * @param string $newModelNameEn
     */
    public static function renameTable(string $oldModelNameEn, string $newModelNameEn)
    {
        // 如果新的表名与旧的表名相同，则不进行任何操作
        if (strtolower($oldModelNameEn) === strtolower($newModelNameEn)) {
            return;
        }

        $oldTableName = strtolower($oldModelNameEn);
        $newTableName = strtolower($newModelNameEn);

        // 如果旧表存在，则进行重命名
        if (Schema::hasTable($oldTableName)) {
            Schema::rename($oldTableName, $newTableName);  // 重命名表
            Log::info("表名已成功修改：$oldTableName -> $newTableName");
        } else {
            throw new \Exception("原表不存在，无法重命名：$oldTableName");
        }
    }

    /**
     * 删除当前数据并删除对应的表，通过删除某一条记录时执行 deleteTableDataAndTable 方法，覆盖 destroy 方法。
     *
     * @param int $id
     * @throws \Exception
     */
    public function destroy($id)
    {
        try {
            $this->deleteTableDataAndTable($id);
            return JsonResponse::make()->success('删除成功！')->refresh();
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => '删除失败', 'error' => $e->getMessage()], 500);
        }
    }


    /**
     * 删除当前数据并删除对应的表
     *
     * @param int $id
     * @throws \Exception
     */
    public function deleteTableDataAndTable($id)
    {
        try {
            // 获取模型对象
            $adminModel = AdminModel::findOrFail($id);
            $modelNameEn = $adminModel->model_name_en;

            // 删除 admin_field 表中与 $id 相关的数据
            DB::table('admin_field')->where('pk_admin_model_id', $id)->delete();

            // 1. 删除数据
            DB::table(strtolower($modelNameEn))->delete();  // 删除当前表的所有数据

            // 2. 删除表
            $tableName = strtolower($modelNameEn);
            if (Schema::hasTable($tableName)) {
                Schema::dropIfExists($tableName);  // 删除表
            }
            // 删除当前记录
            $adminModel->delete();
        } catch (\Exception $e) {
            return response()->json(['message' => '删除失败', 'error' => $e->getMessage()], 500);
        }
    }
}
