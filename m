Return-Path: <linux-kselftest+bounces-15316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52394951BB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 15:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76971F22D64
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532251B29A7;
	Wed, 14 Aug 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhzj/ulf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255441B29A3;
	Wed, 14 Aug 2024 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641651; cv=none; b=oWpaEDYtukJzfvpbeRN5toy0LI/nbKLkWrsqBB22w5KRriygEzZ6q3GvsHdsFje0dybz1cv+rC+FNRMAjq7xjqnRGBrdJv6ZtM3gzpFNrPC/iyIILTSS6OSEWnz9HMSUdnHRRQ2Klh8PmYvbNrSdh7hqz4+ShisYAbjLRkcrphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641651; c=relaxed/simple;
	bh=H8B+ZeihPN20CX76N3ba7SG1HkcJJ+LNDpRzNR81ZzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op1OaWmoVDq6SZVhl6kFKfBfWA364Jc8RZdaddU/QQ5YfFwYfFB/7gS6E5DoKHdchSZoNJcOLvqTE/vsekxUI/C/tILCF2OqJy3g8mFuR2R/EVQ3RV78qSAQZwCCVltg028ydaJXXFwYzESKcNWSeDEoYVoo9U4wzww29+ggr2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhzj/ulf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FE6C4AF0F;
	Wed, 14 Aug 2024 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723641650;
	bh=H8B+ZeihPN20CX76N3ba7SG1HkcJJ+LNDpRzNR81ZzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yhzj/ulfO0RJII9o9/PauauDjXBPiy2XS7584unItmKwL7+fT4wLT8d8AeVqPD5GB
	 Z2I76H3JxQ0PRbxbpXZORjqjA9jihtTi/t71quMLorIP+Bo8kQYwb9S/WoJ6Cr48MC
	 Q2Od0TNRsXhsQpQv7mu/XMcX+i3nJfFhsf6g0vAAuL+5xcNWCr5JsIgR+1VzD5Hii/
	 ylKJ/Cdm3LwojtPVv9GN0iiPI/h4arM2teruKWRPNiCzfekkicEUopVORG7aUqNmyR
	 6f/prE89LnQMKrKwLpHfcgZPoZ028mWM0PbFOOzcQFkmgCSgmQoGUG1Y8ZLDtN2c1x
	 K9+hBsK/N0mQg==
Date: Wed, 14 Aug 2024 14:20:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <b789831b-d744-4173-84a6-61a07bff905e@sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <ZrZdrgOQVHhCyWmA@arm.com>
 <Zrag5A5K9pv1K9Uz@finisterre.sirena.org.uk>
 <ZruJCyXDRNhw6U5A@arm.com>
 <e24a93cb-e7ba-4046-a7c6-fe2ea12420e3@sirena.org.uk>
 <Zrx7Lj09b99ozgAE@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l+gPSwKlPgIWiTU7"
Content-Disposition: inline
In-Reply-To: <Zrx7Lj09b99ozgAE@arm.com>
X-Cookie: The second best policy is dishonesty.


--l+gPSwKlPgIWiTU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2024 at 10:38:54AM +0100, Catalin Marinas wrote:
> On Tue, Aug 13, 2024 at 07:58:26PM +0100, Mark Brown wrote:

> > ISTR the concerns were around someone being clever with vfork() but I
> > don't remember anything super concrete.  In terms of the inconsistency
> > here that was actually another thing that came up - if userspace
> > specifies a stack for clone3() it'll just get used even with CLONE_VFORK
> > so it seemed to make sense to do the same thing for the shadow stack.
> > This was part of the thinking when we were looking at it, if you can
> > specify a regular stack you should be able to specify a shadow stack.

> Yes, I agree. But by this logic, I was wondering why the current clone()
> behaviour does not allocate a shadow stack when a new stack is
> requested with CLONE_VFORK. That's rather theoretical though and we may
> not want to change the ABI.

The default for vfork() is to reuse both the normal and shadow stacks,
clone3() does make it all much more flexible.  All the shadow stack
ABI predates clone3(), even if it ended up getting merged after.

> Anyway, I understood this patch now and the ABI decisions. FWIW:

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

--l+gPSwKlPgIWiTU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma8rykACgkQJNaLcl1U
h9BYmQf/YgJrH3MQHcexvWEKefsPyqgzIhddLhnB043UPgEOWfxP5jw/EwXt9URd
Zm0BqKwhm/pYyNq6E49xVmubE1QUYrA27iJ1W8h9YN/w7zjcLYui946FOFdJgouS
HThXKY2D5ggFIvjI72l9D8H38c/HCQIcpEjJ/jaVdPkbrTO7mf4KUYo2jUVmPlvS
ZxjwZIPZr/ubMi7aS5eL9vhZ42FELPkBi/bkMZ1su+96awHbZU6g9V9fpjnkt84N
9EowvCYQGhVNAxg3936eMYGY9+ciXMysqXeN1UVv/lN9yfgI95ANQqzCwLaR71AH
SGMpBjWQXE/T6uVxcSByywNgzDxY7A==
=q9y2
-----END PGP SIGNATURE-----

--l+gPSwKlPgIWiTU7--

