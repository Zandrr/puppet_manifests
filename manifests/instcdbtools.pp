##instcdbtools.pp
define  cdbtools::instcdbtools{
                $_cdbtoolspath = "/opt/cdbtools"

        file{"$_cdbtoolspath":
                ensure => directory,
        }

        exec{"cdbtools cln":
                command => "rm -rf /tmp/cdbfasta;",
                refreshonly => true,
        }

        exec{"inst cdbtools":
                command => "tar -zxf $_instbase/cdbtools/cdbfasta.tar.gz -C /tmp; cd /tmp/cdbfasta; make; mv cdbfasta cdbyank /opt/cdbtools; ",
                require => File["$_cdbtoolspath"],
                creates => "/opt/cdbtools/cdbyank",
                notify => Exec["cdbtools cln"],
        }

        modules::module{"cdbtools":
                filename => "cdbtools",
                version => "",
                path => "$_cdbtoolspath",
        }
}