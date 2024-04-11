<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Shopify\Auth\FileSessionStorage;
use Shopify\Context;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/', function () {
    // Context::initialize(
    //     apiKey: $_ENV['SHOPIFY_API_KEY'],
    //     apiSecretKey: $_ENV['SHOPIFY_API_SECRET'],
    //     scopes: $_ENV['SHOPIFY_APP_SCOPES'],
    //     hostName: $_ENV['SHOPIFY_APP_HOST_NAME'],
    //     sessionStorage: new FileSessionStorage('/tmp/php_sessions'),
    //     apiVersion: '2023-04',
    //     isEmbeddedApp: true,
    //     isPrivateApp: false,
    // );
    return "Hello API";
});
