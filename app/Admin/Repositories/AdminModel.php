<?php

namespace App\Admin\Repositories;

use App\Models\AdminModel as Model;
use Dcat\Admin\Repositories\EloquentRepository;

class AdminModel extends EloquentRepository
{
    /**
     * Model.
     *
     * @var string
     */
    protected $eloquentClass = Model::class;
}
