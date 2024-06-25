Return-Path: <linux-kselftest+bounces-12727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ECD916FFE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6741C230FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13A177991;
	Tue, 25 Jun 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDNo3AdI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679C13BC2F;
	Tue, 25 Jun 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339515; cv=none; b=F+Oou6RXN/oByawTLfcS9q0fFsm6I5YCPhT9oDCF9cN1fbpBDamwEtHxpnuzyIIJBZ57hGU9lyAmupGs1WA2xiK6MySbKOyeWAKzBtPUhmw7Af0qdFGV25vn/jj4nkXgIdQGHDCxiP1SGHTymTu4JpjURAVPtpX3uIp37gQhIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339515; c=relaxed/simple;
	bh=4+jVK0S+MamQOISweVdv2DCcLK4IzhSGIVOP18d4sss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSHYTn5SDVIhmXhCLpfvDa84fSEjAn8l+0XCWYl1FiwRNToWvSOZ3frhYWBgRUfVPWnnhJNEZkU2QL9StuRlQ3JTGTEu12BXAEFwKO/WLL/tE9SefBdPdcFkSrDOi0vKoadVJTR0A7S+EJpdxWGkDmLEN/L4780/Ih/ZyLf/gLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDNo3AdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3D5C32781;
	Tue, 25 Jun 2024 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719339514;
	bh=4+jVK0S+MamQOISweVdv2DCcLK4IzhSGIVOP18d4sss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDNo3AdIR5k8BqqYBWUhGuVovU0KMtuNzr5I3QkfSY5nijL6bxFVaUFcpAbWQAy+r
	 4SD89x4or1jVtNGsyoulRPTHCPnBU+ab332dCC3mBv8kScalM/S9UbgFWbY9ZLAs0B
	 4TQodxgauvLbq0QlU82pdDIGsJycetmHR90ZM0bUPzWuMXu+NaosNZf5neXA9hEA/6
	 9xl2hJr+XyN1OLQXYNtSg/Q7l9cpH1l2tHMaNNHUBNJrwaEEeTgZqqBxuaWwG0SmsX
	 8OzpfC9r2fbuqEnCRTuVBZOfLoolhUD16o3ovifGgxilyuQCP+9ulHXqW6OUhRqlNE
	 b/bIzlQ90hozg==
Date: Tue, 25 Jun 2024 19:18:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	will@kernel.org, ryan.roberts@arm.com, rob.herring@arm.com,
	mark.rutland@arm.com, linux@armlinux.org.uk, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] selftests/arm: Add ptrace_64 test
Message-ID: <4c6d78fb-50d7-43fd-8e1b-9619c34eab59@sirena.org.uk>
References: <20240625122408.1439097-1-dev.jain@arm.com>
 <20240625122408.1439097-9-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v8K+BpCUfsaXTN8S"
Content-Disposition: inline
In-Reply-To: <20240625122408.1439097-9-dev.jain@arm.com>
X-Cookie: Results vary by individual.


--v8K+BpCUfsaXTN8S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 05:54:07PM +0530, Dev Jain wrote:

> +static int do_child(void)
> +{
> +	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
> +		ksft_exit_fail_perror("PTRACE_TRACEME");
> +
> +	/* SIGTRAP makes the child stop after exec; do_parent() resumes it */
> +	execv("trivial_32bit_program", NULL);
> +	return EXIT_SUCCESS;
> +}

We should check that the execv() worked, one thing that can go wrong is
partially installing the tests or trying to run the tests in a different
directory to the one where everything is installed.  I'd be inclined to
specify the path as ./ too to avoid surprises.

--v8K+BpCUfsaXTN8S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ7CfQACgkQJNaLcl1U
h9Cjugf+NBk5JrbN71OALpXbujrjXWhvL9u2Y1h4h7g5CC6UYadudFYZ71Z88dEh
2YaIEOs0mh0FxpGgVrcGxv5rAEGwWBp/hH/oBosgM4khMH8ULb+QhWAdyl7MHe9W
fQ+vPuch+fbgfkxY1pspXa6jfzID2Z/KccobGDVEof6cggHdUbJPdkOUoP7ER9e9
wtOYIXNuhkzHeiwCRGhL7RbAI5mPeoYV5n5bZD1FCQzxK+MUKlVphDh42MFcaY2q
FaWMd+rB0cHeQpBGmatHDe9pwDKvLrMohZ/mRVYDnGrspKMXGXlIP/8q0Z12F/Iu
QXAjzeigNSjkjbPib3W/FHRNzEPuEA==
=p5vO
-----END PGP SIGNATURE-----

--v8K+BpCUfsaXTN8S--

