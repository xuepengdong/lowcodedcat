<?php

namespace App\Models;

use Dcat\Admin\Traits\HasDateTimeFormatter;

use Illuminate\Database\Eloquent\Model;

class AdminField extends Model
{
	use HasDateTimeFormatter;
    protected $table = 'admin_field';

    protected $primaryKey = 'fieldid';

    protected $fillable = [
        'pk_admin_model_id',
        'field_name_cn',
        'field_name_en',
        'field_type',
        'field_unique',
        'field_remarks',
        'is_system'
    ];


    public function adminModel()
    {
        return $this->belongsTo(AdminModel::class, 'pk_admin_model_id', 'model_id');
    }
}
