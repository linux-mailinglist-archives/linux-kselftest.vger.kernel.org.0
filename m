Return-Path: <linux-kselftest+bounces-7395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD5389BEAF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D941F21AE1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985A36A33B;
	Mon,  8 Apr 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl5tW+US"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8769E07;
	Mon,  8 Apr 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578347; cv=none; b=eyKuS9qjDWndhAAOwywxG3F9gTYmAsDdkHPNzam1U+mzeL8BUMpk93IlUsLpPCgdv8fxGldiztPlaIado6VnQf2+v/re/ulsjaiMq1qfMkEmdCyzMVE563wL2+1UMC6AajG7P+39exRHFd1KiY1AptuKNySJED8uMqlyBU9ilI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578347; c=relaxed/simple;
	bh=vMSCjQT2myET9suDYZEPUOmwcRvfB4t+Bz0J1v9ExsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raHcgTWCqSrIMOrh+QhNePzymdPpPsBUD8eNeVcWJhlFLa+XYN1D4YffPvFqQgHVwpLFu0VyX+G8bEPdqkFZhKdu/VfuOZSk+w0eX9ADaoULjRGJVfEzYeocXDlGz4NWk7TXCEVH1jjKWZVQOQQqphi6ALTrq11bfsl4QyHdFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl5tW+US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419B3C433F1;
	Mon,  8 Apr 2024 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712578347;
	bh=vMSCjQT2myET9suDYZEPUOmwcRvfB4t+Bz0J1v9ExsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vl5tW+USe5BvdmV9SiYYIe5EsZpjpNVcWf0jbWr503WM7zUifY49LcCKCKS+zjQVj
	 1csscUtgIq486b42/UbxdrA+bWgmFqGCOz9iwkAJ1Uhoopk4QOOruopsFivzir/Yrl
	 6I1p5/Jd/ngDk71tDTBVrP0RSjRfzEeeCcCWgikAgm17pRxPBHwLoGsNpvga/wEu1r
	 cFER3AQF+kgCxi4M00h/ODs6CGnho3jn54xsBIJe/hZnrHbq2joLHmlZWnrvdC2Pjw
	 ay+9i5KHG7od/6/EioJh44kqV5E1XJnGLJFfRVfKsIxJb9mqy6tTxir8R84kpYXsSJ
	 KD687eAWpfZ0A==
Date: Mon, 8 Apr 2024 13:12:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Dev Jain <dev.jain@arm.com>, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com, suzuki.poulose@arm.com,
	ryan.roberts@arm.com, rob.herring@arm.com, Catalin.Marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 2/4] selftests/arm: Add signal tests
Message-ID: <f673314c-3a22-4a62-a994-ce6262593914@sirena.org.uk>
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-3-dev.jain@arm.com>
 <1ce0e9c7-0bd3-47c1-893c-3ea5aa95fef5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qZP1wOhkGWh/mDjB"
Content-Disposition: inline
In-Reply-To: <1ce0e9c7-0bd3-47c1-893c-3ea5aa95fef5@collabora.com>
X-Cookie: Drive defensively.  Buy a tank.


--qZP1wOhkGWh/mDjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 07, 2024 at 02:28:06AM +0500, Muhammad Usama Anjum wrote:
> On 4/5/24 1:44 PM, Dev Jain wrote:

> > +	ksft_print_msg("%s :: %s\n", current->name, current->descr);
> > +	if (test_setup(current) && test_init(current)) {
> > +		test_run(current);
> > +		test_cleanup(current);
> > +	}
> > +	test_result(current);
> > +
> > +	return current->result;
> > +}

> This test isn't TAP compliant. Please make this and all tests TAP
> compilant. The 1/4 patch has example of TAP usage.

It's based on the 64 bit version of these tests which are also not TAP
compliant.  TBH I'm not sure how worthwile it is to fix at all given
that they're all single test executables anyway, if it does get fixed
it'd be good to do the arm64 ones as well.

> > +	} else {
> > +		fprintf(stdout, "==>> completed. FAIL(0)\n");
> > +		td->result = KSFT_FAIL;
> > +	}
> > +
> > +	if (force_exit)
> > +		exit(td->result);
> > +}
> > +

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--qZP1wOhkGWh/mDjB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT3yQACgkQJNaLcl1U
h9DmvQf+LUmNX3wMgRZgOE8R5TMnKhRAImfgyCZZmViWqco8+Iqo5qlwkW+t3Rfv
xoKtvMzrLCdMKSu1w7tUCufvf+US2FnAicHbeZkvkssDbORrrWLRm25AH4K0ooCp
du0W9s6tJJQa9+cEnPtPQEdu3SbZ9WdPdUIEVBhboyGpLLkFCNFjppiP5x6MMnE4
QNDoEMXIqwD/ycfVpEMTHmV5yz/fJGyiIeLJ/++wRthcHhXihuAA0pz0WEIuqwtU
ZMfcjNQM2EZtduAefDtoQIW8SITEifs2eLkkpzRH2cKm3sSnurQO/4Ofl74lCEkD
JXVCD3PQpvxS1v37IxUn+vXbT3mztg==
=tYml
-----END PGP SIGNATURE-----

--qZP1wOhkGWh/mDjB--

