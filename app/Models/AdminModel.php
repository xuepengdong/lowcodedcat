<?php

namespace App\Models;

use Dcat\Admin\Traits\HasDateTimeFormatter;
use Illuminate\Database\Eloquent\Model;

class AdminModel extends Model
{
    use HasDateTimeFormatter;

    protected $table = 'admin_model'; // `admin_model` 为记录输入对象的表

    protected $primaryKey = 'model_id'; // 主键字段

    public function fields()
    {
        return $this->hasMany(AdminField::class, 'pk_admin_model_id', 'model_id');
    }

    // 定义外键关联
    public function adminPages()
    {
        return $this->hasMany(AdminPage::class, 'pk_admin_model_id', 'model_id');
    }
}
