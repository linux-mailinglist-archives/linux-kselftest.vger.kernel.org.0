Return-Path: <linux-kselftest+bounces-14866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C3A949438
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0365128220B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C71EA0D5;
	Tue,  6 Aug 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhi5IqTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93A1D54D1;
	Tue,  6 Aug 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957011; cv=none; b=JKNTt2GlDzW0swusLbtNHRKHToWzE+ouiu8MFPeK8YAi1cHPo2uNjPxkzxBlvP+H6cNJehZf/RQBr+34Pew0vXxCPKIJHq7p20aQPD3lEsIKfRBpCbykoLlxAsEzAHTdZ4Jv/CFYwT4KAw+ukAUDt5Exbv7dUWroii0q36fDjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957011; c=relaxed/simple;
	bh=czja/tbq0SHQMKQ+vQgV5ZRFDFLhH3Fj3Pwk4oEqX80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSJNSl8POo4yhtc97Q78Iv0iE4TpoVNKyto/qi8okuNuDrQQUnSFeG8ug4TQf5fTdbo1FrTjQ8I7sGTQ2WUt3d5l8UwMw/C5RI0Yw+1ZgszCxTsKustWmr6gEnHU5SrAxv7F9Udffb9fuEF66jL3WWvdUq+X2YHvHcLvF+i8Cuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhi5IqTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5876C32786;
	Tue,  6 Aug 2024 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722957011;
	bh=czja/tbq0SHQMKQ+vQgV5ZRFDFLhH3Fj3Pwk4oEqX80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xhi5IqTcLEmPb3yCUSErtGHsGWbGVpsHxVMrNaPFf6Y8C0uHwLElSzECtFilpe4Km
	 lvFh2e3mGM/xlhLl10OMah7mcaGYqs+6vOlLGecpFmXe99te2mZSuwKzWKyAoRfh6M
	 YCDqycLJmWpyloUXigN/byaFhBPvfAtXFtjKP+jO6Wev+wKGX7S+JmC2NLGx4KdfKe
	 zs2PNoKoEaCiRLwTyZ3G7y0YQu9JX1GW1PyT0qcpZ5s1BqkNpKjhcJ1fHihLG8sGbf
	 ORO36tBBifmWNGc1R3kY47aqYnuutkTMVDvG0wYTZix408IbSJ2bOjRc0u/1d+eRno
	 89daTAzZtjd7A==
Date: Tue, 6 Aug 2024 16:10:02 +0100
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
Message-ID: <19ee6fc9-94d7-4420-abd3-7cfdf612df0c@sirena.org.uk>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E5K4oNFhFrjnR+eW"
Content-Disposition: inline
In-Reply-To: <202408052046.00BC7CBC@keescook>
X-Cookie: One picture is worth 128K words.


--E5K4oNFhFrjnR+eW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2024 at 08:54:54PM -0700, Kees Cook wrote:
> On Wed, Jul 31, 2024 at 01:14:15PM +0100, Mark Brown wrote:

> > +	case CLONE3_ARGS_SHADOW_STACK:
> > +		/* We need to specify a normal stack too to avoid corruption */
> > +		args.shadow_stack = get_shadow_stack_page(SHADOW_STACK_SET_TOKEN);
> > +		args.shadow_stack_size = getpagesize();
> > +		break;

>   # Running test 'Shadow stack on system with shadow stack'
>   # [5496] Trying clone3() with flags 0 (size 0)
>   # I am the parent (5496). My child's pid is 5505
>   # Child exited with signal 11
>   # [5496] clone3() with flags says: 11 expected 0
>   # [5496] Result (11) is different than expected (0)
>   not ok 20 Shadow stack on system with shadow stack

> The child segfaults immediately, it seems?

That's what I'd expect if we either didn't manage to create the shadow
stack token in the page we mapped or we messed up in
arch_shstk_post_fork() somehow, probably getting the wrong pointer for
the token or not mapping things correctly.  I'll have done something
silly, it'll doubtless be very obvious and embarrassing when I see it
but I'm not seeing it right now...

> > +	case CLONE3_ARGS_SHADOW_STACK_NO_POINTER:
> > +		args.shadow_stack_size = getpagesize();
> > +		break;

>   # Running test 'Shadow stack with no pointer'
>   # [5496] Trying clone3() with flags 0 (size 0)
>   # Invalid argument - Failed to create new process
>   # [5496] clone3() with flags says: -22 expected -22
>   ok 21 Shadow stack with no pointer

> This seems like it misses the failure and reports ok

No, this is testing to make sure we get the failure - if we have
arguments that can't possibly be valid then we should reject them with
an error code during validation prior to trying to create the new
thread.  The "expected -22" in the output says it's looking for an
error.  Same for the other similar expected error code.

> > +	case CLONE3_ARGS_SHADOW_STACK_NO_TOKEN:
> > +		args.shadow_stack = get_shadow_stack_page(0);
> > +		args.shadow_stack_size = getpagesize();
> > +		break;

> This actually segfaults the parent:

>   # Running test 'Shadow stack with no token'
>   # [5496] Trying clone3() with flags 0x100 (size 0)
>   # I am the parent (5496). My child's pid is 5507
>   Segmentation fault

Oh dear.  We possibly manage to corrupt the parent's shadow stack
somehow?  I don't think I managed to do that in my arm64 testing.  This
should also be something going wrong in arch_shstk_post_fork().

> Let me know what would be most helpful to dig into more...

It'll almost certianly be something in arch_shstk_post_fork(), that's
the bit I couldn't test.  Just making that always return success should
avoid the first fault, the second ought to not crash but will report a
fail as we should be rejecting the shadow stack when we try to consume
the token.

--E5K4oNFhFrjnR+eW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmayPMoACgkQJNaLcl1U
h9AK+Af/dnTytFfO/mCKL2dX+g5P0Gg01KnQrH51RKYyd1RhRAc3iDigelulFDJD
45pyvz6GZnK37WUn2qFlgyyq7eTn8LfAkU2ARo1YuJFOJuyeNZap8Zt5nuaO8V4+
A7dvRiahLV64ZbTIKezt+XJyK2d0gtHGg19RQjVFwyP3LhzCRQ41hLbDS4BHLBFi
4hpeIGqjMTkyC/buDuLkqcQn+v6mt9VgyB1ExKXWkDSwfgKgcgDuabHgPmMJKEEc
gSzsDRoxmT5F8FQtpdFObpIJRRHlJrmHhUANThYR/lOXeU2Fnvn9VC03hNs7f02l
wAk1gnhNtWjgU8d4jwHBeLdQJjqQkw==
=04Ib
-----END PGP SIGNATURE-----

--E5K4oNFhFrjnR+eW--

