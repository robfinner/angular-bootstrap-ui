
###
modal. Restrict class. Options:
	ng-model (scope-variable, optional, default=none)
	  If ng-model is NOT set, this will behave like a normal
	  bootstrap modal, except backdrop/keyboard options will be used
	  If ng-model IS set, the value will be set to true whenever the
	  modal is open, and false when it is closed.
	  Additionally, you may set it to true to open the
	  modal and set it to false to close it.
	backdrop: (boolean, optional, default=true)
	  Decides whether the modal has a backdrop when opening
	keyboard: (boolean, optional, default=true)
	  Decides whether the modal can be closed with escape key	

Example usage, showing both ways of opening/closing the modal:
<div id="myModal" class="modal hide" ng-model="modalVariable">
	<button ng-click="modalVariable = false">Close Modal</button>
</div>
<a href="#myModal" data-toggle="modal">Open Modal</a>
###
angular.module('angularBootstrap.modal', [])
.directive('modal', [ '$timeout', ($timeout) ->
	$ = jQuery
	return {
		restrict: 'C'
		require: '?ngModel'
		scope:
			backdrop: 'evaluate'
			keyboard: 'evaluate'
			ngModel: 'accessor'
		link: (scope, elm, attrs, model) ->
			# Initially set options but don't show
			$(elm).modal backdrop: scope.backdrop, keyboard: scope.keyboard, show: false

			# If model wasn't set, it's just a regular bootstrap modal (we set the options already above),
			# and we return
			return unless model?

			scope.$watch (->scope.ngModel()), (value) ->
				if value is true
					$(elm).modal 'show'
				else
					$(elm).modal 'hide'

			$(elm).bind 'shown', ->
				$timeout -> scope.ngModel true
			$(elm).bind 'hidden', ->
				$timeout -> scope.ngModel false
	}
])