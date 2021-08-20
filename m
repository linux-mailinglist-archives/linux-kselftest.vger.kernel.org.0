Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AFC3F2BAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 14:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhHTMBN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 08:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237830AbhHTMBN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 08:01:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91DFB60ED5;
        Fri, 20 Aug 2021 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629460835;
        bh=DBhyA8M0wprI9nznJtc9PSm/qiZdWgwqo8SUXRlgk4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apOGwUUlwEqbip7ZGvrR2iM99ZzhF9WJcemw3/VoSD75B0Bb/NzRhtq0sxcDw0+H5
         LXNp3ilqtRHGPidXDQ8Gk7uNwulPKO3VCLe6ygPAw+20/3ESvg0mz2Leq5OCpWRdp9
         Mo+OgRzf/8EbbfV7IwiVMZ0QNvdaEX6vKinWJw9EEVniuseAOAm0qjSdefWTW5/28m
         c32EWiXqFvVUAHVVYZKMPn6NhDW8nSFg45hZULe5NFGcnaOwwxWo8nC9ulhFqagMsf
         /5S39KgsQ0BYfAKrQ54Ahx6ptY7x1RvU+Fq3RKVjN1JrLk38bGktsNkrA8huyEF5HA
         BGp3yNwpa8HsA==
Date:   Fri, 20 Aug 2021 13:00:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kachhap <amit.kachhap@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: pac: Fix skipping of tests on systems
 without PAC
Message-ID: <20210820120009.GQ4177@sirena.org.uk>
References: <20210819165723.43903-1-broonie@kernel.org>
 <a988b3e2-5f88-fbd5-99da-2066a65a17b2@arm.com>
 <20210820105531.GP4177@sirena.org.uk>
 <20d96c3e-36f8-276f-ab02-daf5bc7c976f@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rKoHqF+aPLVth8b2"
Content-Disposition: inline
In-Reply-To: <20d96c3e-36f8-276f-ab02-daf5bc7c976f@arm.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--rKoHqF+aPLVth8b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 20, 2021 at 05:05:05PM +0530, Amit Kachhap wrote:
> On 8/20/21 4:25 PM, Mark Brown wrote:
> > On Fri, Aug 20, 2021 at 12:39:39PM +0530, Amit Kachhap wrote:

> > >    -	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
> > >    +	ASSERT_NE(0, hwcaps & HWCAP_PACA) SKIP(return, "PAUTH not enabled");

> > That's what the patch does?

> Agree, I saw few other testcases where ASSERT is used along with SKIP.
> (tools/testing/selftests/core/close_range_test.c) so this way
> ASSERT_GENERIC_* macro will be clear. There will be just an extra
> log like "hwcaps & HWCAP_PACA = 0" in this case.

I'm not 100% sure I follow what you're saying here?  I don't see a log
message saying "hwcaps & HWCAP_PACA = 0" on non-PAC systems, or is that
what you're saying you want to see?

> Probably your way is consistent as other tests in arm64 also just
> skips due to HWCAP mismatch.

Right, we can't usefully run tests for features not present in the
system - this sort of thing is the intent of the kselftest skip feature.

--rKoHqF+aPLVth8b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEfmUgACgkQJNaLcl1U
h9CcEgf/b6mcyDe/ywMRt6AADkTKURb/EaDB5lLk41XkXjmazqmwVbtE1OOen7pw
T4a9856CQipmYHchVs+s1Dg6/y2IAr3/1ltoKkLiB8/G8yvQiqJZ1NiiX3NyKp16
xFbqVre8ccAk9tQib9LetAbg1UbjHKk1t5q2EuxY+s+1ksCp2/S6Y2i3DM6hvIlA
GkX9YfZ98/zeZl5ZuSk2ijE9GGX46vAyNJKmTcYnyWGVaw858iMQIIml5G1EUMa0
X5uazq6j3EgkTHgI9sfalrCW0oJI8imAyEFUc3iyLJUc6ncauEnGaCvvWnPAF51O
98h8gnINIqYs3X3SfIFpQJQ6V53CkQ==
=wjB3
-----END PGP SIGNATURE-----

--rKoHqF+aPLVth8b2--
