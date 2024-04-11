# CHANGELOG

## v0.1.10
Resolved [#7](https://github.com/SamuraiAku/PkgToSoftwareBOM.jl/issues/7), Fill in Declared License field in SBOM
* Uses LicenseCheck.jl to scan packages and artifacts for license files and licenses embedded in source files.
* Also fill in package field License Info From Files.

## v0.1.9
Update SPDX package compatibility to v0.4.  This update enables the following:
* Updates the algorithm for computing the package verification code to a hopefully correct implementation.
* Allows the computation of artifact verification codes, since it is now able to ignore bad symbolic links.

## v0.1.8
Resolved [#2](https://github.com/SamuraiAku/PkgToSoftwareBOM.jl/issues/2), Include artifacts in the SBOM

Resolved [#22](https://github.com/SamuraiAku/PkgToSoftwareBOM.jl/issues/22), Document the version of Julia used to produce the SBOM

## v0.1.7
Resolved [#15](https://github.com/SamuraiAku/PkgToSoftwareBOM.jl/issues/15), Avoid using Pkg internals

Resolved [#23](https://github.com/SamuraiAku/PkgToSoftwareBOM.jl/issues/23), Export SPDX when loading PkgToSoftwareBOM

Improvements to code coverage tests
