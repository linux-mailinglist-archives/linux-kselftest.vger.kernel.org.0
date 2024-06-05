Return-Path: <linux-kselftest+bounces-11247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A668FCCB2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 14:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F97528CCF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48F193088;
	Wed,  5 Jun 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncSZ1P/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779119CD1E;
	Wed,  5 Jun 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588853; cv=none; b=eZIT+QaOqUZSYmNH9e/EPkEzkaxTpe8lpQ9Hwj+U40sf0W5en9bk7iOXsE6bCx/mBsZBkWMIjY27QTClidhEPWdQeKGnj0hKrmzu9M7DqqiAXRbRk9aHuBpSta9q3It/yx1Hw/nPIdBD+VezAbZDooH01ltTFRxuxR+9nKJGg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588853; c=relaxed/simple;
	bh=1x/4I1Z6zO1QJIB3Lr5KfrwttJCIjm9Pn/UxwqY09pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOV5+0ExWxamCyWM7T8ujMnWF/1YTarzQnWvQKrqz0ETiGSsYxtbKypDsbNC8+t0eE2SquY/M8TxQiRz6r9j0FblulHkbtmm8yA73TiODFvwuCGVafwjxRnk86BluIc5rs+TiUmSiK5a4LBBWgdjkS/VN4o2ECcdQv8qejgRmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncSZ1P/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EE8C3277B;
	Wed,  5 Jun 2024 12:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588853;
	bh=1x/4I1Z6zO1QJIB3Lr5KfrwttJCIjm9Pn/UxwqY09pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncSZ1P/Kc2m1Kqvl/geT4diovhDruYM1jtYyjXBRJK6EkbkLDDaza+5ubD54Mwcla
	 E9sUfHQtt02qzGW92eVYOCPzCKcziIv751iO8Je9UZEAHmf/eArIyaxkNm8vlN2y3V
	 dVle1Ozcp0KAF8EPUqR9Dj9In6XzYFwUUShhH0eX63AzdKB+yoqi3Ghq+OQ51G9FaG
	 f3lFySUPbBHvF10R4GbXalZ+DZ3a1YF5n4Zj+dcmcj6hTq1aljOBVqDEd6GKDXv+KQ
	 vf5DX5bw86ivml3rKNf010H2X6Oxcei8A3sbgExlqtBRaPZLsMPacHwGdB/6x0/gX2
	 3nzfDETqyzMLw==
Date: Wed, 5 Jun 2024 13:00:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com
Subject: Re: [PATCH] selftests: arm64: Fix redundancy of a testcase
Message-ID: <a518770a-371e-4333-b85d-6a5808a7ac09@sirena.org.uk>
References: <20240605115448.640717-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WhGyFEmanl/izRpt"
Content-Disposition: inline
In-Reply-To: <20240605115448.640717-1-dev.jain@arm.com>
X-Cookie: Simulated picture.


--WhGyFEmanl/izRpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2024 at 05:24:48PM +0530, Dev Jain wrote:
> Currently, we are writing the same value as we read, into the TLS
> register; hence, we cannot confirm updation of the register, making the
> testcase "verify_tpidr_one" redundant. Fix this; while at it, do a style
> change.

Please don't combine unrelated changes into a single patch.

>  	/* ...write a new value.. */
>  	write_iov.iov_len = sizeof(uint64_t);
> -	write_val[0] = read_val[0]++;
> +	write_val[0] = read_val[0] + 1;
>  	ret = ptrace(PTRACE_SETREGSET, child, NT_ARM_TLS, &write_iov);
>  	ksft_test_result(ret == 0, "write_tpidr_one\n");

This is a good fix:

Reviewed-by: Mark Brown <broonie@kernel.org>

> @@ -108,7 +108,7 @@ static void test_tpidr(pid_t child)
>  		/* Writing only TPIDR... */
>  		write_iov.iov_len = sizeof(uint64_t);
>  		memcpy(write_val, read_val, sizeof(read_val));
> -		write_val[0] += 1;
> +		++write_val[0];

I'm less convinced that this is a good style change.

--WhGyFEmanl/izRpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZgU28ACgkQJNaLcl1U
h9DqTgf+Ly/z4a+HW3C3ySPkAGM0USl5jc+LFjhwyijiNycgjcsQQwSNAqpkXbU/
i5NIAOBMsU/3Cu84mE+ccJzmKY9mqGJXze+b0p6lCtFAFX2lEUO8mwhk6wZwlYph
gaojRR2GZkNn8FFGBJFtDd676eXRpbY/PV0pAItO5Ckd5CVfICcM65NnVhzNnvav
Y7PD+B9rLpBvIrH5L4kPw82W9d/24nEtG1kXQJY/X72AATiGRz9RRkldVcCzOkf1
9NzBCyf3MjWzmbn9VFYyqfQsPQU41Q8nAM2/4tjzLouG+zXASVam6Y81PT0dzlkJ
i4VFYzvpDpz8y3hmNOGPkS/mr94TXA==
=8QbU
-----END PGP SIGNATURE-----

--WhGyFEmanl/izRpt--

