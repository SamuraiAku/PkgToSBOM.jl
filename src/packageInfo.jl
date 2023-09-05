# SPDX-License-Identifier: MIT

function resolve_pkgsource!(package::SpdxPackageV2, packagedata::Pkg.API.PackageInfo, registrydata::Union{Nothing, Missing, PackageRegistryInfo})
    # The location of the SPDX package's source code depend on whether Pkg is tracking the package via:
    #   1) A package registry
    #   2) Connecting directly with a git repository
    #   3) Source code on a locally accessible storage device (i.e. no source control)
    #   4) Is the locally stored code actually a registered package or code from a repository that is under development?

    if packagedata.is_tracking_registry
        # Simplest and most common case is if you are tracking a registered package
        package.DownloadLocation= SpdxDownloadLocationV2("git+$(registrydata.packageURL)@v$(packagedata.version)$(isempty(registrydata.packageSubdir) ? "" : "#"*registrydata.packageSubdir)")
        package.HomePage= registrydata.packageURL
        package.SourceInfo= "Source Code Location is supplied by the $(registrydata.registryName) registry:\n$(registrydata.registryURL)"
    elseif packagedata.is_tracking_repo
        # Next simplest case is if you are directly tracking a repository
        package.DownloadLocation= SpdxDownloadLocationV2("git+$(packagedata.git_source)@$(packagedata.git_revision)$(isempty(registrydata.packageSubdir) ? "" : "#"*registrydata.packageSubdir)")
        package.HomePage= packagedata.git_source
        package.SourceInfo= "$(packagedata.name) is directly tracking a git repository."
    elseif packagedata.is_tracking_path
        # The hard case is if you are working off a local file path.  Is it really just a path, or are you dev'ing a package?
        if registrydata isa PackageRegistryInfo
            # Then this must be a registered package under development
            package.DownloadLocation= SpdxDownloadLocationV2("git+$(registrydata.packageURL)@v$(packagedata.version)$(isempty(registrydata.packageSubdir) ? "" : "#"*registrydata.packageSubdir)")
            package.HomePage= registrydata.packageURL
            package.SourceInfo= "Source Code Location is supplied by the $(registrydata.registryName) registry:\n$(registrydata.registryURL)"
            # TODO: See if this version exists in the registry. If it already does, then that's an error/warning on this dev version
            # TODO: Think of some additional note to source info to note this was made for a package under development?
        else
            # TODO: This may be a dev'ed version of a direct track from a repository. Figure out how to determine that
            #        Until then......
            package.DownloadLocation= SpdxDownloadLocationV2("NOASSERTION")
            package.HomePage= "NOASSERTION"
            package.FileName= packagedata.source
        end
    else
        # This should not happen unless there has been a breaking change in Pkg
        error("PkgToSBOM.resolve_pkgsource!():  Unable to resolve. Maybe the Pkg source has changed in a breaking way?")
    end

    return nothing
end