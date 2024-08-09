Return-Path: <linux-kselftest+bounces-15100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3394D8FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 01:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD29828184D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A59B16CD2B;
	Fri,  9 Aug 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/csMJl8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DF1607AF;
	Fri,  9 Aug 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244784; cv=none; b=CBYktqmhZkiDNDbW1TuibJlra1FEidLNWaszBsdjmkd1Jf+xyDgXXaBAKNzutIAvHsaC4wwQFz8NOJbhyuN8oQYS21c2EQPeoQiA3/BGT6ffqrZmtQkiD2CshC6YWQRnCFjjNkkaYl+5XcQaL5yEjtaGSqFmgji69Os6SBBmODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244784; c=relaxed/simple;
	bh=BwFadedF5rj9rHUpdYtKkGHf7SYGqFjoEgqWwCF1UD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsU9DwkTVmjs9SCWnOQaeAF/tDThFiUUJfGFJaJXFhshAPzYg++2XBgymI4//X121lmOzzwDHSsFpk3EPvEH24CFy7NNjnoeFVHNdYsVDJe/KmhidZ/kzpEZFUMmCAS/jXhoyuQ//mHxKZW28jox30MRcgyb9x4V8pVN+z7HjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/csMJl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BFDC4AF10;
	Fri,  9 Aug 2024 23:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723244784;
	bh=BwFadedF5rj9rHUpdYtKkGHf7SYGqFjoEgqWwCF1UD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/csMJl8QqWNRzHe4O2Oh/D2HjQdYXYJOFjTWkGLrl5Pg/18MvOlw6fe/PouHcaEX
	 31h1e/OdO8hYuT9f1OB7ii6pcmtCOHiBtMqXTG2Mn6UVBkhO2QuXrEeUe42gCasrFG
	 SilEMZJtjGH30T14nObqxxLCf0yz0st1RI4pZoI9L8G5MLBjvtwAyCx62QFnqKnN4B
	 ubMyM9ZmJmyT44HR1hYHCnj8iKPtXInOrJytBy0FWu1NeKSZHB/OD0Fv2IlxIa36CV
	 xHJGTyaxsoHP7LBzc/MWahStrMOkiPaAJDYwhccoLK1TOSEPAW0kMn5AwSros5MVam
	 pmSKTzFHkMRrg==
Date: Sat, 10 Aug 2024 00:06:12 +0100
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
Message-ID: <Zrag5A5K9pv1K9Uz@finisterre.sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <ZrZdrgOQVHhCyWmA@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+vqlBicxCJXdkp6"
Content-Disposition: inline
In-Reply-To: <ZrZdrgOQVHhCyWmA@arm.com>
X-Cookie: Your love life will be... interesting.


--x+vqlBicxCJXdkp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 07:19:26PM +0100, Catalin Marinas wrote:
> On Thu, Aug 08, 2024 at 09:15:25AM +0100, Mark Brown wrote:

> > +	/* This should really be an atomic cmpxchg.  It is not. */
> > +	if (access_remote_vm(mm, addr, &val, sizeof(val),
> > +			     FOLL_FORCE) !=3D sizeof(val))
> > +		goto out;

> If we restrict the shadow stack creation only to the CLONE_VM case, we'd
> not need the remote vm access, it's in the current mm context already.
> More on this below.

The discussion in previous iterations was that it seemed better to allow
even surprising use cases since it simplifies the analysis of what we
have covered.  If the user has specified a shadow stack we just do what
they asked for and let them worry about if it's useful.

> > +	if (val !=3D expected)
> > +		goto out;

> I'm confused that we need to consume the token here. I could not find
> the default shadow stack allocation doing this, only setting it via
> create_rstor_token() (or I did not search enough). In the default case,
> is the user consuming it? To me the only difference should been the
> default allocation vs the one passed by the user via clone3(), with the
> latter maybe requiring the user to set the token initially.

As discussed for a couple of previous versions if we don't have the
token and userspace can specify any old shadow stack page as the shadow
stack this allows clone3() to be used to overwrite the shadow stack of
another thread, you can point to a shadow stack page which is currently
in use and then run some code that causes shadow stack writes.  This
could potentially then in turn be used as part of a bigger exploit
chain, probably it's hard to get anything beyond just causing the other
thread to fault but won't be impossible.

With a kernel allocated shadow stack this is not an issue since we are
placing the shadow stack in new memory, userspace can't control where we
place it so it can't overwrite an existing shadow stack.

> > +		/*
> > +		 * For CLONE_VFORK the child will share the parents
> > +		 * shadow stack.  Make sure to clear the internal
> > +		 * tracking of the thread shadow stack so the freeing
> > +		 * logic run for child knows to leave it alone.
> > +		 */
> > +		if (clone_flags & CLONE_VFORK) {
> > +			shstk->base =3D 0;
> > +			shstk->size =3D 0;
> > +			return 0;
> > +		}

> I think we should leave the CLONE_VFORK check on its own independent of
> the clone3() arguments. If one passes both CLONE_VFORK and specific
> shadow stack address/size, they should be ignored (or maybe return an
> error if you want to make it stricter).

This is existing logic from the current x86 code that's been reindented
due to the addition of explicitly specified shadow stacks, it's not new
behaviour.  It is needed to stop the child thinking it has the parent's
shadow stack in the CLONE_VFORK case.

> > -	/*
> > -	 * For !CLONE_VM the child will use a copy of the parents shadow
> > -	 * stack.
> > -	 */
> > -	if (!(clone_flags & CLONE_VM))
> > -		return 0;
> > +		/*
> > +		 * For !CLONE_VM the child will use a copy of the
> > +		 * parents shadow stack.
> > +		 */
> > +		if (!(clone_flags & CLONE_VM))
> > +			return 0;

> Is the !CLONE_VM case specific only to the default shadow stack
> allocation? Sorry if this has been discussed already (or I completely
> forgot) but I thought we'd only implement this for the thread creation
> case. The typical fork() for a new process should inherit the parent's
> layout, so applicable to the clone3() with the shadow stack arguments as
> well (which should be ignored or maybe return an error with !CLONE_VM).

This is again all existing behaviour for the case where the user has not
specified a shadow stack reindented, as mentioned above if the user has
specified one explicitly then we just do what we were asked.  The
existing behaviour is to only create a new shadow stack for the child in
the CLONE_VM case and leave the child using the same shadow stack as the
parent in the copied mm for !CLONE_VM.

> > @@ -2790,6 +2808,8 @@ pid_t kernel_clone(struct kernel_clone_args *args)
> >  	 */
> >  	trace_sched_process_fork(current, p);
> > =20
> > +	shstk_post_fork(p, args);

> Do we need this post fork call? Can we not handle the setup via the
> copy_thread() path in shstk_alloc_thread_stack()?

It looks like we do actually have the new mm in the process before we
call copy_thread() so we could move things into there though we'd loose
a small bit of factoring out of the error handling (at one point I had
more code factored out but right now it's quite small, looking again we
could also factor out the get_task_mm()/mput()).  ISTR having the new
process' mm was the biggest reason for this initially but looking again
I'm not sure why that was.  It does still feel like even the small
amount that's factored out currently is useful though, a bit less
duplication in the architecture code which feels welcome here.

--x+vqlBicxCJXdkp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma2oOEACgkQJNaLcl1U
h9DJAAf+JgJexSTM8FYO5LJrp+jcI3PrWuxmpz8oe4r2ikqJ0cNCDIythdgUWZi/
cq2eE1HvcKW/hHzIXqZNTung2CRIzciY3mURpSSoZ5QEb07VJ6aGpqUjhRIcpf/h
jdy+rbBRgXD7mv1fvrHVsBz29a6+Ke5hbmSg5VoWYpb8PH7LTxJvtdTh+5j0Gu21
t5DBD7ZgayCI9k4O7wCcAacCKmZqv+2SEYNpfYGHzXuL4HZZkdGs8gCI2GVYW5rR
+g80dalbhsVWhEq9bMfESemL2Rb5BSINFey6n7bRcACK1+/I7eSNprv5L1GL/AKK
clCbRH0HNAvbw9ymbemgTt0U/cU2ZA==
=MunQ
-----END PGP SIGNATURE-----

--x+vqlBicxCJXdkp6--

