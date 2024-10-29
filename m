Return-Path: <linux-kselftest+bounces-20994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DDF9B5206
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C494D1F217EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835520102F;
	Tue, 29 Oct 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUUydWmo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A1200CA5;
	Tue, 29 Oct 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227473; cv=none; b=t2G9nHDPnQdseamqK5s4ySoF+wRSJwtS5R8a+nycIuqed/iABl1/Q8a26dU2kOf6ixEIqc7DnTm3h4DjWnHM/NYR4pIhB0VbYZCtepBtaNRemoSwzXt9/rWQBvJd7rRE0vusFJiIdXKrRwOJTg3pQoq3Be+HN/qoDBmMO+prx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227473; c=relaxed/simple;
	bh=SAzb5sox9WkQjVEsLFYFCAyGjvrQ4IUcSchM6PkjN0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utCMeqFNm+qjv5EpaDLIKFG7rAIOu22ng4dkHhwO1EziZy7FILhzPJxllZLeDG3syEbjktvV62/zLBb+BPIBdN411dt/d8GmvM+sxEncRwj6MaWEHN/d5k3nr4wcx6SV7fhzB6P+B90aXkYYqpGckMMHJx2F0eLdp0s/C+83wPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUUydWmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E63C4CECD;
	Tue, 29 Oct 2024 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227472;
	bh=SAzb5sox9WkQjVEsLFYFCAyGjvrQ4IUcSchM6PkjN0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUUydWmogXGqgt61Ed56Zb0+2midvytHivx01SyirWhMvRR9l5e98qbjWQcVSU93H
	 yIioJsr1mk/6GI6dvuHVoBtEauruZory9RcwC99PyEc0BLarSuiqMvq7Fw2+gZLoGo
	 srqJuvMEyUZq7lXiZRCenU1s8uLKaXVScpsbtuefYfvVTSPcjkjc8LtCD2WDh4ia5a
	 JcSq0osRK+0h/QAKJ2X/TwHgU4vO/PadTYZsffhhTT8zQYnF4lSvGBdpZ3uyPWTpuj
	 /TTRzwn2fJaA1G7jL9xJAX0bZSRUp0HhKhv3Or5i7OhiPxFTL/5xH4j3wGOU7zb5mU
	 46K9dL+P+6YMQ==
Date: Tue, 29 Oct 2024 18:44:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kselftest/arm64: Increase frequency of signal
 delivery in fp-stress
Message-ID: <92fb0694-7a55-4e2f-9b59-8263a9dc58bc@sirena.org.uk>
References: <20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org>
 <20241029-arm64-fp-stress-interval-v1-1-db540abf6dd5@kernel.org>
 <ZyECqagB1tGdE4uz@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TBVH/4Eq+53Y0zo/"
Content-Disposition: inline
In-Reply-To: <ZyECqagB1tGdE4uz@J2N7QTR9R3.cambridge.arm.com>
X-Cookie: May be too intense for some viewers.


--TBVH/4Eq+53Y0zo/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2024 at 03:43:37PM +0000, Mark Rutland wrote:

> On those emulated platforms (FVP?), does this change trigger the faukure
> more often?

Yes.

> I gave this a quick test, and with this change, running fp-stress on a
> defconfig kernel running on 1 CPU triggers the "Bad SVCR: 0" splat in
> 35/100 runs. Hacking that down to 5ms brings that to 89/100 runs. So
> even if we have to keep this high for an emulated platform, it'd
> probably be worth being able to override that as a parameter?

I was getting better numbers than that with the default multi-CPU setups
on my particular machine, most runs were showing something IIRC.  I do
agree that it'd be a useful command line argument to add incrementally.

> Otherwise, maybe it's worth increasing the timeout for the fp-stress
> test specifically? The docs at:

>   https://docs.kernel.org/dev-tools/kselftest.html#timeout-for-selftests

> ... imply that is possible, but don't say exactly how, and it seems
> legitimate for a stress test.

IIRC it's per suite and there's a bunch of pushback on using it in
default configurations since the selftests are expected to run quickly
in other cases where I'd have said it was a reasonable change to make.
Stress tests are not entirely idiomatic for kselftest, it's supposed to
run quickly.

> > +#define SIGNAL_INTERVAL_MS 25
> > +#define LOG_INTERVALS (1000 / SIGNAL_INTERVAL_MS)

> Running this, I see that by default test logs:

> 	# Will run for 400s

> ... for a timeout that's actually ~10s, due to the following, which isn't in
> the diff:

> 	if (timeout > 0)
> 		ksft_print_msg("Will run for %ds\n", timeout);

> ... so that probably wants an update to either convert to seconds or be in
> terms of signals, and likewise for the "timeout remaining" message below.

> Otherwise, this looks good to me.

Oh, yeah - we should probably just remove the unit from that one.  I
never see it due to all the spam from the subprocesses starting.

--TBVH/4Eq+53Y0zo/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmchLQsACgkQJNaLcl1U
h9Dekgf/QkHHsQ5rnbl08prEV71y4ezYroRyWdjmWLGIbc9O9QxlMOEPprNm/+52
dLrCllyWV3SdcuV3PPCGwUg5VmCSSMClhi9Dui99rAQPz3Qy/pZ4lV4sccHRJUo6
xewGn83e9Lvelm5ahj9/BN/u6u6A9Z3kjHep1jKlN0E9eT3Vgwc2NbBnr0RMTXmT
RbDIiYb8M9JYOPZwbeV/D7A4+z3A4Zh8iA7uf/6xW7hFuq7UrSBgz/E4gsc9jC5R
rlvFLaJXZLvrOJ9W+1pNyENIEnHZuey5Ed4F1HkwyACF5XNrIs7s4Hkrrq6GSUsL
iIdAbaU51VDdTewqDTx/RFwS2aBWyA==
=CAoX
-----END PGP SIGNATURE-----

--TBVH/4Eq+53Y0zo/--

