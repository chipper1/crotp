# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.1.3] - 2018-05-27

### Added

- Added `authenticator_uri` to `HOTP` and `TOTP` objects to generate URIs for 2FA authenticator apps.
- Added `base32_secret` to both objects so that users who can't use the URI or QR code can copy the base32 secret to their authenticator app.

## [0.1.2] - 2018-05-26

### Added

- Added an `allowed_drift` to `verify` methods so that codes can be valid longer.

## [0.1.1] - 2017-01-10

### Changed

- Replaced implementation of `int_to_bytes` with `IO::ByteFormat::LittleEndian.encode` thanks to [@benoist](https://github.com/benoist)

## [0.1.0] - 2017-01-07

### Added

- Initial implementation of HOTP and TOTP.
