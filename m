Return-Path: <linux-kselftest+bounces-23038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396869E97CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338BD283459
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08C35968;
	Mon,  9 Dec 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSJpfRno"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34871233143;
	Mon,  9 Dec 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752297; cv=none; b=BsUWvCdALwzprYo3AXwxZeuacypLuFzOvIIZdzbtpk43EEBEqggovu1+QlixekPBQNX9jY0UtrybtAyYbg2hO4nHKn3MBMvxLX4Wt9Y6ZCkFW/oOp6plEeHn6MKW/misewbhUDvbY8HrVxL8AgA3yrmYeoQU8o0qZ5IBH/kK+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752297; c=relaxed/simple;
	bh=X3svPo3PpGuuyArPt3jHEZ/HCf7p6Yd4FykOR/w20Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbG5ElD4t/StYY9YIM+RByfGW3obzrn6cD+7cdQ8QAkzm2x1J6ykE6NioV//6d6N7G/veLscD3gpaprUEDRy9L6EPyLr+9maEBaqLneqHLIYLdzt1w0RPciURrRFB2XFiLZhBrlZshwhAoQ4TamBws8XWlSBxH7xFq1YeBSiOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSJpfRno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D961C4CED1;
	Mon,  9 Dec 2024 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733752297;
	bh=X3svPo3PpGuuyArPt3jHEZ/HCf7p6Yd4FykOR/w20Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSJpfRnobFlxzeagt1jrPg57O0oMacIjiOoJbphK6I39uvRqPDjIlLRb7/3uelZ/t
	 scAONs0ffD/5/ZTh5PPLX53K+PP5VzmFvK0HLx9341GM0LWZGendIyLptwgGUP2NzT
	 RkIJyPwhT6lRzzNeB2uWXHwIujb+C9I8aR4t0Ab92bJ8aXE74mRhPGVbA0t2/QPhRW
	 J8S8FRUWlm6qQVN1puKS+HZMh6KNKYW8Tgi7i7YD3I/Ayc++Ka/WEXEmTBF08lun3T
	 NCCfKnej5D7Vk47EJfSEvVdb8kdP1GxGNsKxLDMHNkv9sIG633k8/gqiIcM275kYPa
	 yO+M75OUV66ug==
Date: Mon, 9 Dec 2024 13:51:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: abi: fix SVCR detection
Message-ID: <678a223f-c4c7-4752-84b0-609acaa33ad6@sirena.org.uk>
References: <20241209105237.10498-1-o451686892@gmail.com>
 <3279e669-1ee2-4792-9e10-8b40928de6b4@sirena.org.uk>
 <CAHk0Hov5k37=MtTBLWTj+Dwm4EXE0xGJS1Uc8xgyLtJxusqsww@mail.gmail.com>
 <c05f6ad8-2dc1-4ddb-b9c1-b2cddfe78819@sirena.org.uk>
 <CAHk0HotQ-=s+-FHh8pAOg10ivcRwqChG735qgDvuQd=4B1QQNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+2R3Ti4du1eZLiNS"
Content-Disposition: inline
In-Reply-To: <CAHk0HotQ-=s+-FHh8pAOg10ivcRwqChG735qgDvuQd=4B1QQNA@mail.gmail.com>
X-Cookie: Lensmen eat Jedi for breakfast.


--+2R3Ti4du1eZLiNS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2024 at 09:26:01PM +0800, Weizhao Ouyang wrote:

> > If we don't have SME we should be skipping over all the SME code and
> > never even looking at the value of SVCR.  Looking at the current version
> > of the code it does that, it branches to check_sve_in if SME is not
> > enabled.

> Yes we should skip it, this is just a minor tweak based on the
> current implementation, after all, we manually passed its value by
> svcr_in.

It's a fairly trivial tweak to make...  in any case, it looks like we
also need the same change in the save path.

> Which latest code version are you referring to? I think check_sve_in
> is in fp testcase, not in the abi testcase. (checked the -next tree)

Ah, yes sorry.

--+2R3Ti4du1eZLiNS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdW9eQACgkQJNaLcl1U
h9A3IAf/cV9gnrGSIC8uivSf+Or4FfHtm06crsjoH7q45K+rUanywHTmDXUgpSv9
/qWNkZ+Yb/ZZzmwDfAx1HIQnyuIN/Gr/mmHC3u2C9B3Rhh/O1icbZU7PRnYKu2N0
Q1YiDTbgMDVJYPXu6fGiTMy6HVBhz1MSZ5g5ZqthMuvuB+La5m+7Z4rQnSK/f8bE
VQ1Ka/VR7QbMnoLrVUoFjwaBGUCUMr0aRJpyGiG8ug1EFnESJRf4SNSx/5QI5+Nf
eDCMAiPq11Rf5sFsJMSIM1zufNRESwdSOhvVaUzCaZV3zQs1UbDsvW54MUbzamqk
PQYNe5Q7g+1uddbve9jfAdPeX/TDyA==
=dt8z
-----END PGP SIGNATURE-----

--+2R3Ti4du1eZLiNS--

