<?php

namespace App\Admin\Repositories;

use App\Models\AdminPage as Model;
use Dcat\Admin\Repositories\EloquentRepository;

class AdminPage extends EloquentRepository
{
    /**
     * Model.
     *
     * @var string
     */
    protected $eloquentClass = Model::class;
}
