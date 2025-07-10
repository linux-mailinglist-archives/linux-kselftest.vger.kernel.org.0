Return-Path: <linux-kselftest+bounces-36966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EB2B003F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C07A5430ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0C026A084;
	Thu, 10 Jul 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocyvsUWm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3460269B01;
	Thu, 10 Jul 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154943; cv=none; b=SWIj0/CMyoo+cJUdMZ1fZq6FAorb/XmBzglWRWHALbJkw3CwmMBaPPHu3hN/tJsMp1ZId3SSFJvf4/B5M1ZVbRzDV+gWWt6g7bYGAM9zFwd6GU1yiIj4tRjYHBpHDszRZBn1sQpHMpvjehYOium728pYQtYL6sHFwzE6gYTfJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154943; c=relaxed/simple;
	bh=O2w/SrY5DG8vVLbvJhBCppXT7i2aFFp1w3GpcEDJZYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s901U7XZGI46cRx6WhRVZX6MtFesiYWalSSWotQ3BSYZKXeT7rTaCquqclD0NvxOGjrNAjBmGF2IzmgCau87AOPrz45Z0xi/ii2kkWOmPTvm94P/bJaLCnDkkRuEI/W0jrYakN9QdM9pUSjKbgNnJy8cZxBH196e1PyMjjz87VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocyvsUWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1081EC4CEE3;
	Thu, 10 Jul 2025 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752154943;
	bh=O2w/SrY5DG8vVLbvJhBCppXT7i2aFFp1w3GpcEDJZYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocyvsUWmeyX/jVDFjgpEWtnc/Geca+FwAttm6LhCXok/nvdY5B3MLJeEfxLULOq8J
	 yu5SM/k7mG4ZxtVw5Gp7MQ17e3Yl3y2+mRXkWZOuXCt8keVFRfLM9GbgxxdlZxlfgR
	 8opp23wa8A5Nzo1830EWrtVfwLV9EYhQsPQcCNdGOYMtZmXKFUHsKHGuqdEGOinCTk
	 Es/C2bZ3ndP9uFsi05hsdAvUpViWsW4YF3W4JzfPH6ZZHzrHjPYV/T49HxB2VuRheh
	 rEf4VMbTcvrAI2X606n8ARgQWJbuluoeBKKuClkLrTuTeDpn4RXsUa7cWivE5wqQ5F
	 13TBFAVlUvOvA==
Date: Thu, 10 Jul 2025 14:42:20 +0100
From: Mark Brown <broonie@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
	david@redhat.com, sj@kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	shuah@kernel.org, Liam.Howlett@oracle.com, brauner@kernel.org,
	gkwang@linx-info.com, jannh@google.com, p1ucky0923@gmail.com,
	ryncsn@gmail.com, vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Message-ID: <aG_DPLhtZ5qDuWHY@finisterre.sirena.org.uk>
References: <20250710112249.58722-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JxpZ0RoUQgE6HJjN"
Content-Disposition: inline
In-Reply-To: <20250710112249.58722-1-lianux.mm@gmail.com>
X-Cookie: Do not cut switchbacks.


--JxpZ0RoUQgE6HJjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 07:22:49PM +0800, wang lian wrote:

> Add tests for process_madvise(), focusing on verifying behavior under
> various conditions including valid usage and error cases.

> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c

> -static void handle_fatal(int c)
> -{
> -	if (!signal_jump_set)
> -		return;
> -
> -	siglongjmp(signal_jmp_buf, c);
> -}

I see from looking later in the patch that you're factoring this out of
the guard regions test into vm_util.c so that it can be used by your new
test.  This is good and sensible but it's a bit surprising, especially
since your changelog only said you were adding a new test.  It would be
better to split this out into a separate refactoring patch that just
does the code motion, as covered in submitting-patches.rst it's better
if changes just do one thing.

> +#include <linux/pidfd.h>
> +#include <linux/uio.h>

Does this work without 'make headers_install' for the systems that were
affectd by missing headers?  Lorenzo mentioned that we shouldn't depend
on that for the mm tests (I'm not enthusiastic about that approach
myself, but if it's what mm needs).

> +	ret =3D read(pipe_info[0], &info, sizeof(info));
> +	if (ret <=3D 0) {
> +		waitpid(self->child_pid, NULL, 0);
> +		ksft_exit_skip("Failed to read child info from pipe.\n");
> +	}

If you're using the harness you should use SKIP() rather than the ksft
APIs for reporting test results.  Don't mix and match the result
reporting APIs, harness will call the ksft_ APIs appropriately for you.

> +			/*
> +			 * MADV_COLLAPSE lost the race to khugepaged, which
> +			 * likely held a page lock. The kernel correctly
> +			 * reports this temporary contention with EAGAIN.
> +			 */
> +			if (errno =3D=3D EAGAIN) {
> +				ksft_test_result_skip(
> +					"THP is 'always', process_madvise returned EAGAIN due to an expecte=
d race with khugepaged.\n");
> +			} else {
> +				ksft_test_result_fail(
> +					"process_madvise failed with unexpected errno %d in 'always' mode.\=
n",
> +					errno);
> +			}

Similarly, to fail use an ASSERT or EXPECT.  Note also that when using
the ksft_ API for reporting results each test should report a consistent
test name as the string, if you want to report an error message print it
separately to the test result.=20

This applies throughout the program.

> +/*
> + * Test process_madvise() with various invalid pidfds to ensure correct =
error
> + * handling. This includes negative fds, non-pidfd fds, and pidfds for
> + * processes that no longer exist.
> + */

This sounds like it should be a series of small tests rather than a
single omnibus test, that'd result in clearer error reporting from test
frameworks since they will say which operation failed directly rather
than having to look at the logs then match them to the source.

> +	pidfd =3D syscall(__NR_pidfd_open, child_pid, 0);
> +	ASSERT_GE(pidfd, 0);

This is particularly the case given the use of ASSERTs, we'll not report
any issues other than the first one we hit.

--JxpZ0RoUQgE6HJjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhvwzIACgkQJNaLcl1U
h9B9Iwf/fvpOkRD8HNeEFM0rMg/Fod98NV2uGuIyKgK6Hl5gAzErKqNHVMxsEKY7
AMsj9qiWyBGvjCYarJAQOUjaODDhIQneeAfsLpNekzU/zlP9ATZywL8zRJEjGKxO
vOgpThb5FtX5BIk9enHmbMavCkqHVis/H/SW394EAdWOuRRHuQ8xx3OWIh49H0a/
EG60q8SJzg9/f/F0RiznX03w+tnPsGgCM4cfW4bLs6WKqIL0ZSj1bUswJ2jE7VrI
HBYQF7e87dy+NB2myp5c1mlxI52xxgAJnrp6HjyyqlnqITo+MOb+BPnawTaZ1rpY
srJpsaZtAtnsj2j3tiugOU4nhnoqZg==
=uYWZ
-----END PGP SIGNATURE-----

--JxpZ0RoUQgE6HJjN--

