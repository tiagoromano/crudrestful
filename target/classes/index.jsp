
<html ng-app="romanoproduct">
	<head>		
		<meta charset="utf-8"> 	
		<title>
			Romano Application
		</title>
		
		<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">		
		<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
		<link rel="stylesheet" href="css/style.css" >
		<link rel="stylesheet" href="css/toastr.css" >
		
		<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
		<script src="//code.jquery.com/jquery-2.2.1.min.js"></script>		
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
		<script src="js/app.js" ></script>
		<script src="js/toastr.js" ></script>
		<script src="js/jquery.maskMoney.js" ></script>
		
						
	</head>
	<body ng-controller="productController">		
		<div class="container container-table">
			<h2>Romano Application (JPA Hibernate, Jersey, Angular, H2, Maven and Bootstrap)</h2>			
		</div>		
		<div class="container container-table">										
			<table class="table table-striped">
				<tr>
					<td>
						Id
					</td>
					<td>
						Name
					</td>
					<td>
						Price
					</td>
					<td>
						Action
					</td>
				</tr>
				<tr ng-repeat="product in result">
					<td>
						{{product.id}}
					</td>
					<td>
						{{product.name}}
					</td>
					<td>
						{{product.price}}
					</td>
					<td>
						<a href="javascript:void(0)" ng-click="del(product.id)">Delete</a> |
						<a href="javascript:void(0)" ng-click="edit(product)">Edit</a>
					</td>
				</tr>
			</table>			
			<button type="button" ng-click="clear()" class="btn btn-primary">Add new product</button>
		</div>	
		<br/>
		<div class="container" id="addAlterProduct" style="display:none">
			<form class="form-inline">
				<div class="form-group">
					<label for="productName">Name</label>		    
					<input type="hidden" ng-model="product.id" >
					<input type="text" id="productName" class="form-control" data-name="name" ng-model="product.name" placeholder="Insert the name">		  		   
				</div>
				<div class="form-group">
			    	<label for="productPrice">Price</label>		    	
			    	<input type="text" id="productPrice" class="form-control" data-name="price" ng-model="product.price" placeholder="Insert the price">
				</div>
			  <button type="button" class="btn btn-default" ng-click="add()">Save</button>
			  <button type="button" class="btn btn-default" ng-click="cancel()">Cancel</button>
			</form>
		</div>		
	
	
		
	</body>
	
	<script>
	
		
		$('#productPrice').maskMoney({ thousands: '', decimal: '.'});		
		var romanoproduct = angular.module('romanoproduct',[]).factory('UserLoginResource', function($resource, $http) {
	        $http.defaults.useXDomain = true;
	        delete $http.defaults.headers.common['X-Requested-With'];	                
	    });
				
		romanoproduct.controller('productController', function($scope, $http) {
			$scope.base_url = 'http://localhost:8080/crudrestful/webapi/myresource/';
			
			$http.get($scope.base_url+'getAll').success(function(response) {
				console.log(response);
				$scope.result = response;
			});
			
			
			$scope.add = function() {				
				removeMaskIfProductBind($scope);
				if (app.checkClassFieldsError('form-control')) {						
					$http.post($scope.base_url+'create', $scope.product).success(function(response) {
						notificacaoSucesso('Success','Data stored');
						
						
						$http.get($scope.base_url+'getAll').success(function(filled) {
							console.log(filled);
							$scope.result = filled;
						});
						$('#addAlterProduct').hide();
					});
				}
			};
									
			$scope.del = function(id) {
				console.log(id);
				if (confirm('delete?')) {
					$http.delete($scope.base_url+'delete/'+id).success(function(response) {
						notificacaoSucesso('Success','Data removed');
						
						$http.get($scope.base_url+'getAll').success(function(filled) {
							console.log(filled);
							$scope.result = filled;
						});
						
					});
				}
			};
			
			$scope.edit = function(product) {
				console.log(product);
				$scope.product = product;
				$('#addAlterProduct').show();	
			};
			
			$scope.clear = function() {							
				$scope.product = null;
				$('#addAlterProduct').show();	
			};	
			$scope.cancel = function() {							
				$scope.product = null;
				$http.get($scope.base_url+'getAll').success(function(response) {
					console.log(response);
					$scope.result = response;
				});
				$('#addAlterProduct').hide();	
			};	
		});
		var removeMaskIfProductBind = function(scope) {			
			if (scope.product) 
				scope.product.price = parseFloat($('#productPrice').val());			
		}
		 
	
	</script>

	
</html>