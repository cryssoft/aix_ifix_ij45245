#
#-------------------------------------------------------------------------------
#
#  From Advisory.asc:
#
#    Fileset                 Lower Level  Upper Level KEY 
#    ---------------------------------------------------------
#    bos.mp64                7.1.5.0      7.1.5.47    key_w_fs
#    bos.rte.serv_aid        7.1.5.0      7.1.5.36    key_w_fs
#    bos.sysmgt.serv_aid     7.1.5.0      7.1.5.35    key_w_fs
#    bos.mp64                7.2.5.0      7.2.5.6     key_w_fs
#    bos.rte.serv_aid        7.2.5.0      7.2.5.4     key_w_fs
#    bos.sysmgt.serv_aid     7.2.5.0      7.2.5.3     key_w_fs
#    bos.mp64                7.2.5.100    7.2.5.106   key_w_fs
#    bos.rte.serv_aid        7.2.5.100    7.2.5.102   key_w_fs
#    bos.sysmgt.serv_aid     7.2.5.100    7.2.5.102   key_w_fs
#    bos.mp64                7.2.5.200    7.2.5.201   key_w_fs
#    bos.rte.serv_aid        7.2.5.200    7.2.5.200   key_w_fs
#    bos.sysmgt.serv_aid     7.2.5.200    7.2.5.200   key_w_fs
#    bos.mp64                7.3.0.0      7.3.0.4     key_w_fs
#    bos.rte.serv_aid        7.3.0.0      7.3.0.2     key_w_fs
#    bos.sysmgt.serv_aid     7.3.0.0      7.3.0.1     key_w_fs
#    bos.mp64                7.3.1.0      7.3.1.1     key_w_fs
#    bos.rte.serv_aid        7.3.1.0      7.3.1.1     key_w_fs
#    bos.sysmgt.serv_aid     7.3.1.0      7.3.1.0     key_w_fs
#    
#    AIX Level APAR     Availability  SP        KEY
#    -----------------------------------------------------
#    7.1.5     IJ45981  **            SP12      key_w_apar
#    7.2.5     IJ45245  **            SP06      key_w_apar
#    7.3.0     IJ45997  **            SP04      key_w_apar
#    7.3.1     IJ45246  **            SP02      key_w_apar
#    
#    VIOS Level APAR    Availability  SP        KEY
#    -----------------------------------------------------
#    3.1.2      IJ46110 **            3.1.2.60  key_w_apar
#    3.1.3      IJ46051 **            3.1.3.40  key_w_apar
#    3.1.4      IJ45245 **            3.1.4.20  key_w_apar
#    
#    AIX Level  Interim Fix (*.Z)         KEY
#    ----------------------------------------------
#    7.1.5.9    IJ45981s9a.230324.epkg.Z  key_w_fix
#    7.1.5.10   IJ45981sAa.230323.epkg.Z  key_w_fix
#    7.1.5.11   IJ45981sBa.230323.epkg.Z  key_w_fix
#    7.2.5.3    IJ45245s3a.230324.epkg.Z  key_w_fix  <<-- covered here
#    7.2.5.4    IJ45245s4a.230324.epkg.Z  key_w_fix  <<-- covered here
#    7.2.5.5    IJ45245s5a.230322.epkg.Z  key_w_fix  <<-- covered here
#    7.3.0.1    IJ45997s1a.230322.epkg.Z  key_w_fix
#    7.3.0.2    IJ45997s2a.230322.epkg.Z  key_w_fix
#    7.3.0.3    IJ45997s3a.230322.epkg.Z  key_w_fix
#    7.3.1.1    IJ45246s1a.230322.epkg.Z  key_w_fix
#    
#    Please note that the above table refers to AIX TL/SP level as
#    opposed to fileset level, i.e., 7.2.5.4 is AIX 7200-05-04.
#    
#    VIOS Level  Interim Fix (*.Z)         KEY
#    --------------------------------------------
#    3.1.2.30    IJ46110s3a.230323.epkg.Z  key_w_fix
#    3.1.2.40    IJ46110s4a.230323.epkg.Z  key_w_fix
#    3.1.2.50    IJ46110s5a.230323.epkg.Z  key_w_fix
#    3.1.3.14    IJ46051s1a.230323.epkg.Z  key_w_fix  <<-- covered elsewhere
#    3.1.3.21    IJ46051s2a.230323.epkg.Z  key_w_fix
#    3.1.3.30    IJ46051s3a.230323.epkg.Z  key_w_fix
#    3.1.4.10    IJ45245s5a.230322.epkg.Z  key_w_fix  <<-- covered here
#
#-------------------------------------------------------------------------------
#
class aix_ifix_ij45245 {

    #  Make sure we can get to the ::staging module (deprecated ?)
    include ::staging

    #  This only applies to AIX and maybe VIOS in later versions
    if ($::facts['osfamily'] == 'AIX') {

        #  Set the ifix ID up here to be used later in various names
        $ifixName = 'IJ45245'

        #  Make sure we create/manage the ifix staging directory
        require aix_file_opt_ifixes

        #
        #  For now, this one only impacts VIOS, but I don't know why.
        #
        if ($::facts['aix_vios']['is_vios']) {
            #
            #  Friggin' IBM...  The ifix ID that we find and capture in the fact has the
            #  suffix allready applied.
            #
            if ($::facts['aix_vios']['version'] in ['3.1.4.10']) {
                $ifixSuffix = 's5a'
                $ifixBuildDate = '230322'
            }
            else {
                $ifixSuffix = 'unknown'
                $ifixBuildDate = 'unknown'
            }
        }
        else {
            #
            #  Friggin' IBM...  The ifix ID that we find and capture in the fact has the
            #  suffix allready applied.
            #
            if ($::facts['kernelrelease'] == '7200-05-03-2148') {
                $ifixSuffix = 's3a'
                $ifixBuildDate = '230324'
            }
            else {
                if ($::facts['kernelrelease'] == '7200-05-04-2220') {
                    $ifixSuffix = 's4a'
                    $ifixBuildDate = '230324'
                }
                else {
                    if ($::facts['kernelrelease'] == '7200-05-05-2246') {
                        $ifixSuffix = 's5a'
                        $ifixBuildDate = '230322'
                    }
                    else {
                        $ifixSuffix = 'unknown'
                        $ifixBuildDate = 'unknown'
                    }
                }
            }
        }

        #  Add the name and suffix to make something we can find in the fact
        $ifixFullName = "${ifixName}${ifixSuffix}"

        #  If we set our $ifixSuffix and $ifixBuildDate, we'll continue
        if (($ifixSuffix != 'unknown') and ($ifixBuildDate != 'unknown')) {

            #  Don't bother with this if it's already showing up installed
            unless ($ifixFullName in $::facts['aix_ifix']['hash'].keys) {
 
                #  Build up the complete name of the ifix staging source and target
                $ifixStagingSource = "puppet:///modules/aix_ifix_ij45245/${ifixName}${ifixSuffix}.${ifixBuildDate}.epkg.Z"
                $ifixStagingTarget = "/opt/ifixes/${ifixName}${ifixSuffix}.${ifixBuildDate}.epkg.Z"

                #  Stage it
                staging::file { "$ifixStagingSource" :
                    source  => "$ifixStagingSource",
                    target  => "$ifixStagingTarget",
                    notify  => Exec["emgr-install-${ifixName}"],
                }

                #  GAG!  Use an exec resource to install it, since we have no other option yet
                exec { "emgr-install-${ifixName}":
                    path     => '/bin:/sbin:/usr/bin:/usr/sbin:/etc',
                    command  => "/usr/sbin/emgr -e $ifixStagingTarget",
                    unless   => "/usr/sbin/emgr -l -L $ifixFullName",
                    notify   => Exec['run errstop'],
                    refreshonly => true,
                }

                exec { "run errstop":
                    path     => '/bin:/sbin:/usr/bin:/usr/sbin:/etc',
                    command  => "/usr/lib/errstop",
                    notify   => Exec['run errdemon'],
                    refreshonly => true,
                }

                exec { "run errdemon":
                    path     => '/bin:/sbin:/usr/bin:/usr/sbin:/etc',
                    command  => "/usr/lib/errdemon",
                    refreshonly => true,
                }

                #  Explicitly define the dependency relationships between our resources
                File['/opt/ifixes']->Staging::File["$ifixStagingSource"]->Exec["emgr-install-${ifixName}"]
                Exec["emgr-install-${ifixName}"]~>Exec['run errstop']
                Exec["emgr-install-${ifixName}"]~>Exec['run errdemon']
                Exec['run errstop']~>Exec['run errdemon']

            }

        }

    }

}
