Sequel.migration do
  change do
    create_table(:users) do
      primary_key :user_id
      String :username, :null=>false, :unique=>true
      String :email, :null=>false
      String :password, :null=>false
    end
    create_table(:locations) do
      primary_key :location_id
      String :name, :null=>false
      String :how_to_find, :null=>false
      String :place_id, :null=>false
    end
    create_table(:reviews) do
      primary_key :review_id
      foreign_key :location_id, :locations, :null=>false
      Integer :rating, :null=>false
      String :reivew_text, :text=>true, :null=>false
      String :who_posted, :null=>false
    end
  end
end
