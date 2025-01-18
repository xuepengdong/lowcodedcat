<?php

namespace App\Models;

use Dcat\Admin\Traits\HasDateTimeFormatter;

use Illuminate\Database\Eloquent\Model;

class AdminPageField extends Model
{
	use HasDateTimeFormatter;
    protected $table = 'admin_page_field';

    protected $primaryKey = 'admin_page_field_id';

    public $timestamps = false;

}
