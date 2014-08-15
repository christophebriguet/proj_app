require 'spec_helper'

describe 'routes for Users' do
  specify { expect(get('/admin')).to route_to('users#index', scope: 'admin') }
  specify { expect(get('/not_admin')).to route_to('users#index', scope: 'not_admin') }
  specify { expect(get('/signup')).to route_to('users#new') }
  specify { expect(get('/signin')).to route_to('sessions#new') }
  specify { expect(delete('/signout')).to route_to('sessions#destroy') }
end