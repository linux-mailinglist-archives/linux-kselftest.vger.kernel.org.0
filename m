Return-Path: <linux-kselftest+bounces-15262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56569950CA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BA11F227B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2D1A3BC4;
	Tue, 13 Aug 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaTTFG/q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539271A38EC;
	Tue, 13 Aug 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575515; cv=none; b=mMnhlYu/5Pu1/AC15rQlZj3GV4YEq9bpLS7LQCX63e0wC0nU9YLR/K6gu4n+DI0VoTbk0dTtuqQRUsPxzpFu5yLnJasds0UxCHvI1oU0/AZ9rVrF5qbWNvfHkVPUB5+D1IL/r+6bM67y3l+ffnoi+TiZjehI1cJpxtTFtxrOr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575515; c=relaxed/simple;
	bh=bzOTwvEQWgF/+KB1LS90zt/LDnDOFda+OzNJbVJMQVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwesdTMkYkTwhft7XXf/eXgJeQ9OKAsZkgKvSFHqnV2XhiA/huXCM6xkK+tfg1ibm4WHOCT/EAw7QoMd4k2DqW/5HVoaKBrejtpVO0Qf9mZeG1Z37Accq6cI+bMLeTejZI37GN4FfOS1UU0fKMV+P40aXpJvCiteQXx1FrD5hNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaTTFG/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949C6C32782;
	Tue, 13 Aug 2024 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723575514;
	bh=bzOTwvEQWgF/+KB1LS90zt/LDnDOFda+OzNJbVJMQVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XaTTFG/qw60F6ftoxoDHNTahfNuvmpeUBWrIdaiu5sEF7fWrAaM68hPz7ny4DMamj
	 TU64xMWy7tEQUrr0+QKNKvGsvSTmuXQ34jMferkzHMsEocbMyTTfrH1xoVFEb2hdRP
	 Jc0qw8HuI0JFeUINzVHNpmvqviB8HGn0l3E/FwQUoAY2UvnBzTLvalP0Ayq6vbHljE
	 HqO9LF/bsJRDTjVyq/e2qR+ZZ1W5fWMcdNpjPjKJkAqvMH09SViYPBGnsshWszDeAM
	 BWqMmihBTQWJe4iBoL5Lispz1wjx5Pna7yAspwEBdRY95tM4yQ++wf7DrMgKuWclU5
	 cLisig/CXnSbw==
Date: Tue, 13 Aug 2024 19:58:26 +0100
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
Message-ID: <e24a93cb-e7ba-4046-a7c6-fe2ea12420e3@sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <ZrZdrgOQVHhCyWmA@arm.com>
 <Zrag5A5K9pv1K9Uz@finisterre.sirena.org.uk>
 <ZruJCyXDRNhw6U5A@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JaZr/mR7zRxR0n2p"
Content-Disposition: inline
In-Reply-To: <ZruJCyXDRNhw6U5A@arm.com>
X-Cookie: Say no, then negotiate.


--JaZr/mR7zRxR0n2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2024 at 05:25:47PM +0100, Catalin Marinas wrote:

> However, the x86 would be slightly inconsistent here between clone() and
> clone3(). I guess it depends how you look at it. The classic clone()
> syscall, if one doesn't pass CLONE_VM but does set new stack, there's no
> new shadow stack allocated which I'd expect since it's a new stack.
> Well, I doubt anyone cares about this scenario. Are there real cases of
> !CLONE_VM but with a new stack?

ISTR the concerns were around someone being clever with vfork() but I
don't remember anything super concrete.  In terms of the inconsistency
here that was actually another thing that came up - if userspace
specifies a stack for clone3() it'll just get used even with CLONE_VFORK
so it seemed to make sense to do the same thing for the shadow stack.
This was part of the thinking when we were looking at it, if you can
specify a regular stack you should be able to specify a shadow stack.

> > > I'm confused that we need to consume the token here. I could not find
> > > the default shadow stack allocation doing this, only setting it via
> > > create_rstor_token() (or I did not search enough). In the default case,

> > As discussed for a couple of previous versions if we don't have the
> > token and userspace can specify any old shadow stack page as the shadow
> > stack this allows clone3() to be used to overwrite the shadow stack of
> > another thread, you can point to a shadow stack page which is currently

> IIUC, the kernel-allocated shadow stack will have the token always set
> while the user-allocated one will be cleared. I was looking to

No, when the kernel allocates we don't bother with tokens at all.  We
only look for and clear a token with the user specified shadow stack.

> understand the inconsistency between these two cases in terms of the
> final layout of the new shadow stack: one with the token, the other
> without. I can see the need for checking but maybe start with requiring
> it to be 0 and setting the token before returning, for consistency with
> clone().

The layout should be the same, the shadow stack will point to where the
token would be - the only difference is if we checked to see if there
was a token there.  Since we either clear the token on use or allocate a
fresh page in both cases the value there will be 0.

> In the kernel-allocated shadow stack, is the token used for anything? I
> can see it's used for signal delivery and return but I couldn't figure
> out what it is used for in a thread's shadow stack.

For arm64 we place differently formatted tokens there during signal
handling, and a token is placed at the top of the stack as part of the
architected stack pivoting instructions (and a token at the destination
consumed).  I believe x86 has the same pivoting behaviour but ICBW.  A
user specified shadow stack is handled in a very similar way to what
would happen if the newly created thread immediately pivoted to the
specified stack.

> Also, can one not use the clone3() to point to the clone()-allocated
> shadow stack? Maybe that's unlikely as an app tends to stick to one
> syscall flavour or the other.

A valid token will only be present on an inactive stack.  If a thread
pivots away from a kernel allocated stack then another thread could be
started using the original kernel allocated stack, any program doing
this should think carefully about the lifecycle of the kernel allocated
stack but it's possible.  If a thread has not pivoted away from it's
stack then there won't be a token at the top of the stack and it won't
be possible to pivot to it.

> > > > +		/*
> > > > +		 * For CLONE_VFORK the child will share the parents
> > > > +		 * shadow stack.  Make sure to clear the internal
> > > > +		 * tracking of the thread shadow stack so the freeing
> > > > +		 * logic run for child knows to leave it alone.
> > > > +		 */
> > > > +		if (clone_flags & CLONE_VFORK) {
> > > > +			shstk->base = 0;
> > > > +			shstk->size = 0;
> > > > +			return 0;
> > > > +		}

> > > I think we should leave the CLONE_VFORK check on its own independent of
> > > the clone3() arguments. If one passes both CLONE_VFORK and specific
> > > shadow stack address/size, they should be ignored (or maybe return an
> > > error if you want to make it stricter).

> > This is existing logic from the current x86 code that's been reindented
> > due to the addition of explicitly specified shadow stacks, it's not new
> > behaviour.  It is needed to stop the child thinking it has the parent's
> > shadow stack in the CLONE_VFORK case.

> I figured that. But similar to the current !CLONE_VM behaviour where no
> new shadow stack is allocated even if a new stack is passed to clone(),
> I was thinking of something similar here for consistency: don't set up a
> shadow stack in the CLONE_VFORK case or at least allow it only if a new
> stack is being set up (if we extend this to clone(), it would be a small
> ABI change).

We could restrict specifying a shadow stack to only be supported when a
regular stack is also specified, if we're doing that I'd prefer to do it
in all cases rather than only for vfork() since that reduces the number
of special cases and we don't restrict normal stacks like that.

> > This is again all existing behaviour for the case where the user has not
> > specified a shadow stack reindented, as mentioned above if the user has
> > specified one explicitly then we just do what we were asked.  The
> > existing behaviour is to only create a new shadow stack for the child in
> > the CLONE_VM case and leave the child using the same shadow stack as the
> > parent in the copied mm for !CLONE_VM.

> I guess I was rather questioning the current choices than the new
> clone3() ABI. But even for the new clone3() ABI, does it make sense to
> set up a shadow stack if the current stack isn't changed? We'll end up
> with a lot of possible combinations that will never get tested but
> potentially become obscure ABI. Limiting the options to the sane choices
> only helps with validation and unsurprising changes later on.

OTOH if we add the restrictions it's more code (and more test code) to
check, and thinking about if we've missed some important use case.  Not
that it's a *huge* amount of code, like I say I'd not be too unhappy
with adding a restriction on having a regular stack specified in order
to specify a shadow stack.

--JaZr/mR7zRxR0n2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma7rNIACgkQJNaLcl1U
h9CPOwgAhRsMUFUWqUBQAY87sn9Eho7e/XEGNBzG4wFsXhxo19m4mV9kO/6eZ4ZG
wn2C3K4Dedbv0qtdLo6b8Z40gaL7KNNxO6zduSEU5nnPz8469NK2xXROJu1HsK/j
D/dRe+BobnPBjowgToHsm2wtIVX8pplu++NlFKajKro5/4tm8d/iczguqTKw1pal
AVVZOj74lRWr/CJ6TYsoOZuPAdHNd/iesrm6TseyYsUY6/XRYDHs4L+EibcW5FPx
EMmBSb0d+AIJsymwo6W5ggkIXinkaZMIl56/dKc+rQCniqfIcobFcEET8NaN4R08
a9+8oX9lWQ1A5WVsN9BDhBpqPGheNA==
=5ECP
-----END PGP SIGNATURE-----

--JaZr/mR7zRxR0n2p--

