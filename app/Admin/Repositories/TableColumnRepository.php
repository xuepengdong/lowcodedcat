<?php

namespace App\Admin\Repositories;

use Dcat\Admin\Repositories\Repository;
use Dcat\Admin\Grid\Model;
use Illuminate\Support\Collection;

class TableColumnRepository extends Repository
{
    protected $data;

    public function __construct(array $data = [])
    {
        $this->data = $data;
    }

    /**
     * 获取 Grid 所需的数据
     *
     * @param Model $model
     * @return Collection
     */
    public function get(Model $model)
    {
        // 返回一个 Collection 对象，可以将数据与模型一起处理
        return collect($this->data);
    }

    /**
     * 设置数据
     *
     * @param array $data
     */
    public function setData(array $data)
    {
        $this->data = $data;
    }
}
