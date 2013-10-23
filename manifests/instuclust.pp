##instuclust.pp

define uclust::instuclust($version='1.2.22'){
        $_version = $version

        $_uclustpath = "/opt/uclust/$_version"

        file{["/opt/uclust/","/opt/uclust/$_version"]:
                ensure => directory,
        }

        file{"/opt/uclust/$_version/uclust":
                require => File["/opt/uclust/$_version"],
                source => "$_instbase/uclust/uclustq${_version}_i86linux64",
                mode => 755,
                owner => root,
                group => root,
        }

        modules::module{"uclust-$_version":
                filename => "uclust",
                version => $_version,
                path => "$_uclustpath",
        }


}