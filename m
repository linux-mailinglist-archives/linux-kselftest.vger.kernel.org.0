Return-Path: <linux-kselftest+bounces-12726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0FB916FF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019E61F2379D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B5178385;
	Tue, 25 Jun 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOF23g9A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD86143882;
	Tue, 25 Jun 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339223; cv=none; b=fcNbWuIWarWv+xaD4ckEvdWgvvfDFRS9u2i3jK7iw/V/FyF5EuBHhpX84iVOVbKzm5zscOE6MP7y/ZPJbbuZHgxI/mE/BS18ITUZyHBPeh3Ss5oTBnnhboYB9UonzJROlGZVfga6bJTITCepSJPagIy/FqT/50NsbknSzqHO9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339223; c=relaxed/simple;
	bh=jUjWLcpQRnu/rEeeBv5nOxk8R/BU7l4PVA+gs/H5+2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxELwUajPONZByMbuDn5o8AHCOKfjiWQMLl7b1mA/KgCGyQLjS3PRTjPVRHodDPgkY2DLtnwPHlrMGJn5bt1kzWiWBN8PN6HnsmSsMC2KDLv4OrrRi1GaDPx2YYuFk9mJ8U/TDMGcjpNR405mlQCqYaot2vUL+y8HGpricBQKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOF23g9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8062C32781;
	Tue, 25 Jun 2024 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719339222;
	bh=jUjWLcpQRnu/rEeeBv5nOxk8R/BU7l4PVA+gs/H5+2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOF23g9AEBeSeSoCtouTpbBbC+umwkf3EEetWOrnWCMU56KxqTH0lDQxINcjvt86U
	 zfCxp3VRotXIjvNQ9exhR6ihvixuFAk8OKZJ/5UP5zawD9WT6ke9fTo3TpqTAvGtmQ
	 PrJnEOrOnsKYTKBv6ENkArtZQVJpvFRiv8OjH3EEF+/o6XkNWMNpjkkP9aJ0TEG0Nk
	 sSTtQF/CSJdHW2+MXvxy/e38B64aLEHMkJ8PDBwsY9zNmgv4f5c7E3ESrxy5f16urz
	 3EfcYxFtjfIAkZSRbudBsUmNi7jK/bc9akSfQh5/Lk0+FO5//JhL3761Mpykqo7k4w
	 /jUalUrQbo8jQ==
Date: Tue, 25 Jun 2024 19:13:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	will@kernel.org, ryan.roberts@arm.com, rob.herring@arm.com,
	mark.rutland@arm.com, linux@armlinux.org.uk, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] selftests/arm64: Split ptrace, use ifdeffery
Message-ID: <56dab3f3-7963-4e08-82b8-5b864c0322f7@sirena.org.uk>
References: <20240625122408.1439097-1-dev.jain@arm.com>
 <20240625122408.1439097-7-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oIvGawDpN3XdR/+9"
Content-Disposition: inline
In-Reply-To: <20240625122408.1439097-7-dev.jain@arm.com>
X-Cookie: Results vary by individual.


--oIvGawDpN3XdR/+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 05:54:05PM +0530, Dev Jain wrote:

> --- /dev/null
> +++ b/tools/testing/selftests/arm64/abi/ptrace.h
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 ARM Limited.
> + */

> +#include "../../kselftest.h"
> +
> +static void run_tests(pid_t child);
> +
> +static int do_child(void);
> +
> +#ifdef __aarch64__
> +static bool have_sme(void)
> +{
> +	return getauxval(AT_HWCAP2) & HWCAP2_SME;
> +}

> +static void test_hw_debug(pid_t child, int type, const char *type_name)
> +{
> +	struct user_hwdebug_state state;
> +	struct iovec iov;
> +	int slots, arch, ret;
> +
> +	iov.iov_len =3D sizeof(state);
> +	iov.iov_base =3D &state;
> +
> +	/* Should be able to read the values */
> +	ret =3D ptrace(PTRACE_GETREGSET, child, type, &iov);
> +	ksft_test_result(ret =3D=3D 0, "read_%s\n", type_name);

This feels like it's pulling way too much stuff out into the header.  I
think some of this needs to be a C file that gets built for both
architectures with some mechanism they can use to run tests, and a
library of any shared tests.

> +
> +	if (ret =3D=3D 0) {
> +		/* Low 8 bits is the number of slots, next 4 bits the arch */
> +		slots =3D state.dbg_info & 0xff;
> +		arch =3D (state.dbg_info >> 8) & 0xf;
> +
> +		ksft_print_msg("%s version %d with %d slots\n", type_name,
> +			       arch, slots);
> +
> +		/* Zero is not currently architecturally valid */
> +		ksft_test_result(arch, "%s_arch_set\n", type_name);
> +	} else {
> +		ksft_test_result_skip("%s_arch_set\n", type_name);
> +	}
> +}
> +#endif
> +
> +static int do_parent(pid_t child)
> +{
> +	int ret =3D EXIT_FAILURE;
> +	pid_t pid;
> +	int status;
> +	siginfo_t si;
> +
> +	/* Attach to the child */
> +	while (1) {
> +		int sig;
> +
> +		pid =3D wait(&status);
> +		if (pid =3D=3D -1) {
> +			perror("wait");
> +			goto error;
> +		}
> +
> +		/*
> +		 * This should never happen but it's hard to flag in
> +		 * the framework.
> +		 */
> +		if (pid !=3D child)
> +			continue;
> +
> +		if (WIFEXITED(status) || WIFSIGNALED(status))
> +			ksft_exit_fail_msg("Child died unexpectedly\n");
> +
> +		if (!WIFSTOPPED(status))
> +			goto error;
> +
> +		sig =3D WSTOPSIG(status);
> +
> +		if (sig =3D=3D SIGTRAP)
> +			ksft_print_msg("Child received SIGTRAP\n");
> +
> +		if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &si)) {
> +			if (errno =3D=3D ESRCH)
> +				goto disappeared;
> +
> +			if (errno =3D=3D EINVAL)
> +				goto cont;
> +
> +			ksft_test_result_fail("PTRACE_GETSIGINFO: %s\n",
> +					      strerror(errno));
> +			goto error;
> +		}
> +
> +		if (sig =3D=3D SIGSTOP && si.si_code =3D=3D SI_TKILL &&
> +		    si.si_pid =3D=3D pid)
> +			break;
> +
> +cont:
> +		/* bust group-stop */
> +		if (ptrace(PTRACE_CONT, pid, NULL, 0)) {
> +			if (errno =3D=3D ESRCH)
> +				goto disappeared;
> +
> +			ksft_test_result_fail("PTRACE_CONT: %s\n",
> +					      strerror(errno));
> +			goto error;
> +		}
> +	}
> +
> +	ksft_print_msg("Parent is %d, child is %d\n", getpid(), child);
> +
> +	ret =3D EXIT_SUCCESS;
> +	run_tests(child);
> +
> +error:
> +	kill(child, SIGKILL);
> +
> +disappeared:
> +	return ret;
> +}
> --=20
> 2.39.2
>=20

--oIvGawDpN3XdR/+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ7CNAACgkQJNaLcl1U
h9CSaAf+OzmjUwIL1j7RqpRlpwHktvPS7B66IUE4BdU+ZsyrGJEVhtF9M4Ab+pWd
Q4MHBu2dWWEpcqI+i4Hy8BFhUbwTvWkUB8wqzpvWEiyN6q8z2sCD4/Wigz5e9ZiJ
9j8uzlvewWggK0QBtCI9mFkoU2i7OgusjxYood921Npux7SpROvx9wrAh1flbRsH
AcKnNvwkvjDlWn9EZw34++icUN4b/Ez+wbpza+37/HNkWQMIT/YgptPWyqO6/lXX
pzohRH3EKJRrXT7o2FTg06T+80Ekn4zuVmvH/3cBhEyRrCfuaiDBVhJPswoPjAR7
0tfS7MhoGCBDKvQHVzEWtN43JwQO1Q==
=mTos
-----END PGP SIGNATURE-----

--oIvGawDpN3XdR/+9--

