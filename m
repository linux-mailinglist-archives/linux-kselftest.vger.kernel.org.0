Return-Path: <linux-kselftest+bounces-14994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 579A794B2A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 00:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AE21F21806
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FCC146017;
	Wed,  7 Aug 2024 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnCA1i1k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01264D5BD;
	Wed,  7 Aug 2024 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068211; cv=none; b=Ycl8rDyEllpoJXxX6vPGT4mdeFepCj1WIG5+CYcVm5f7bwAe1/FRMhMOrMPrgiUsMCca+ijsvxnVXI4DRdRfzFEX31ikL98NgCYgB+4rpsp+2yS6FEhtNGnaZhOq81qtHHXow/yoM2ADR8PHrFDbowr069BUKKE4USRalT83DGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068211; c=relaxed/simple;
	bh=apRbtHOpMOwo9Hq95H+j9Ifiaa3qhuwqc+VapwBrbuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVctSOV1cFAWdEc2JU3HWdFb1FnquojAAfUxidfjVqmun9vJuOEwXg11S+5Cr38TWEUqO2BJynNmoGY1foIVRZI+lr+vkAmaO/WcJC8rg+44mn7SKb70ExmiPo+iv9vgjWftx6G24NxcZvn3/aSGJf9nwhk7kgAAkK14Wyh+YRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnCA1i1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0568FC32781;
	Wed,  7 Aug 2024 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723068210;
	bh=apRbtHOpMOwo9Hq95H+j9Ifiaa3qhuwqc+VapwBrbuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnCA1i1kifnnzgJ9HyTRIu1WmXkPE4kMXfBiuxZnmrSEKokxbBR4ostuNjIkE5cuP
	 wDzNdX9ujwbTZtTfOTNmbvGj36DbL/N7JM/T1vxBk5p0vV9w0/RlQbkJ3g6JW5JIL4
	 ro5eSOpNQZzA5pmRn6bZ6alCN6RaCPJS3xGv03VQhm8OvNY/V8AZxSTr5CIk9YLKkt
	 wp7OoT6gGScSKiNpAiCucS/vr7D98pP6E0IObQ7HKWYRnMW2zutFWKMWDsyHTMDkMP
	 HbleBZg0xqXDzWkc4hShMZMherSa0SS7S5mT/TY19jsqLxrI/avzy+ZUy8XAtjIH9g
	 mv1MXWqYSs6ZQ==
Date: Wed, 7 Aug 2024 23:03:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v7 9/9] selftests/clone3: Test shadow stack support
Message-ID: <ZrPvLIjW0p8j5C1x@finisterre.sirena.org.uk>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
 <19ee6fc9-94d7-4420-abd3-7cfdf612df0c@sirena.org.uk>
 <202408062022.34F3558@keescook>
 <e5e5c0fc-3425-4020-ae7c-4b7fd0f1f263@sirena.org.uk>
 <202408071221.92B6E385C@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovsSsFUoGuk43J7e"
Content-Disposition: inline
In-Reply-To: <202408071221.92B6E385C@keescook>
X-Cookie: Your love life will be... interesting.


--ovsSsFUoGuk43J7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2024 at 12:23:01PM -0700, Kees Cook wrote:
> On Wed, Aug 07, 2024 at 01:39:27PM +0100, Mark Brown wrote:

> >  		size = args->shadow_stack_size;
> > +		shstk->base = 0;
> > +		shstk->size = 0;

> Yup, that fixes it!

>   # Totals: pass:23 fail:0 xfail:0 xpass:0 skip:1 error:0

> (The skip is "Shadow stack on system without shadow stack")

Excellent, thanks!  It's amazing how many dumb mistakes you can find if
you actually try running the code :/ .

--ovsSsFUoGuk43J7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaz7ysACgkQJNaLcl1U
h9D6nQf471aSpWTp9hbNlp8vMCtiJWKUaAuZ+t0OiPrxl5alZkAidQfo1tJ4gpH6
OxPxfAinXgzcWFgHMsnjUD1Rfpvqb9jA2Ni7fMoDkNIfeGXCF7ocedEG2SZQAa2L
04Z2R8i2Tq3AcBLHLSyuX7YTSaK25ZyhLUJWXMZNq+ytNPVTZ2XsfQ1LbQhRdQ4P
UpL4WPYWnPMJ56UzmoD/NaYS5ED750CNiMJfRSEicCCHuZ3u9nPqTb3DBxDVPNeu
P3fDaHPsq0ZKqg1LQdxmn2TyZCf/ydyJal0DSDHBF+/QF+jZWZltRUfCqKgOiR5m
stJBoppOCGUxXbeFnFtS2fsy/o+4
=Vmt3
-----END PGP SIGNATURE-----

--ovsSsFUoGuk43J7e--

