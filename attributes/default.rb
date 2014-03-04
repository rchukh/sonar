# General settings
default[:sonar][:name] = 'sonar'
default[:sonar][:install_path]       = "/opt/sonar"
default[:sonar][:version]   = "4.1.2"

default[:sonar][:checksum] =
    case node[:sonar][:version]
      when '3.7' then '6abcfa94ffa46a130a1193ed448917fd1bfbc12499ae505baf0b88e09df5b292'
      when '4.1.2' then '3789f35c18ccb5c4d141140bed31e6b54a68c986c98ee3e7ad0fc56374e96d0c'
    end

default[:sonar][:os_kernel] = "linux-x86-64"
default[:sonar][:mirror]    = "http://dist.sonar.codehaus.org"
default[:sonar][:plugins_repo]    = "http://repository.codehaus.org/org/codehaus/sonar-plugins"
default[:sonar][:plugins_dir]    = "extensions/plugins"
default[:sonar][:plugins]    = {}

# when version is higher than 3.7 the value /sonar should be renamed to /sonarqube
default[:sonar][:download_url] = "#{node[:sonar][:mirror]}/sonarqube-#{node[:sonar][:version]}.zip"
default[:sonar][:user] = 'sonar'
default[:sonar][:group] = 'sonar'
default[:sonar][:home_path] = '/home/sonar'

# Web settings
# The default listen port is 9000, the default context path is / and Sonar listens by default to all network interfaces : '0.0.0.0'.
# Once launched, the Sonar web server is available on http://localhost:9000. Parameters can be changed into the file conf/sonar.properties.
# Here is an example to listen to http://localhost:80/sonar:
default[:sonar][:web_host]               = "0.0.0.0"
default[:sonar][:web_port]               = "9000"
default[:sonar][:web_domain]             = "sonar.example.com"
default[:sonar][:web_context]            = "/"
default[:sonar][:web_template]           = "default"

## Database settings
default[:sonar][:database][:type] = 'mysql'
default[:sonar][:database][:host] = 'localhost'
default[:sonar][:database][:port] = 3306
default[:sonar][:database][:name] = 'sonar'
default[:sonar][:database][:user] = 'sonar'
default[:sonar][:database][:password] = 'sonar'

# Wrapper settings eg. for performance improvements
# @see http://docs.codehaus.org/display/SONAR/Performances
default[:sonar][:java_additional]        = "-server"
default[:sonar][:java_initmemory]        = "256"
default[:sonar][:java_maxmemory]         = "512"
default[:sonar][:java_maxpermsize]       = "128m"
default[:sonar][:java_command]           = "java"
default[:sonar][:logfile_maxsize]        = "0"
default[:sonar][:syslog_loglevel]        = "NONE"

default[:sonar][:options]                = {
   #'crowd.password:'                           => 'sonar',
   #'crowd.url:'                                => 'https://www9.klm.com/corporate/pse/crowd/services/',
   #'sonar.authenticator.class:'                => 'org.sonar.plugins.crowd.CrowdAuthenticator',
   #'sonar.authenticator.createUsers:'          => true,
   #'sonar.authenticator.ignoreStartupFailure:' => true
   }

# backup to s3
default[:sonar][:backup][:enabled] = true
default[:sonar][:backup][:s3_access_key_id] = "BN588NGSSFPKQHD1NX21"
default[:sonar][:backup][:s3_secret_access_key] = "8abEbk+jZyx3c9Td2etAMO031bkXmqQEGjET8WcE"
default[:sonar][:backup][:s3_bucket] = "backups"
