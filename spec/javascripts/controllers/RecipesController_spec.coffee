

describe "RecipesController", ->
  scope = null
  ctrl = null
  location = null
  resource= null
  routeParams = null
  httpBackend = null

  setupController =(keywords,results)->
    inject(($rootScope, $routeParams, $httpBackend, $location, $resource, $controller)->
      scope = $rootScope.$new()
      location = $location
      resource = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      httpBackend = $httpBackend

      if results
        request = new RegExp("\/recipes.*keywords=#{keywords}")
        httpBackend.expectGet(request).respond(results)

      ctrl = $controller("RecipesController",
                          $scope: scope
                          $location: location)

    )

  beforeEach(module("receta"))
  beforeEach(setupController())

  afterEach ->
    httpBackend.VerifyNoOutstandingExpectations()
    httpBackend.VerifyNoOutstandingReuests()

  describe "Controller Initialization", ->
    describe "with no keywords", ->
      it 'defaults to no recipes', ->
        beforeEach(setupController())
        expect(scope.recipes).toEqualData([])

    describe "with keywords", ->
      keywords = foo
      recipes = [
        {
          id: 2
          name: 'Baked Potatoes'
        },
        {
          id: 4
          name: 'Potatoes Au Gratin'
        }
      ]
    beforeEach ->
      setupController(keywords,recipes)
      httpBackend.flush()

    it "calls the back-end", ->
      expect(scope.recipes).toEqualData(recipes)

  describe "search()", ->
    beforeEach ->
      setupController()

    it "redirects to itself with keywords params", ->
      keywords = foo
      scope.search(keywords)
      expect(location.path()).toBe('/')
      expect(location.search()).toEqualData({keywords: keywords})
