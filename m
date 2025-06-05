Return-Path: <linux-kselftest+bounces-34398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4FACF692
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 20:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D0E16C3A7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4B27A933;
	Thu,  5 Jun 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIekId6S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6A27A445;
	Thu,  5 Jun 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148203; cv=none; b=AZpekf/Bp2IjqdG18jKoEasvsVCBemP8IJTkhSyBfsLNkVUHbhqc5BKVCcknw+u5Bd6enFJNmuSDFtOw3xpnbf15gd9lcQxWHr04/wmZHBTDdgtDIiA64slUtGR4Co5vnR/DN8sZn6hkFCunQprd4idc1WqFAHBmBFGVE92uMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148203; c=relaxed/simple;
	bh=hy75hSPJwRq14gtdJlzgwmegdwxEg8Yl7eucloOyWOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrLoRZ+DZ/NGhgvAfBOapDkjINNVJaB9I0NAixZAinQcCEeaEs1/GG0rpjtxQj2Pxv8/9lw7KuJbNoixSxEHnWm/1I30zPuoARpX9pTwgca9iv80GFZlWrLovFzdqtFlBqcnTU4A2KEGiAkQaoLeIB+RtF84U6/kiF6WJIfCj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIekId6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746EDC4CEE7;
	Thu,  5 Jun 2025 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749148203;
	bh=hy75hSPJwRq14gtdJlzgwmegdwxEg8Yl7eucloOyWOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIekId6S4JB/WwvVZJsHDO8pKi9c+jslyub6rvOokbUy6wrBTcscKMEfYeIOb3zlM
	 oFRQfstINt12oIZMi6rfg7cRzJeReWtcUV8DPNqGFxZs2B0ZfNyMHL6k+im1zpg1lB
	 Z3a+IHkomB2UZbYo3Rn2/92831outWsyoe1pYqvr+xkSUJemBVGwtsvalKasKJ/AdQ
	 TvLcI1rdyTYdGiDUXWCf0qufUtqviF5BNe/x3uG0PerJvNFGVW1KJqn89jmssiqpMm
	 Wg+pdg5p/Khq4Ret+8MnCiuLARhPGmhw+ws7q65IzDtQ3kuVGBznESjxZ0616adbnY
	 YX0dGonQ5Qujw==
Date: Thu, 5 Jun 2025 19:29:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <fde974b7-de82-4a2a-bb8f-efa9955d50da@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
 <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
 <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
 <976bbe1a-ef16-4006-acac-8b6be46ee5ea@lucifer.local>
 <961a62b0-d0d3-40db-8008-61c634172ca6@sirena.org.uk>
 <ab2e1fc5-a0bc-4694-9449-adf85b96b38f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+CaRyybbQXauNurH"
Content-Disposition: inline
In-Reply-To: <ab2e1fc5-a0bc-4694-9449-adf85b96b38f@lucifer.local>
X-Cookie: That's no moon...


--+CaRyybbQXauNurH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2025 at 06:47:28PM +0100, Lorenzo Stoakes wrote:

> Mark, I'm not finding this productive.

> Bottom line is you've broken the tests, please fix them or if you're not
> willing to I'll send a fix.

Sure, like I said further up I'm just running my patch through testing
at the minute.

--+CaRyybbQXauNurH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhB4iUACgkQJNaLcl1U
h9Bm4gf/cad7/YCdDz829GeDIoTAYLP1HXTO02TTMMjpoG+Dl4Z6TAgfKS03DO+Q
VJim6CI8aE0BR8IdWc34MAEosN9EVLaIph38dukhe2DKCDoSEmexbR0q6byrdP4t
EaJEk7KvosAheFDNO3FsyYjzD1waupbrN52bWAY98f34EDxStZxSDR/uCwAnowtV
a8hC5olhLBC+foXqhTF6ODZXxlioUtwdoUYYHU0R0IzVAoIPsx9GqLUreccX6Rxv
c3fX0q9tLgv+faEIjBIHrhwDV/hbNlDMY/ShXR9EBLrz2zOS/Kr7lOP0SewGecMU
yTFOZ3EzDuzAkgyrKilO/CFJqMeNvg==
=QSyT
-----END PGP SIGNATURE-----

--+CaRyybbQXauNurH--

