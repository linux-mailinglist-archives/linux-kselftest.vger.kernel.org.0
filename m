Return-Path: <linux-kselftest+bounces-12715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF6916FC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D55E1C23887
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E33177990;
	Tue, 25 Jun 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXIkYLHY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D7176AA9;
	Tue, 25 Jun 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338669; cv=none; b=O19jQnuwoKgnt/bEJjiEAHy/eSrzhokow3/J1HeDUQzjPi0uH5h/KkJbXD9PBLazx+C4ftDBNdilOxXSA3g9jYPKMr7XpHtSyeiP0DoI/t7EEI+BxloEN4EayaqDweqDTXRbGBMhMechqhO0KPrnRrgpGDf9y/59LZWVjdYEbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338669; c=relaxed/simple;
	bh=ekQzlHEsAX6919ulFX9X/x3+quscudXkP0mEhBKpEQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNMr2JCH7ymg6ChBZneyi4ZZHfpSwKgujWoIiKdtGKzi9IZ+xNiQjXzZ5RXwMqJowbw0P4lp5FmUst30XY0YVHFlpRFhwFLmAZnA3oiXJrxK1Qz1zmbEttUjazi81HmHkhcq21eMrRwdKd7jHHnyJUY5wsV0SyenymUMcLJ+pgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXIkYLHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E2EC32781;
	Tue, 25 Jun 2024 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338669;
	bh=ekQzlHEsAX6919ulFX9X/x3+quscudXkP0mEhBKpEQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXIkYLHYIgVa88dAS3L2MWG/V8I8j+aT18KyA0zNHf55o4Vng9HrmTUNa5OMGJeS0
	 dNN4K88yX7dMuRinjD6cpw6dzzQAHocGxIRA4K6/mt+vSj11BayNMB7SJ9tH1BKmwm
	 y9+suAPP4nKL27iF7MQ82UfpcS3qCTzhRfsKmBf9yJbiPINNPjUGKoQBxnA2+tZNM3
	 +x6va39SPUlfMryIDygD2FFrMNkJDtX/g6aOC0VHcTmcN5Y2j0beXxFX7eENou+uGN
	 e7WRswKnB65ayebr571CZpMdmV/3uAugsmPuXBhTfy69vbVCG5B2Ap1gUD0pFMh3qX
	 yCFhnS8aUDF+w==
Date: Tue, 25 Jun 2024 19:04:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	will@kernel.org, ryan.roberts@arm.com, rob.herring@arm.com,
	mark.rutland@arm.com, linux@armlinux.org.uk, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] selftests/arm: Add signal tests
Message-ID: <c0cf5383-5b99-4e5a-af1d-82006b1fe592@sirena.org.uk>
References: <20240625122408.1439097-1-dev.jain@arm.com>
 <20240625122408.1439097-5-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6YXMFyiIEZrpcfiy"
Content-Disposition: inline
In-Reply-To: <20240625122408.1439097-5-dev.jain@arm.com>
X-Cookie: Results vary by individual.


--6YXMFyiIEZrpcfiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 05:54:03PM +0530, Dev Jain wrote:
> This patch introduces two signal tests, and generic test wrappers similar
> to selftests/arm64/signal directory, along with the mangling testcases
> found therein. arm_cpsr, dumped by the kernel to user space in the ucontext
> structure to the signal handler, is mangled with. The kernel must spot this
> illegal attempt and the testcases are expected to terminate via SEGV.

Reviewed-by: Mark Brown <broonie@kernel.org>

--6YXMFyiIEZrpcfiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ7BqcACgkQJNaLcl1U
h9Ba/gf/V85YztUX31Im7xIaTjJ4oS7lqN/xJBYbwJoJPWyM53WzP4Od3CSp4N4A
oj0aL7J26PHcNVWEJ69iBEeUicAovKZ0vfe6qcquLYvd6Bi3JgkRycatXgpOLtxs
VV7zHNiXwXbVSYInWlncKgzt3g0cqyBG9R1VW8U4RV2aQKATC+DP82xTkLX/dcSX
0oc9GIGgQuYPXYwSeKY4p+cF4qw/GklwW6CSQ7HnU+Spsk+X/btceIpi6XTAGo9Y
FXvoVIauzyvkajAK5hXn2nF5nSX4RvgYFNz1pTCxkHrBTV5F1BIo633r9AvIOvmj
Vxs209WXAMkkdS9u0YTiaxnC8/T8Lw==
=3E8n
-----END PGP SIGNATURE-----

--6YXMFyiIEZrpcfiy--

