Return-Path: <linux-kselftest+bounces-36016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E68AEC20F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 23:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DE31BC2642
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 21:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D38128689B;
	Fri, 27 Jun 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulTQ0PDY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5428688D;
	Fri, 27 Jun 2025 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059877; cv=none; b=FgBTMirkZ62IDARmRbWGHK4kO6xkUk52y62zQE91ocuK68rNGQi1/ODprfCEGKPwZlITvQLP1Ryt/yWnibvsOeJthkejZ7tM56urpg7jfOaGZ4ZIdJzgV4zkzJI3sauflRoYL5jctkmpVqEI3ju5NLRzKubI66YMWN68xY9nY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059877; c=relaxed/simple;
	bh=YLXV8EixeUReXW5ZLTeMWikhsalQi3MACoUyTuNGqz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoAh5A1spShOA0I3Nt2m9t2MP7L7lr0ri2Mz7T/XRKvq86CS+GQbbvAI4jDv0AqmEjxpeunPmfAuETQQSzi9Z+fDmqK4hijRw2bjff26xzuLQg4l9RQ7UwjfStRUyRsAhAg27OxTVYbn6aApDHE9HX4aD+SYWWUf+tThciwJD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulTQ0PDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24421C4CEE3;
	Fri, 27 Jun 2025 21:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751059876;
	bh=YLXV8EixeUReXW5ZLTeMWikhsalQi3MACoUyTuNGqz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulTQ0PDYilia4lKDRwJPu2ZtsqAJmLrrmFeA3ncmWPCu0uNCylWiIMhXujRtZYFX5
	 i6N1zKT31M6wi7g5eTaQMsK/8up0dyNs/ma6PTWVEYichOeDToYhbkpa3E8nv4C149
	 3p7JdGcTRkesEbC1z07vXA3dNBPKWpQV5cW5iUKmtnVv9lYNt1TvMYC8EBFwJfWE/V
	 pFhcisB+U8S6BWD4aq2PUTw16uXiM/pQR2hutXGoGfO5gUXAsNxajOU8SucRSTGKEd
	 YUlnuNs8vORjy1kyfMru4pq+rBfngF+BliDaJkTGJhNlCEpBidaQc/zMtvxCBMCXHu
	 My99x6XeaLl0w==
Date: Fri, 27 Jun 2025 22:31:05 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH RFT v17 4/8] fork: Add shadow stack support to clone3()
Message-ID: <97702623-0a1e-4231-9550-79aaa9d41fac@sirena.org.uk>
References: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
 <20250609-clone3-shadow-stack-v17-4-8840ed97ff6f@kernel.org>
 <aF7SpWSKfjEFTHBk@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t93JckxzxlRIaiLJ"
Content-Disposition: inline
In-Reply-To: <aF7SpWSKfjEFTHBk@arm.com>
X-Cookie: Avoid contact with eyes.


--t93JckxzxlRIaiLJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 27, 2025 at 06:19:33PM +0100, Catalin Marinas wrote:
> On Mon, Jun 09, 2025 at 01:54:05PM +0100, Mark Brown wrote:

> > +	/* Ensure that a token written as a result of a pivot is visible */
> > +	gcsb_dsync();
> > +	gcspr_el0 = args->shadow_stack_token;
> > +	if (!gcs_consume_token(vma, page, gcspr_el0))
> > +		return -EINVAL;
> > +
> > +	tsk->thread.gcspr_el0 = gcspr_el0 + sizeof(u64);
> > +
> > +	/* Ensure that our token consumption visible */
> > +	gcsb_dsync();

> What are the scenarios where we need the barriers? We have one via
> map_shadow_stack() that would cover the first one. IIUC, GCSSS2 also
> generates a GCSB event (or maybe I got it all wrong; I need to read the
> spec).

I think now that gcs_consume_token() does a cmpxchg they're redundant,
your analysis covers the first one (anything that puts a valid token
in memory should have a barrier) and now gcs_consume_token() does a
cmpxchg the second one should also be redundant thanks to R_FZRGP.  It
would be good if someone double checked though.

Originally gcs_consume_token() was using regular accesses as for the
example in DDI0487 L.a K3.3 and was tried on two addresses, I missed
dropping the barriers when changing to a cmpxchg.

> > +static int shstk_validate_clone(struct task_struct *p,
> > +				struct kernel_clone_args *args)
> > +{

> > +	mmap_read_lock(mm);

> > +	addr = untagged_addr_remote(mm, args->shadow_stack_token);

> I think down the line, get_user_page_vma_remote() already does an
> untagged_addr_remote(). But it does it after the vma look-up, so we
> still need the untagging early.

> That said, would we ever allowed a tagged pointer for the shadow stack?

For arm64 you can architecturally use tags as per G_HMJHM.  I_WBHHX says
that GCS accesses are tag unchecked, but tags are used on GCSSS1 as per
I_MGLTC and I_MBHFS.  We'll need new ABI to allow userspace to get a
PROT_MTE GCS though, I'd planned on extending map_shadow_stack() for
that, and adding handling in the token validation here.

There's also the fact that the untagging should be very cheap in the
context of what we're doing so it seems sensible to just have it,
especially generic code which applies to all arches.

> > +static inline bool clone3_shadow_stack_valid(struct kernel_clone_args *kargs)
> > +{
> > +	if (!kargs->shadow_stack_token)
> > +		return true;
> > +
> > +	if (!IS_ALIGNED(kargs->shadow_stack_token, sizeof(void *)))
> > +		return false;
> > +
> > +	/*
> > +	 * The architecture must check support on the specific
> > +	 * machine.
> > +	 */
> > +	return IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK);

> I don't understand the comment here. It implies some kind of fallback
> for further arch checks but it's just a return.

Here we're just doing initial triage that a shadow stack could possibly
be valid, the check here is there to fail if there's one specified but
there is no support in the kernel (eg, for architectures that don't have
the feature at all like arm32).  The comment is trying to say that we're
not attempting to validate that we can actually use shadow stacks on the
current system, just that the support exists in the kernel.  I'll reword
the comment, it's not clear.

> BTW, clone3_stack_valid() has an access_ok() check as well. Shall we add
> it here? That's where the size would have come in handy but IIUC the
> decision was to drop it (fine by me, just validate that the token is
> accessible).

AIUI the main reason for doing that for the normal stack is to report an
error before we actually start the thread and have it fault trying to
access an invalid stack since we don't otherwise look at the memory,
like you say with shadow stacks we'll consume the token before we start
the new thread so we get the equivalent error reporting as part of that.
I don't think the extra check would buy us much.

--t93JckxzxlRIaiLJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhfDZgACgkQJNaLcl1U
h9AmCQf9GAuPYyxk3xlRAPgt+lX60Z35ksp4eSnu/4Xa4MYPBSDLG9LH2n9UqtQB
UJIwRXXfTTx7Lxj+Zf5IFD1HmvVLLj0rWRNABpL9NaeA2QuIrrTFSTw/G9rUOMGS
8M/84Pshg7rvan+iWGkWq7MiHO3v0hp88q1SdeCgBoJkotb6+w6xEX5E+J1Muves
JuBHZBpQJG4CMg/eqR90jUi+lZO57x2WEGXMSsv+R0NehA+bIH9mU3FvjepVXu4n
VvBwsxnsH28MxcSQ+yHy89tSIYQ4NsECqFLpDMq+Ts4uFVrZ7zRKfq3hzsdIEe6b
rM5vtRy2vC77grYez0CfjWPyYva5Ag==
=373H
-----END PGP SIGNATURE-----

--t93JckxzxlRIaiLJ--

