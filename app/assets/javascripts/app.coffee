catalog = angular.module('catalog', [
  'templates'
  'ui.router'
  'ngResource'
  'angular-flash.service'
  'angular-flash.flash-alert-directive'
])
catalog.factory 'Product', [
  '$resource'
  ($resource) ->
    $resource '/api/products/:id', { id: '@id' },
      index:
        method: 'GET'
        isArray: true
        responseType: 'json'
      update:
        method: 'PUT'
        responseType: 'json'
]
#factory for show method
catalog.factory 'OneProduct', [
  '$resource'
  ($resource) ->
    $resource '/api/products/:itemId', id: '@id'
]
catalog.controller 'ShowController', [
  '$scope'
  'OneProduct'
  '$stateParams'
  'flash'
  ($scope, OneProduct, $stateParams, flash) ->
    #get the product from the server
    OneProduct.get { itemId: $stateParams.itemId }, ((product) ->
      $scope.product = product
    ), (httpResponse) ->
      $scope.product = null
      flash.error = 'There is no product with ID ' + $stateParams.itemId
]

catalog.controller 'EditController',[
  '$scope',
  'OneProduct',
  'Product',
  '$stateParams',
  '$state',
  ($scope, OneProduct, Product, $stateParams, $state) ->

    product = OneProduct.get({itemId: $stateParams.itemId})

    $scope.product= product
    
    $scope.editProduct = ->
      if $scope.productForm.$valid
        editedProduct = $scope.newProduct
        product.name = editedProduct.name
        product.description = editedProduct.description
        product.price = editedProduct.price
        Product.update product
        $state.go 'index'
        return
]

catalog.controller 'ProductsController', [
  '$scope'
  'Product'
  '$state'
  ($scope, Product, $state) ->
    $scope.products = Product.index()

    $scope.addProduct = ->
      if $scope.productForm.$valid
        product = Product.save($scope.newProduct)
        $scope.products.push product
        $scope.newProduct = {}
        $state.go 'index'
      return

    $scope.deleteProduct = (index) ->
      product = $scope.products[index]
      Product.delete product
      $scope.products.splice index, 1
      return

    return
]

catalog.config [
  '$stateProvider'
  '$urlRouterProvider'
  'flashProvider',
  ($stateProvider, $urlRouterProvider, flashProvider) ->
    flashProvider.errorClassnames.push 'alert-danger'
    flashProvider.warnClassnames.push 'alert-warning'
    flashProvider.infoClassnames.push 'alert-info'
    flashProvider.successClassnames.push 'alert-success'
    $urlRouterProvider.otherwise '/'
    $stateProvider.state('index',
      url: '/'
      templateUrl: 'index.html'
      controller: 'ProductsController').state('show',
      url: '/:itemId'
      templateUrl: 'show.html'
      controller: 'ShowController').state('new',
      url: '/products/new'
      templateUrl: 'new.html'
      controller: 'ProductsController').state('edit',
      url: '/products/edit/:itemId'
      templateUrl: 'edit.html'
      controller: 'EditController'
      )
    return
]
