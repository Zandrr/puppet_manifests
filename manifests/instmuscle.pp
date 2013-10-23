##instmuscle.pp

define muscle::instmuscle($version = '3.8.31') {
        $_musclepath = "/opt/muscle/$version"

        $_version = $version

        file{["/opt/muscle/", "/opt/muscle/$_version"]:
                ensure => directory,
        }

        file {"/opt/muscle/$_version/muscle":
                require => File["/opt/muscle/$_version"],
                source => "$_instbase/muscle/muscle${_version}_i86linux64",
                owner => root,
                group => root,
                mode => 755,
        }

        modules::module{"muscle_$_version":
                filename =>"muscle",
                version => $_version,
                path => "$_musclepath",
        }


}