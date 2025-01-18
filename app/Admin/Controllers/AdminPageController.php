<?php

namespace App\Admin\Controllers;

use App\Admin\Repositories\AdminPage;
use Dcat\Admin\Admin;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use Dcat\Admin\Http\Controllers\AdminController;
use App\Models\AdminModel;
use App\Models\AdminPage as AdminPageModel;

class AdminPageController extends AdminController
{
    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        return Grid::make(new AdminPage(), function (Grid $grid) {
            $modelId = request()->get('model_id');

            // 添加面包屑
            $tableName = AdminModel::where('model_id', $modelId)->value('model_name_en') ?? 'Unknown Table';
            $grid->header(function () use ($modelId, $tableName) {
                $homeUrl = admin_url('/');
                $modelsUrl = admin_url('model');
                return <<<HTML
                <div class="dcat-breadcrumb">
                    <a href="{$homeUrl}">Home</a> /
                    <a href="{$modelsUrl}">Models</a> /
                    <span>{$tableName}</span>
                </div>
HTML;
            });

            if(request()->get('model_id')){
                $modelId = request()->get('model_id');
                $grid->model()->where('pk_admin_model_id', $modelId);
                $grid->model()->setConstraints([
                    'model_id' => $modelId,
                ]);
            }


            $pkAdminModelId = $grid->model();
            // 定义 Grid 列
            $grid->column('page_id')->sortable();
            $grid->column('page_name');
            $grid->column('page_type');
            $grid->column('created_by');
            $grid->column('updated_by');
            $grid->column('created_at');
            $grid->column('updated_at')->sortable();

            // 添加筛选器
            $grid->filter(function (Grid\Filter $filter) {
                $filter->equal('page_id');
            });

            //开启弹窗创建表单
            $grid->enableDialogCreate();

            $grid->actions(function ($actions) {
                $pageSettingUrl = admin_url("admin_pageSetting?page_id={$actions->getKey()}");
                $actions->append('<a href="' . $pageSettingUrl . '" class="btn btn-sm btn-info">pageSettingUrl</a>');
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
        return Show::make($id, new AdminPage(), function (Show $show) use ($id) {

            $show->field('page_id');
            $adminPage = AdminPageModel::find($id);
            $pkAdminModelId = $adminPage->pk_admin_model_id;
            $modelNameCn = \App\Models\AdminModel::where('model_id', $pkAdminModelId)->value('model_name_cn');

            $show->field('model_name_cn', 'Model Name CN')->as(function () use ($modelNameCn) {
                return $modelNameCn;
            });
            $show->field('pk_admin_model_id');


            $show->field('page_name');
            $show->field('page_type');

            $show->field('created_by');
            $show->field('updated_by');
            $show->field('created_at');
            $show->field('updated_at');
        });
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        return Form::make(new AdminPage(), function (Form $form){
            $user = Admin::user();
            $userId = $user->id;

            if ($form->model()->page_id) {//修改页面
                $modelId = $form->model()->pk_admin_model_id;
                $adminPage = AdminPageModel::find($form->model()->page_id);
                if ($adminPage) {
                    $pkAdminModelId = $adminPage->pk_admin_model_id;
                    $modelNameCn = AdminModel::where('model_id', $pkAdminModelId)->value('model_name_cn');
                    $modelName = $modelNameCn ? $modelNameCn : '未知';
                }
            }else{//添加页面
                $modelId = request()->get('model_id');
                $model = AdminModel::find($modelId);
                $modelName = $model ? $model->model_name_en : '未知';
            }



            // 展示查询到的 model_name_en 字段
            $form->display('model_name_en', 'Model Name')->value($modelName);

            // 表单字段
            $form->display('page_id');
            $form->text('page_name')->required();

            // 将 page_type 改为下拉框选择


            if ($form->isCreating()) {
                $form->select('page_type', 'Page Type')->options([
                    'list' => '列表',
                    'add' => '添加',
                    'edit' => '修改',
                    'view' => '查看',
                    'batch_add' => '批量添加',
                    'batch_edit' => '批量修改',
                    'popup' => '弹层',
                    'dropdown_tree' => '下拉树',
                ])->required();
            }else{
                $form->text('page_type')->readOnly()->required();
            }

            $form->hidden('created_by')->required()->default($userId);
            $form->hidden('updated_by')->required()->default($userId);
            $form->hidden('pk_admin_model_id')->default($modelId);

            $form->display('created_at');
            $form->display('updated_at');

            // 设置表单提交后的回调
            $form->saved(function (Form $form) use ($modelId) {
                admin_toastr('保存成功！');
            });
        });
    }




}
