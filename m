Return-Path: <linux-kselftest+bounces-15238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B823950A13
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF975282955
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822F1A2548;
	Tue, 13 Aug 2024 16:25:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0C168C20;
	Tue, 13 Aug 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566355; cv=none; b=u8+YigPjetXTkT0JWy9c61NBn/VRrt2BH4xiXmsL4LxBOWstDLiJ6mOIkziJMleWex181rME8tw4LVFgNgUG5r2ch8+n9DPqlgQ4Df18mVGUgSbSwSyRS0yZZFFSq+15+ejjoEkoSjmYg2wGlc8bI3U2hDUT8QsTsMGUPPfsoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566355; c=relaxed/simple;
	bh=VbslBfj/ed0vJIua5/jo/+eOcWC6UtockTfeh7ffBtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb7Mucd4aNqBfM8ULAHnlg8XS2vjqBfCt/tXHvBTqV0gong+GEVnrNlo89xEDw9YAk9W8gZSyh/664W0LMEiRKVEOj16hH82n9zw6qHOwsJCQXTy2e5/HDeIDPowGvDUefJ7XdZQmMGYFAQgBr5+aJhr1Z/QugedevjejIUcdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59339C4AF09;
	Tue, 13 Aug 2024 16:25:50 +0000 (UTC)
Date: Tue, 13 Aug 2024 17:25:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
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
Message-ID: <ZruJCyXDRNhw6U5A@arm.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <ZrZdrgOQVHhCyWmA@arm.com>
 <Zrag5A5K9pv1K9Uz@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrag5A5K9pv1K9Uz@finisterre.sirena.org.uk>

On Sat, Aug 10, 2024 at 12:06:12AM +0100, Mark Brown wrote:
> On Fri, Aug 09, 2024 at 07:19:26PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 08, 2024 at 09:15:25AM +0100, Mark Brown wrote:
> > > +	/* This should really be an atomic cmpxchg.  It is not. */
> > > +	if (access_remote_vm(mm, addr, &val, sizeof(val),
> > > +			     FOLL_FORCE) != sizeof(val))
> > > +		goto out;
> 
> > If we restrict the shadow stack creation only to the CLONE_VM case, we'd
> > not need the remote vm access, it's in the current mm context already.
> > More on this below.
> 
> The discussion in previous iterations was that it seemed better to allow
> even surprising use cases since it simplifies the analysis of what we
> have covered.  If the user has specified a shadow stack we just do what
> they asked for and let them worry about if it's useful.

Thanks for the summary of the past discussions, the patch makes more
sense now. I guess it's easier to follow a clone*() syscall where one
can set a new stack pointer even in the !CLONE_VM case. Just let it set
the shadow stack as well with the new ABI.

However, the x86 would be slightly inconsistent here between clone() and
clone3(). I guess it depends how you look at it. The classic clone()
syscall, if one doesn't pass CLONE_VM but does set new stack, there's no
new shadow stack allocated which I'd expect since it's a new stack.
Well, I doubt anyone cares about this scenario. Are there real cases of
!CLONE_VM but with a new stack?

> > > +	if (val != expected)
> > > +		goto out;
> 
> > I'm confused that we need to consume the token here. I could not find
> > the default shadow stack allocation doing this, only setting it via
> > create_rstor_token() (or I did not search enough). In the default case,
> > is the user consuming it? To me the only difference should been the
> > default allocation vs the one passed by the user via clone3(), with the
> > latter maybe requiring the user to set the token initially.
> 
> As discussed for a couple of previous versions if we don't have the
> token and userspace can specify any old shadow stack page as the shadow
> stack this allows clone3() to be used to overwrite the shadow stack of
> another thread, you can point to a shadow stack page which is currently
> in use and then run some code that causes shadow stack writes.  This
> could potentially then in turn be used as part of a bigger exploit
> chain, probably it's hard to get anything beyond just causing the other
> thread to fault but won't be impossible.
> 
> With a kernel allocated shadow stack this is not an issue since we are
> placing the shadow stack in new memory, userspace can't control where we
> place it so it can't overwrite an existing shadow stack.

IIUC, the kernel-allocated shadow stack will have the token always set
while the user-allocated one will be cleared. I was looking to
understand the inconsistency between these two cases in terms of the
final layout of the new shadow stack: one with the token, the other
without. I can see the need for checking but maybe start with requiring
it to be 0 and setting the token before returning, for consistency with
clone().

In the kernel-allocated shadow stack, is the token used for anything? I
can see it's used for signal delivery and return but I couldn't figure
out what it is used for in a thread's shadow stack.

Also, can one not use the clone3() to point to the clone()-allocated
shadow stack? Maybe that's unlikely as an app tends to stick to one
syscall flavour or the other.

> > > +		/*
> > > +		 * For CLONE_VFORK the child will share the parents
> > > +		 * shadow stack.  Make sure to clear the internal
> > > +		 * tracking of the thread shadow stack so the freeing
> > > +		 * logic run for child knows to leave it alone.
> > > +		 */
> > > +		if (clone_flags & CLONE_VFORK) {
> > > +			shstk->base = 0;
> > > +			shstk->size = 0;
> > > +			return 0;
> > > +		}
> 
> > I think we should leave the CLONE_VFORK check on its own independent of
> > the clone3() arguments. If one passes both CLONE_VFORK and specific
> > shadow stack address/size, they should be ignored (or maybe return an
> > error if you want to make it stricter).
> 
> This is existing logic from the current x86 code that's been reindented
> due to the addition of explicitly specified shadow stacks, it's not new
> behaviour.  It is needed to stop the child thinking it has the parent's
> shadow stack in the CLONE_VFORK case.

I figured that. But similar to the current !CLONE_VM behaviour where no
new shadow stack is allocated even if a new stack is passed to clone(),
I was thinking of something similar here for consistency: don't set up a
shadow stack in the CLONE_VFORK case or at least allow it only if a new
stack is being set up (if we extend this to clone(), it would be a small
ABI change).

> > > -	/*
> > > -	 * For !CLONE_VM the child will use a copy of the parents shadow
> > > -	 * stack.
> > > -	 */
> > > -	if (!(clone_flags & CLONE_VM))
> > > -		return 0;
> > > +		/*
> > > +		 * For !CLONE_VM the child will use a copy of the
> > > +		 * parents shadow stack.
> > > +		 */
> > > +		if (!(clone_flags & CLONE_VM))
> > > +			return 0;
> 
> > Is the !CLONE_VM case specific only to the default shadow stack
> > allocation? Sorry if this has been discussed already (or I completely
> > forgot) but I thought we'd only implement this for the thread creation
> > case. The typical fork() for a new process should inherit the parent's
> > layout, so applicable to the clone3() with the shadow stack arguments as
> > well (which should be ignored or maybe return an error with !CLONE_VM).
> 
> This is again all existing behaviour for the case where the user has not
> specified a shadow stack reindented, as mentioned above if the user has
> specified one explicitly then we just do what we were asked.  The
> existing behaviour is to only create a new shadow stack for the child in
> the CLONE_VM case and leave the child using the same shadow stack as the
> parent in the copied mm for !CLONE_VM.

I guess I was rather questioning the current choices than the new
clone3() ABI. But even for the new clone3() ABI, does it make sense to
set up a shadow stack if the current stack isn't changed? We'll end up
with a lot of possible combinations that will never get tested but
potentially become obscure ABI. Limiting the options to the sane choices
only helps with validation and unsurprising changes later on.

> > > @@ -2790,6 +2808,8 @@ pid_t kernel_clone(struct kernel_clone_args *args)
> > >  	 */
> > >  	trace_sched_process_fork(current, p);
> > >  
> > > +	shstk_post_fork(p, args);
> 
> > Do we need this post fork call? Can we not handle the setup via the
> > copy_thread() path in shstk_alloc_thread_stack()?
> 
> It looks like we do actually have the new mm in the process before we
> call copy_thread() so we could move things into there though we'd loose
> a small bit of factoring out of the error handling (at one point I had
> more code factored out but right now it's quite small, looking again we
> could also factor out the get_task_mm()/mput()).  ISTR having the new
> process' mm was the biggest reason for this initially but looking again
> I'm not sure why that was.  It does still feel like even the small
> amount that's factored out currently is useful though, a bit less
> duplication in the architecture code which feels welcome here.

I think you can probably keep this. My comment was based on the
assumption that we only support the CLONE_VM case where we wouldn't need
the access_remote_vm(), just some direct write similar to
write_user_shstk_64().

I still think we should have limited this ABI to the CLONE_VM and
!CLONE_VFORK cases but I don't have a strong view if the consensus was
to allow it for classic fork() and vfork() like uses (I just think they
won't be used).

-- 
Catalin

