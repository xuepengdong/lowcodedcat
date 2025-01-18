<?php

use Illuminate\Routing\Router;
use Illuminate\Support\Facades\Route;
use Dcat\Admin\Admin;
//use App\Admin\Controllers\AdminFieldController;
//use App\Admin\Controllers\AdminPageController;
use App\Admin\Controllers\ListController;
use App\Admin\Controllers\PageSettingController;

Admin::routes();

Route::group([
    'prefix'     => config('admin.route.prefix'),
    'namespace'  => config('admin.route.namespace'),
    'middleware' => config('admin.route.middleware'),
], function (Router $router) {

    $router->get('/', 'HomeController@index');
    $router->resource('model', 'AdminModelController');
//    $router->resource('admin_fields', AdminFieldController::class);
    $router->resource('admin_fields','AdminFieldController');
    $router->resource('admin_page', 'AdminPageController');
//    $router->resource('admin_list', 'ListController');
    $router->get('admin_list', [ListController::class, 'index'])->name('admin.list');
    $router->get('admin_pageSetting', [PageSettingController::class, 'index'])->name('admin.pagesetting');

});
