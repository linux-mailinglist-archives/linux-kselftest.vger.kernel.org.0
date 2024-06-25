Return-Path: <linux-kselftest+bounces-12700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973AF916D1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 17:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5449528BE49
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559316F90D;
	Tue, 25 Jun 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyueiWsa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B816F8F4;
	Tue, 25 Jun 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329564; cv=none; b=KeqZsUuC9n6biFakVuccH3zzUM4wFJmfXu4rc21mb1wIQsbAt7Ki/QrLc+GP9Y496d7m7UKr+/gxSTp1Nye/dGoEtpqFV5Wl9TwYB3/vNpkjCfjqADeFEryMGwL/eBJndD/bv3/+m2msiOy9QsiWS3M+kEQlpUEa+uBSF45Aih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329564; c=relaxed/simple;
	bh=cq7+BrMAkAlCHKRvPkqveb4zS9P8Oq4n7IJ0yNZ13PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7spLqF54mfYjF06c0IpZPQRa1X0cyK/CKHusbha9/8oyouHp9X9Gezf7vTB1OpGHWxmOAbmBcUHsetpdqswLg4JBifL9SlQ+X6OOUdbPKyMO047U7SttHRKhrJr2pG/MRFvQr2WyGgXI7DtiBYu2sa1zILa8/LUMs4XkVbSNxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyueiWsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C21CC32781;
	Tue, 25 Jun 2024 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719329564;
	bh=cq7+BrMAkAlCHKRvPkqveb4zS9P8Oq4n7IJ0yNZ13PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EyueiWsau1nCa84s90fBc5vKKqSqQjiqhgw7Wk+CtrztedCSmayUtUT0UL4LkYCdF
	 nE3JOALfmo2hf8qF189ey6hdoUX18x+tv7gss5yDp6rRcXBPhpszAoEtjtxqDH5MVX
	 7JIdjGcPgZhBv+wmucIQyqbA1ysuYVfMTmBeznITkfq4uqYA2OtjshcfSrgr8OWadX
	 cdy/xs0ri5JFvn2IRiwopj/jXyj3aFmJ6Ntq10Bz0JuA13Mg1uubLwzH6XaSUIRf05
	 iB9u96+gWPbtL58BswewyWYzaP8zP3AR2BxvffcWSoguypp/wGAG+HjuQKYKpaMGbi
	 bYOLVZHrl30EQ==
Date: Tue, 25 Jun 2024 16:32:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	will@kernel.org, ryan.roberts@arm.com, rob.herring@arm.com,
	mark.rutland@arm.com, linux@armlinux.org.uk, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] selftests: Add build infrastructure along with
 README
Message-ID: <8bbcc081-7e0b-4cab-8312-c5a5d60f4d7d@sirena.org.uk>
References: <20240625122408.1439097-1-dev.jain@arm.com>
 <20240625122408.1439097-10-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UU48VnmcH3/0WAef"
Content-Disposition: inline
In-Reply-To: <20240625122408.1439097-10-dev.jain@arm.com>
X-Cookie: Results vary by individual.


--UU48VnmcH3/0WAef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 05:54:08PM +0530, Dev Jain wrote:

> Add arm target, individual Makefile targets, and instructions to build the
> tests, along with .gitignore files. All the Makefiles are similar to
> selftests/arm64, except abi: use TEST_CUSTOM_PROGS to override the make
> rule from lib.mk. Also, do not build ptrace_64 if we are running a
> 32-bit kernel.

Also the documentation which could probably go separately.

> +- This is a series of compatibility tests, wherein the source files are
> +  built statically into a 32 bit ELF; they should pass on both 32 and 64
> +  bit kernels. They are not built or run but just skipped completely when
> +  env-variable ARCH is found to be different than 'arm64' or 'arm' and
> +  `uname -m` reports other than 'aarch64', 'armv7l' or 'armv8l'.

These are just plain old tests for arm, the fact that we can use them to
test 32 bit mode on a 64 bit host is a nice bonus but the tests are just
as useful with actual arm hardware.

> +- If building the tests on a 64-bit kernel, please ensure that the kernel is
> +  built with CONFIG_COMPAT enabled.

Running, not building.

> +- Holding true the above, ARM KSFT tests can be run within the KSelfTest
> +  framework using standard Linux top-level-makefile targets. Please set
> +  $(CROSS_COMPILE) to 'arm-linux-gnueabi-' or 'arm-linux-gnueabihf-'.

Or whatever your toolchain is set to!  We should also consider the
LLVM=1 case here for building with clang (which is even easier as it
supports all architectures in a single binary).

> +      $ make TARGETS=arm kselftest-clean
> +      $ make $(CROSS_COMPILE) TARGETS=arm kselftest

> +      or

> +      $ make $(CROSS_COMPILE) -C tools/testing/selftests TARGETS=arm \
> +		INSTALL_PATH=<your-installation-path> install

> +      or, alternatively, only specific arm/ subtargets can be picked:

> +      $ make $(CROSS_COMPILE) -C tools/testing/selftests TARGETS=arm \
> +		ARM_SUBTARGETS="signal" INSTALL_PATH=<your-installation-path> \
> +			install

I would expect the Makefile to have machinery which if we're building
for arm64 would use CROSS_COMPILE_COMPAT here and force 32 bit builds.

> +# Do not build 64-bit programs if running on a native 32-bit kernel
> +UNAME_M := $(shell uname -m)
> +ifneq (,$(filter $(UNAME_M),aarch64 arm64))
> +TEST_CUSTOM_PROGS := $(OUTPUT)/ptrace_64

Where we're building shouldn't affect what gets run - it is very common
especially in CI systems to build on one system and then run the tests
on a completely separate machine.

--UU48VnmcH3/0WAef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ64xMACgkQJNaLcl1U
h9BY0Af8CGA4C9tw/lNUx4oUt9cjeuXWgxUbAfWEfMpOLIRAscwaks6VQ24BSuax
Unqbiuj8MKH3pn4A9OSzhvwHlzwcAWy2GXITHPs3V8S10TPpG2sQ+U1DN4dTzu8p
NyuHp6DtwrNn50tq9dM60WUkZK8zRCv4FmAtm+nRRX0KM3sxr+/afzWlLpW/5XSa
JcHlPQPelZRzvMF56SpIUs/HuB6a/UDqZ8wjePlgWRSe/NXYCXu4dpSKyPFD3cF9
5fk0K7xmFVbPk4ZACYnPTHX+CTgwLRKL5eshTxBzFytj8AVgVAGGyxJt0WG90KAt
FJzqkpIETgGu+D56E4WFAUZRMmWBdQ==
=OVR4
-----END PGP SIGNATURE-----

--UU48VnmcH3/0WAef--

