<?php

namespace App\Models;

use Dcat\Admin\Traits\HasDateTimeFormatter;

use Illuminate\Database\Eloquent\Model;

class AdminPage extends Model
{
	use HasDateTimeFormatter;
    protected $table = 'admin_page';

    protected $primaryKey = 'page_id';

    // 设置外键关联
    public function adminModel()
    {
        return $this->belongsTo(AdminModel::class, 'pk_admin_model_id', 'model_id');
    }
}
