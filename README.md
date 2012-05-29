puppet-grails
=============

Puppet module to install any version of grails. 
Depends on:
  * Osoco's Wget puppet module: https://github.com/osoco/puppet-wget

Example of usage:

    class my_class_that_needs_grails {
        grails { "grails-1.3.5":
            version => '1.3.5',
            destination => '/opt'
        }

        grails { "grails-2.0.0":
            version => '2.0.0',
            destination => '/opt'
        }
    }
