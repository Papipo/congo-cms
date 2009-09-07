# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_congo_session',
  :secret      => '6a9a69fa034a38c2a3bfb7403e0eeb2959c7f3e0a040d3425caf7a051f88e5ee62004d924dae0e91cba02841f2d3d9bc138873bb28d298296c50ef129cff1e06'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
