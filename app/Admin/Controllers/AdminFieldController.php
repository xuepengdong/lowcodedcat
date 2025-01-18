<?php

namespace App\Admin\Controllers;


use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use Dcat\Admin\Http\Controllers\AdminController;
use Illuminate\Support\Facades\DB;
use App\Admin\Repositories\TableColumnRepository;
use Illuminate\Http\Request;
use App\Models\AdminModel;
use App\Models\AdminField;
use function Symfony\Component\Routing\setCondition;
use function Symfony\Component\Translation\Command\display;
use App\Services\FieldManager;


class AdminFieldController extends AdminController
{

    protected function grid()
    {
        return Grid::make(new AdminField(), function (Grid $grid) {
            $modelId = request()->get('model_id');

            // 添加面包屑
            $tableName = AdminModel::where('model_id', $modelId)->value('model_name_en') ?? 'Unknown Table';
            $grid->header(function () use ($modelId, $tableName) {
                $homeUrl = admin_url('/');
                $modelsUrl = admin_url('model');
                $fieldsUrl = admin_url('admin_fields?model_id=' . $modelId);

                return <<<HTML
                <div class="dcat-breadcrumb">
                    <a href="{$homeUrl}">Home</a> /
                    <a href="{$modelsUrl}">Models</a> /
                    <span>{$tableName}</span>
                </div>
HTML;
            });


            $grid->model()->where('pk_admin_model_id', $modelId) ->orderBy('created_at', 'desc');
            $grid->column('fieldid');
            $grid->column('field_name_cn');
            $grid->column('field_name_en');
            $grid->column('field_type');
            $grid->column('field_unique');
            $grid->column('is_system');
            $grid->column('field_remarks');
            $grid->column('created_at');
            $grid->column('updated_at');

            $grid->filter(function (Grid\Filter $filter) use ($modelId) {
                // 隐藏但默认生效的筛选条件
                $filter->where('pk_admin_model_id', function ($query) use ($modelId) {
                    $query->where('pk_admin_model_id', $modelId);
                });

                // 可选的其他筛选条件
                $filter->like('field_name_cn', 'Field Name (CN)');
                $filter->like('field_name_en', 'Field Name (EN)');
            });
            //开启弹窗创建表单
            $grid->enableDialogCreate();

            $grid->model()->setConstraints([
                'model_id' => $modelId,
            ]);
        });
    }


    protected function detail($id)
    {
        return Show::make($id, new AdminField(), function (Show $show) use($id) {


            $adminField = \App\Models\AdminField::find($id); // 获取当前记录
            $pkAdminModelId = $adminField ? $adminField->pk_admin_model_id : null;

            // 添加字段展示
            $show->field('fieldid');
            $show->field('pk_admin_model_id', 'Model Name')->as(function ($modelId) {
                $adminModel = \App\Models\AdminModel::find($modelId);
                return $adminModel ? $adminModel->model_name_en : 'N/A';
            });
            $show->field('field_name_cn');
            $show->field('field_name_en');
            $show->field('field_type');
            $show->field('field_unique');
            $show->field('field_remarks');
            $show->field('created_at', '创建时间');
            $show->field('updated_at', '修改时间');

            // 修改操作按钮的 URL
            $show->panel()->tools(function ($tools) use ($id, $pkAdminModelId) {
//                $tools->disableEdit(); // 禁用默认的 Edit 按钮
//                $tools->disableDelete(); // 禁用默认的 Delete 按钮
                $tools->disableList(); // 禁用默认的 List 按钮

                if ($pkAdminModelId) {
                    // 自定义 List 按钮
                    $tools->append('<a class="btn btn-sm btn-info" href="' . url('admin/admin_fields?model_id='.$pkAdminModelId) . '">List</a>');
                }

            });
        });
    }


    protected function form()
    {
        return Form::make(new AdminField(), function (Form $form) {
            $form->display('fieldid');

            $modelId = request()->get('model_id');
            $form->hidden('pk_admin_model_id')->default($modelId);


            $form->text('field_name_cn', 'Field Name (CN)')
                ->required()
                ->rules(function ($form) {
                    $modelId = $form->model()->pk_admin_model_id;
                    return [
                        'unique:admin_field,field_name_cn,' . $form->model()->fieldid . ',fieldid,pk_admin_model_id,' . $modelId,
                        'max:255',
                    ];
                })
                ->help('Must be unique for the same model.');


            $form->text('field_name_en', 'Field Name (EN)')
                ->required()
                ->rules(function ($form) {
                    $modelId = $form->model()->pk_admin_model_id;
                    return [
                        'unique:admin_field,field_name_en,' . $form->model()->fieldid . ',fieldid,pk_admin_model_id,' . $modelId,
                        'max:255',
                    ];
                })
                ->help('Must be unique for the same model.');

            // 获取admin_fieldtype表的数据
            $fieldTypes = DB::table('admin_fieldtype')->orderBy('sort', 'asc')->pluck('fieldtype_name', 'fieldtype_id')->toArray();

            $form->select('field_type', 'Field Type')
                ->options($fieldTypes)
                ->required();



            $form->switch('is_system', 'Is System')
                ->options([
                    'on'  => ['value' => '1',  'color' => 'success'],
                    'off' => ['value' => '0',  'color' => 'danger'],
                ])
                ->saving(function ($v) {
                    return $v ? '1' : '0';
                });

            $form->switch('field_unique', 'Is Unique')
                ->options([
                    'on'  => ['value' => '1',  'color' => 'success']
                ])
                ->saving(function ($v) {
                    return $v ? '1' : '0';
                });

            $form->number('field_length');

            $form->textarea('field_remarks', 'Field Remarks')
                ->rows(3)
                ->rules('max:500');

            $form->display('created_at', 'Created At');
            $form->display('updated_at', 'Updated At');

            //添加字段或者修改字段的逻辑
            $form->saved(function (Form $form) {
                // 获取 model_name_en
                $modelId = $form->pk_admin_model_id;
                $tableName = DB::table('admin_model')->where('model_id', $modelId)->value('model_name_en');

                if (!$tableName) {
                    admin_toastr('Model does not exist.', 'error');
                    return;
                }
                $newFieldName = $form->field_name_en;
                $oldFieldName = $form->field('field_name_en')->original();
                $fieldTypeId = $form->field_type;
                $fieldLength = $form->field_length;
                $isUnique = $form->field_unique;
                if ($form->isCreating()) {
                    FieldManager::addFieldToTable($tableName, $newFieldName, $fieldTypeId, $fieldLength, $isUnique);
                    admin_toastr('Field added successfully to the table.', 'success');
                } else {
                    FieldManager::modifyFieldInTable($tableName, $oldFieldName, $newFieldName, $fieldTypeId, $fieldLength, $isUnique);
                    admin_toastr('Field updated successfully in the table.', 'success');
                }

            });
        });
    }
}
