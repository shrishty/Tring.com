var phoneBrandList = angular.module('phoneBrandList', ['ngRoute']);

phoneBrandList.config(function($routeProvider) {
    $routeProvider.
      when('/product', {
        templateUrl: 'static/product.html',
        controller: 'PhoneListCtrl'
      })
      .when('/feature', {
      	templateUrl: 'static/product.html',
      	controller: 'PhoneListCtrl'
      })
      .when('/brand', {
      	templateUrl: 'static/product.html',
      	controller: 'PhoneListCtrl'
      })
      .when('/price', {
      	templateUrl: 'static/product.html',
      	controller: 'PhoneListCtrl'
      })
      .when('/category', {
      	templateUrl: 'static/product.html',
      	controller: 'PhoneListCtrl'
      })
      .when('/user', {
      	templateUrl:'static/user.html',
      	controller: 'UserListCtrl'
      })
      .otherwise({
        redirectTo: '/product',
        controller: 'PhoneListCtrl'
      });
  });

phoneBrandList.controller('UserListCtrl', function($scope) {
	console.log('in UserListCtrl')
 
})

phoneBrandList.controller('TabCtrl', function($scope, $location) {
	$scope.isActive = function(route) {
		return route === $location.path()
	}
})

phoneBrandList.controller('PhoneListCtrl', function($scope , $http) {
	$scope.currentPhoneRow = -1
	$scope.currentBrandRow = -1
	$scope.currentFeatureRow = -1
	$scope.currentCategoryRow = -1
	$scope.currentCostRow = -1

	$scope.costRange  = [

		{
			"id": 1,
			"range1": 0,
			"range2": 5000
		},
		{
			"id": 2,
			"range1": 5001,
			"range2": 10000
		},
		{
			"id": 3,
			"range1": 10001,
			"range2": 15000
		},
		{
			"id": 4,
			"range1": 15001,
			"range2": 20000
		},
		{
			"id": 5,
			"range1": 20001,
			"range2": 25000
		},
		{
			"id": 6,
			"range1": 25001,
			"range2": 30000
		},
		{
			"id": 7,
			"range1": 30001,
			"range2": 35000
		},
		{
			"id": 8,
			"range1": 35001,
			"range2": 40000,
		},
		{
			"id": 9,
			"range1": 40001,
			"range2": 45000
		},
		{
			"id": 10,
			"range1": 45001,
			"range2": 50000
		},
		{
			"id": 11,
			"range1": 50001,
			"range2": 55000
		},
		{
			"id": 12,
			"range1": 55001,
			"range2": 60000
		},
		{
			"id": 13,
			"range1": 60001,
			"range2": 65000
		},
		{
			"id": 14,
			"range1": 65001,
			"range2": 70000
		}]

	$http.get("http://localhost:6543/brand").success(function(data) {
		$scope.brands = data
		console.log(data)
	}).error(function(){
		console.log("ERROR")
	})

	$http.get("http://localhost:6543/product").success(function(data) {
		$scope.phones = data
		console.log(data)

		if($scope.currentFeatureRow == -1){
			$scope.featureProducts = data
			console.log("here")
		}
		if($scope.currentCategoryRow == -1){
			$scope.categoryProducts = data
			console.log("here")	
		}
		if($scope.currentCostRow == -1){
			$scope.productInCostRange = data
		}
	}).error(function(){
		console.log("ERROR")
	})

	$http.get("http://localhost:6543/feature").success(function(data) {
		$scope.features = data
		console.log(data)
	}).error(function(){
		console.log("ERROR")
	})

	$scope.setProductsTobeListedbyCategory = function() {
		console.log($scope.categories[$scope.currentCategoryRow])
		var url = "http://localhost:6543/category/"+$scope.categories[$scope.currentCategoryRow].id
		console.log(url)
		$http.get(url).success(function(data) {
			$scope.categoryProducts = data
			console.log(data)
		}).error(function(){
			console.log("ERROR")
		})		
	}

	$http.get("http://localhost:6543/category").success(function(data) {
		$scope.categories = data
		console.log(data)
	}).error(function(){
		console.log("ERROR")
	})

	$scope.setProductsTobeListed = function() {
		var url = "http://localhost:6543/feature/"+$scope.features[$scope.currentFeatureRow].feature_id
		console.log(url)
		$http.get(url).success(function(data) {
			$scope.featureProducts = data
			console.log(data)
		}).error(function(){
			console.log("ERROR")
		})		
	}

	$scope.setProductsTobeListedbyCostRange = function() {
		var url = "http://localhost:6543/price+from="+$scope.costRange[$scope.currentCostRow].range1+"&to="+$scope.costRange[$scope.currentCostRow].range2
		console.log(url)
		$http.get(url).success(function(data) {
			$scope.productInCostRange = data
			console.log(data)
		}).error(function(){
			console.log("ERROR")
		})	
	}

	$scope.removePhone = function(){
		$http.delete("http://localhost:6543/delete/product/"+$scope.phones[$scope.currentPhoneRow].id)
	}

	$scope.editDetails = function(){
		var os = document.getElementById("os").value
		var brand = document.getElementById("phonebrand").value
		var model = document.getElementById("model").value
		$scope.phones[$scope.currentPhoneRow] = {"brand": brand, "model": model, "os":os}
	}

	$scope.editProduct = function() {	
		// var name = document.getElementById("editname").value
		console.log($scope.currentPhoneRow)
		var name = $scope.phones[$scope.currentPhoneRow].name
		var price = $scope.phones[$scope.currentPhoneRow].price
		var brand = $scope.phones[$scope.currentPhoneRow].brand_id
		var category = $scope.phones[$scope.currentPhoneRow].category_id
		var warranty = $scope.phones[$scope.currentPhoneRow].warranty	
		var quantity = $scope.phones[$scope.currentPhoneRow].quantity
		var data = {"name":name, "brand_id":brand, "price":price, "warranty":warranty,"quantity":quantity, "category":category}
		console.log(data)
		$http.put("http://localhost:6543/edit/product/"+$scope.phones[$scope.currentPhoneRow].id, data)
	}

	$scope.addBrand = function() {
		var brand = document.getElementById("newbrand").value
		var newbrand = {"name": brand}
		$http.post("http://localhost:6543/add/brand", newbrand)
		$scope.brands.push(newbrand)
		console.log(newbrand)
	}

	$scope.addCategory = function() {
		var category = document.getElementById("newcategory").value
		var newcategory = {"name": category}
		$http.post("http://localhost:6543/add/category", newcategory)
		$scope.categories.push(newcategory)
	}

	$scope.selectBrand = function(brand_id) {
		var element = document.getElementById('editbrand')
		element.value = brand_id
	}

	$scope.addPhone = function() {
		var name = document.getElementById("addname").name	
		var price = document.getElementById("addprice").price	
		var brand = document.getElementById("addbrand").brand
		var category = document.getElementById("addcategory").category
		var warranty = document.getElementById("addwarranty").warranty
		var quantity = document.getElementById("addquantity").quantity
		var data = {"name":name, "brand_id":brand, "price":price, "warranty":warranty,"quantity":quantity, "category":category}
		// $scope.phones.push(data)
		$http.post("http://localhost:6543/add/product", data)
		console.log($scope.phones)
	}

	$scope.addFeature = function() {
		var feature = document.getElementById("addfeaturename").value
		var data1 = {'name': feature}
		$http.post("http://localhost:6543/add/feature", data1)
		var data = {'feature_name': feature}
		$scope.features.push(data)
		console.log($scope.features[$scope.features.length - 1])
	}

	$scope.filterByBrand = function(currPhone){
		if($scope.currentBrandRow == -1)
			return true
		if(currPhone.brand == $scope.brands[$scope.currentBrandRow].name)
			return true
		else
			return false
	}

	$scope.filterByFeature = function(currPhone) {

	}

	$scope.setValuesOnClick = function(phoneID){
		var index
		for(var i = $scope.phones.length - 1; i > -1; i--)
			if($scope.phones[i].id == phoneID)
				index = i
		$scope.currentPhoneRow = index
		console.log("here"+$scope.currentPhoneRow + " " + $scope.currentPhoneRow)
		$('document').ready(function(){
				$(".aaaaa").popover({
					trigger:'click',
					html: true,
					content: function(){
						return $('#testing').html();
				}
			})
		})
	}

	$scope.setValueBrand = function(phoneBrand){
		var index
		for(var i = $scope.brands.length - 1; i > -1; i--)
			if($scope.brands[i].name == phoneBrand)
				index = i
		$scope.currentBrandRow = index
 	}

 	$scope.setValueCostRange = function(costId) {
 		var index
 		for(var i = 0; i < $scope.costRange.length; i++)
 			if($scope.costRange[i].id == costId)
 				index = i;
 		$scope.currentCostRow = index
 	}
	$scope.setValueFeature = function(featureId) {
		var index
		for(var i=0; i < $scope.features.length; i++)
			if($scope.features[i].feature_id === featureId){
				index = i
				console.log("bale")
			}
		$scope.currentFeatureRow = index
	}

	$scope.setValueCategory = function(categoryId) {
		var index
		for(var i=0; i < $scope.categories.length; i++)
			if($scope.categories[i].id === categoryId){
				index = i
				console.log("hoho")
			}
		$scope.currentCategoryRow = index 
		console.log("category row: " + $scope.currentCategoryRow)
	}

	$scope.makeActive = function() {
		// console.log($scope.brands[$scope.currentBrandRow].val)
		// var temp = document.getElementById($scope.brands[$scope.currentBrandRow].val)
		// console.log("haaaaaaaaaaa" + temp)
		// document.getElementById($scope.brands[$scope.currentBrandRow].val).class = "list-group-item ng-binding ng-scope active"
	}

	$scope.fetch = function() {
		console.log("hajads")
		$http.get("http://localhost:6543/user").success(function(response) {
			console.log("haha" + response[0].id)
			document.getElementById("angular").innerHTML = response[0].name
		}).error(function(){
			console.log("ERROR")
		})
	}	

})


