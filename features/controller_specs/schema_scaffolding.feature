Feature: schema scaffolding

  Scenario: scaffold a json schema for a "users/show" in controller spec
    Given a file named "spec/controllers/api/v1/users_controller_spec.rb" with:
      """ruby
      require "spec_helper"

      describe Api::V1::UsersController, :lurker do
        render_views

        let!(:user) do
          User.where(name: 'razum2um').first_or_create!
        end

        it "shows user" do
          get :show, id: user.id
          expect(response).to be_success
        end
      end
      """

  When I run `bin/rspec spec/controllers/api/v1/users_controller_spec.rb`
  Then the example should pass
  Then a file named "lurker/api/v1/users/__id-GET.json.yml" should exist
  Then the file "lurker/api/v1/users/__id-GET.json.yml" should contain exactly:
    """yml
    ---
    description: user
    prefix: users management
    requestParameters:
      properties:
        id:
          description: ''
          type: integer
          example: 1
      required: []
    responseCodes:
    - status: 200
      successful: true
      description: ''
    responseParameters:
      properties:
        id:
          description: ''
          type: integer
          example: 1
        name:
          description: ''
          type: string
          example: razum2um
      required: []
    extensions:
      method: GET
      path_info: "/api/v1/users/1"
      path_params:
        action: show
        controller: api/v1/users
        id: '1'
      suffix: ''

  """
