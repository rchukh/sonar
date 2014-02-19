include_recipe "backup"

backup_install node.name
backup_generate_config node.name

backup_generate_model "database" do
  description "Our shard"
  backup_type "database"
  database_type "MySQL"
  store_with({"engine" => "S3", "settings" => { "s3.access_key_id" => "#{node[:sonar][:backup][:s3_access_key_id]}", "s3.secret_access_key" => "#{node[:sonar][:backup][:s3_secret_access_key]}", "s3.bucket" => "#{node[:sonar][:backup][:bucket]}", "s3.path" => "sonar-database", "s3.keep" => 5, "s3.fog_options" => {  :host => 's3.eden.klm.com', :scheme => 'http', :port => 80 } } } )
  options({"db.host" => "\"localhost\"", "db.username" => "\"#{node[:sonar][:database][:user]}\"", "db.password" => "\"#{node[:sonar][:database][:password]}\"", "db.name" => "\"#{node[:sonar][:database][:name]}\""})
  action :backup
end