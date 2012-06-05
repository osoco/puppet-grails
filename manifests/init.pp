define grails ($version, $destination, $user = "root") {

    include wget

    if !defined(File["$destination"]) {
        file { "$destination":
            ensure => 'directory',
            owner => "$user",
            group => "$user",
            mode => '0755'
        }
    }

    if !defined(Package['unzip']) {
        package { "unzip":
            ensure => latest
        }
    }

    if "$version" =~ /(1.3.[6-9]|2.*)/ {
       $base_url = "http://dist.springframework.org.s3.amazonaws.com/release/GRAILS"
    }
    else {
       $base_url = "http://dist.codehaus.org/grails"
    }
    notify { "The base url for grails $version is '$base_url'": }

    if !defined(Wget::Fetch["grails-$version-download"]) {
        wget::fetch { "grails-$version-download":
            source => "$base_url/grails-$version.zip",
            destination => "$destination/grails-$version.zip",
            require => File["$destination"]
        }

        exec { "unzip-grails-$version":
            command => "unzip grails-$version.zip",
            cwd => "$destination",
            creates => "$destination/grails-$version",
            require => [Wget::Fetch["grails-$version-download"], Package['unzip']],
        }
    }
}
