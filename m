Return-Path: <linux-kselftest+bounces-12650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686E916A92
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 16:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22ED0287026
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0316D311;
	Tue, 25 Jun 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqTBT0jy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66314900E;
	Tue, 25 Jun 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326150; cv=none; b=O4Aa+M1FhYJC6MKJEwqqVMuHcQ99XbBj0oYTo/A0NE+iTqI2Ri61p32+OEufW5mJlKPuIQlmwuP0J3LqmPmTAQgYj2AzBwzEgwjsak6CxKTbrO3i2c0UkvEhRt3rPYwA2QNyikOOPsoHy59du5CKFEgPkf563uAiKzWtyuxAVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326150; c=relaxed/simple;
	bh=El8S7gU+uUfaHJB41C30w53x7EF+EHknuZWBR0gBTqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHv2iHPN1kk076Vi5hpHN8bomOrOKdjG/pMcGnjwblU6pEuBe7OoQt55u/lwki1CGeH2BUJNf0kfUfU+QhXgWTeuNAghwbP1CFbAPGAwwKr0p9voRiMko17hXCRjgJvmJxaVybG4QuPVAoSumvYJc6reZMoCr8BhvQ5NMuHcqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqTBT0jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A67C32786;
	Tue, 25 Jun 2024 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719326149;
	bh=El8S7gU+uUfaHJB41C30w53x7EF+EHknuZWBR0gBTqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqTBT0jyxcwumPHRddSPqTWFCD/kvCSAlJQ4g6I886uWpVLJKJGRmeMYzVevR6l1R
	 EuIsTxF3rd7UeCj8aAsEJaCKeNGObjWmE3kgOqhrtgaZp9rI1JMSmS/1EuRaXaktxi
	 1UZE7yiwIb9tQDFxjPQy4DHhPg0GD26m8LNSgnybgL9EqBO+nt8RMJtOnLIesLACXA
	 SMGX8AveOvoDKwWMJfn7vfBli8W9323zvg5jeQ0LkHZXy+a5l2+jnhRYXr0s/vgj4E
	 hEnbvUK7WDjOZEEziZghf/mOKfVb5VhEWWcdgVx+2OgOfAX551v+yIJQOJabC39cvt
	 l/GQFjOe32qIg==
Date: Tue, 25 Jun 2024 15:35:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	will@kernel.org, ryan.roberts@arm.com, rob.herring@arm.com,
	mark.rutland@arm.com, linux@armlinux.org.uk, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] selftests/arm64: Fix build warnings for ptrace
Message-ID: <63763a2c-ecec-4f70-a6d1-0c050c95e524@sirena.org.uk>
References: <20240625122408.1439097-1-dev.jain@arm.com>
 <20240625122408.1439097-6-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xmaZNYXDj2zPROzD"
Content-Disposition: inline
In-Reply-To: <20240625122408.1439097-6-dev.jain@arm.com>
X-Cookie: Results vary by individual.


--xmaZNYXDj2zPROzD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 05:54:04PM +0530, Dev Jain wrote:

> "%s" should have been used in ksft_exit_fail_msg(). Anyways, replace that
> with the recently introduced ksft_exit_fail_perror(). Also fix no mention=
 of
> type_name in ksft_test_result_skip().

Reviewed-by: Mark Brown <broonie@kernel.org>

but a couple of minor notes if this needs resending (it might be best to
send indpendently as well to help it get picked up more quickly.)

> NOTE: This patch can be applied independently of the series, but the
> next patch depends on this one.

Admin notes like this should go after the ---.

>  	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
> -		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
> +		ksft_exit_fail_perror("PTRACE_TRACEME");
> =20
>  	if (raise(SIGSTOP))
> -		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
> +		ksft_exit_fail_perror("raise(SIGSTOP)");

This should ideally be a separate patch, there's no overlap.

--xmaZNYXDj2zPROzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ61b8ACgkQJNaLcl1U
h9CylQf+KdYIQ4dXAYgORvTyfdq0Oz9U5iKV12JmGUtCLevxwm+Rr/PPVoZfS/86
r+rVzAOwGRqCwebTezaGl6dZZ8nBWWmvvfcedrE3JqH3Yv0Fh/jYG1qi3Sg4P7MK
ohURtCxfh1kxEa93g+IifZIyruEiDnt8jawbk1eAP40RIa+GUR/UlGc2xSOTuoAz
qLAeBtha1skvfnvj6kUBpC5psgIGkzquXDiVjcyX7i7aAk3JT+yoFb7FWA5r+vKu
cFUKHyXJW30yg+y9Te0Wq2kJDsynzRopPzBZu0iEmvsgQJsYcv3J0zjCGqDe4kns
xqOFtA1rJ4uqfUWJfz6HlAcc8dlrdg==
=Hq/F
-----END PGP SIGNATURE-----

--xmaZNYXDj2zPROzD--

