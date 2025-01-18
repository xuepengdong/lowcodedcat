<?php
namespace App\Admin\Controllers;

use Dcat\Admin\Http\Controllers\AdminController;
use Dcat\Admin\Form;
use Dcat\Admin\Grid;
use Dcat\Admin\Show;
use App\Models\AdminModel;
use Illuminate\Http\Request;
use Dcat\Admin\Layout\Content;  // 导入 Content 类


class ListController extends AdminController
{
    public function index(Content $content)
    {
        $tableid = request()->query('tableid');
        $pageid = request()->query('pageid');
        $adminModel = AdminModel::where('model_id', $tableid)->first();

        if (!$adminModel) {
            return redirect('/')->with('error', 'Model not found');
        }

        // 获取 model_name_en
        $modelNameEn = $adminModel->model_name_en;

        // 2. 查询对应表的数据
        $data = \DB::table($modelNameEn)->get();

        // 3. 返回视图并传递数据
        return $content
            ->header('Model Data')
            ->description('Table: ' . $modelNameEn)
            ->body(view('list', compact('data', 'modelNameEn', 'tableid', 'pageid')));
    }
}
