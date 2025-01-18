<?php

namespace App\Admin\Controllers;

use Dcat\Admin\Http\Controllers\AdminController;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use App\Models\AdminPageField;
use Illuminate\Http\Request;
use Dcat\Admin\Layout\Content;
use Dcat\Admin\Admin;
use Dcat\Admin\Widgets\Modal;
use App\Admin\Repositories\NullRepository;
use App\Admin\Renderable\UserTable;


class PageSettingController extends AdminController
{

    public function index(Content $content)
    {
        $settings = AdminPageField::all();
        return view('pages.settings', compact('settings'));
        Admin::css('/css/custom.css');


        return $content
            ->title('pageSetting')
            ->description('pageSetting')
            ->body(view('pages.settings'));
    }

    protected function form()
    {
        return Form::make(new PageSetting(), function (Form $form) {
            $form->display('id', 'ID')->width(2);
            $form->text('name', 'pageName')
                ->required()
                ->placeholder('input pageName')
                ->width(8);

            $form->textarea('content', '页面内容')
                ->required()
                ->placeholder('请输入页面内容')
                ->rows(10)
                ->width(8);

            $form->display('updated_at', '更新时间')->width(4);
        });
    }




}
