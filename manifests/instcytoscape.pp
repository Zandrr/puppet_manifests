##instcytoscape.pp

define cytoscape::instcytoscape($version = ''){
        $_version = '2.7.0'
        $_cytoscapepath = "/opt/cytoscape/$_version"

        file{["/opt/cytoscape/","/opt/cytoscape/$_version"]:
                ensure => directory,
        }

        exec{"cytoscape cln $_version":
                command => "rm -rf /tmp/cytoscape-v${_version}",
                refreshonly => true,
        }

        exec{"inst cytoscape":
                command => "tar -zxf $_instbase/cytoscape/cytoscape-v2.7.0.tar.gz -C /tmp; cd /tmp/cytoscape-v${_version}; mv * /opt/cytoscape/$_version;",
                creates => "$_cytoscapepath/cytoscape.jar",
                require => File["/opt/cytoscape/$_version"],
                notify => Exec["cytoscape cln $_version"],
        }
        modules::module{"cytoscape_$_version":
                filename => "cytoscape",
                version => '2.7.0',
                path => "$_cytoscapepath",
                libpath => "$_cytoscapepath/lib",
        }
}