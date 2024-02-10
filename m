Return-Path: <linux-kselftest+bounces-4490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF5C850466
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 13:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2741B1C21B47
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C247A7E;
	Sat, 10 Feb 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYmaXtYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5FC4642B;
	Sat, 10 Feb 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707568521; cv=none; b=T8aWVEhhjP+z25GjBDps6ZdklCgWnKFPoBKfWKcNkY7UhKfG88MhBPYql1wlKmXcWfzrseeSfnD5kRXE3jhA5o2TA5vvQbRMNp8kT7N20ngOHMy7aA+4uAoKhaaBvh8N7up/mC6paU09S4TzAM6UHVdgywmB80SX0UqwfG8zbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707568521; c=relaxed/simple;
	bh=fPwvazq3DG0WdOG6aq2UYP9PUCwTT/kKO+PLvnTVTd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8/S+vm6ODUILJS6DMZs0UwdQqJG7k7ffnUGNEq9zLcjjuGpSky3Clp6FY8Zb76lolDPvjLNdofSJBFnJo6gvVwS+4lEuV4ljpGVNU40wgAVI4AZOMe+nbYmdE9HL004GEApWPt0XcCsyqAQ7tw0C57lwRl0HzxL2tTnNt09OYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYmaXtYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B33BC433C7;
	Sat, 10 Feb 2024 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707568521;
	bh=fPwvazq3DG0WdOG6aq2UYP9PUCwTT/kKO+PLvnTVTd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYmaXtYBIgtBSb23sAOfcNDtvWdC1BsAopBvCQAKB9eed/VboJsaoj5TjGNARpR18
	 RXl8nYya22AfKbszeLZxkN59k/uBAUMNx0R5r0yPsT+/7R+Yw5+y+3Iuq0F+6hNPhp
	 s7WjfPa9SkgC8FCgJZUjWFJ5O2qHJEla93q+6psIvpHXOO9DYYWv+/CTBPI/hJ/7xQ
	 HEkDsXyAVlF2eTm56Zh8gNjJK7/NIaFbpPSTomW+iV+h31uZheyeTTH2IQpytmvcFq
	 wkBBAcKhEU/jzmEKiz193FYfO3qX6dv+R/Ap+Hr+Cv/1DH9fJOvYnVDJJbMjMtH8FB
	 ae/xIciIzrHGw==
Date: Sat, 10 Feb 2024 12:35:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Don't needlessly use sudo to obtain root
 in run_vmtests.sh
Message-ID: <ZcdthfAvzLQ9lzvd@finisterre.sirena.org.uk>
References: <20240209-kselftest-mm-check-deps-v1-1-19b09b151522@kernel.org>
 <17c0b7a1-6ec2-4504-8287-f0fa111b9748@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eYv/2Dvkk6iewWK1"
Content-Disposition: inline
In-Reply-To: <17c0b7a1-6ec2-4504-8287-f0fa111b9748@arm.com>
X-Cookie: You might have mail.


--eYv/2Dvkk6iewWK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 10, 2024 at 07:40:16AM +0000, Ryan Roberts wrote:
> On 09/02/2024 20:21, Mark Brown wrote:

> > When opening yama/ptrace_scope we unconditionally use sudo to ensure we
> > are running as root, resulting in failures if running in a minimal root
> > filesystem where sudo is not installed. Since automated test systems will
> > typically just run all of kselftest as root (and many kselftests rely on
> > this for full functionality) add a check to see if we're already root and
> > only invoke sudo if not.

> I don't really see the point of this. run_vmtests.sh needs to be run as root;
> there are lots of operations that depend on it and most tests will fail if not
> root. So I think it would be much cleaner just to remove this instance sudo.

Ah, I was assuming that some of the suite ran usefully as non-root given
that the only point of that sudo was to acquire root.  If the whole
thing needs to be root then we should instead have a check for root at
the top of run_vmtests.sh and just skip the whole thing if we aren't
root, but then I'm unclear why it's invoking sudo in the first place.

> The problem that I was referring to yesterday, about needing sudo was for this case:

> CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit

> Here, we are using sudo to deprivilege ourselves from root and run
> on-fault-limit as nobody. This is required because the test is checking an
> rlimit that is only enforced for normal users.

> Somebody on list was talking about skipping this test if sudo wasn't present a
> couple of weeks back. Not sure if that happened.

Yes, there's a check:

	if command -v sudo &> /dev/null;
	then
	        CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
	else
	        echo "# SKIP ./on-fault-limit"
	fi

--eYv/2Dvkk6iewWK1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXHbYQACgkQJNaLcl1U
h9DLPgf7BkjKKkjtfQjwDw++hKvi33jgQojpcIEX8Nu2qNgfO5NtKNFvpwBp5AVk
kjF3sA17LOMPSaROlYkXyCcha11316o9Aq9NpMrOv/1cUjd5ono1Ac2iua9y5RMY
fMkTYW3DmuTqzLCnkzzkx8atvoc5Gk9IXUUJHE81sNLtRF1ZSMp7nihP2U/vxVre
07d7O6nz50tNLbT5M0FZ6x74q9KlZVrDvv9hd/UyOTl2L6gl4dUlp/osb3Ij+f3b
+yLgE7PVhoLmeYbfErmWnnU3CsR0wQPZ/qtWzQphiL/tHJSTy7o/A76L0EIB/2vU
biQAROFp0YvNmzMw/vM5iz3cnF98fg==
=15fQ
-----END PGP SIGNATURE-----

--eYv/2Dvkk6iewWK1--

