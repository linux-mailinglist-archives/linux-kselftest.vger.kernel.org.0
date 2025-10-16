Return-Path: <linux-kselftest+bounces-43345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCAFBE4D61
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 19:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50A504F0576
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA652E0B60;
	Thu, 16 Oct 2025 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cptmv/rQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475B262A6;
	Thu, 16 Oct 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635416; cv=none; b=c96bCayVzEogQOjcXqiGMXKUq1Vx4JBbMEOPMdv2yOvlB2j8qUTZU7DItTcjFDWFv30uht71JtRnQP9ipbf4WbiRBlCL7rsigFMNP/jLIYXFDsogS8q5xOMwYJBZy2fAQ024t8y+epGdY/Pk1k+gnyFcQBmowE64/9vYositz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635416; c=relaxed/simple;
	bh=8KRuOdH4Sfs4m7wXTsUqeB7BF0nvFp/6nP6RfB3vC9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nakQa8lUWXVoOIEy8z7EKAbK4aUOmvQjOnYAyxOrT1PhlReienxPKqbux5S8i786vPa1Rt4SubLI85pxbCuizapav1Wje5eT+y+R936trWPX+jIUqGGnGZkBrVse50FchdotRnDhjVdvYNymyFJfI7NdG8GlYaEsHc3kG4GfCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cptmv/rQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6947C4CEFB;
	Thu, 16 Oct 2025 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760635415;
	bh=8KRuOdH4Sfs4m7wXTsUqeB7BF0nvFp/6nP6RfB3vC9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cptmv/rQwjCU+10SBpptRWsJuD63lNF0MMf7RXVIGHafcknkln+9JuU26krey9Zgo
	 kcGIqczaJhZyLB3waJHIP5ZXdqg+wtuNtSlxX5xgvpADcvRia4n6jX/gfBfLpL9ZoB
	 WADQbY7H39rjtZPZmB53I7xcSTigi08z+2KlmEvKJ/RkH3W6pMSSnrp0jnm5+e8R3C
	 wQDKgLdN/ylAeZYEEK9aGbO2waDGwWIsu4G+kwXodzQGj+EFUMRO8I1f/ghku16Ps5
	 OgIGHEimWmIAwf2O/knQxg6WunIwkTCgCFMpmEEN0kpnpye3PD4BwJlfvIBjyWChTA
	 A8x4NSp6Io+4g==
Date: Thu, 16 Oct 2025 20:23:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
Message-ID: <aPEqDfajAlNnhoeN@kernel.org>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-2-pasha.tatashin@soleen.com>
 <aO9ZiERHff7vQiBL@kernel.org>
 <CA+CK2bA5Eyz6TUMTy3pa5HBvZ7KkiHX3EHn17T=d6LX_X5i3bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA5Eyz6TUMTy3pa5HBvZ7KkiHX3EHn17T=d6LX_X5i3bg@mail.gmail.com>

On Wed, Oct 15, 2025 at 08:36:25AM -0400, Pasha Tatashin wrote:
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  kernel/liveupdate/Kconfig                   | 15 ++++++++++
> >
> > Feels like kernel/liveupdate/Makefile change is missing
> 
> It's not, we already have KEXEC_HANDOVER_DEBUGFS that pulls in
> kexec_handover_debug.c
> 
> That debug file contains KHO debugfs and debug code. The debug code
> adds KEXEC_HANDOVER_DEBUGFS as a dependency, which I think is
> appropriate for a debug build.
> 
> However, I do not like ugly ifdefs in .c, so perhaps, we should have two files:
> kexec_handover_debugfs.c for debugfs and kexec_handover_debug.c ? What
> do you think?
> 
> > >  kernel/liveupdate/kexec_handover.c          | 32 ++++++++++++++++++---
> > >  kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++++++
> > >  kernel/liveupdate/kexec_handover_internal.h |  9 ++++++
> > >  4 files changed, 70 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > > index 522b9f74d605..d119f4f3f4b1 100644
> > > --- a/kernel/liveupdate/Kconfig
> > > +++ b/kernel/liveupdate/Kconfig
> > > @@ -27,4 +27,19 @@ config KEXEC_HANDOVER_DEBUGFS
> > >         Also, enables inspecting the KHO fdt trees with the debugfs binary
> > >         blobs.
> > >
> > > +config KEXEC_HANDOVER_DEBUG
> > > +     bool "Enable Kexec Handover debug checks"
> > > +     depends on KEXEC_HANDOVER_DEBUGFS
> > > +     help
> > > +       This option enables extra sanity checks for the Kexec Handover
> > > +       subsystem.
> > > +
> > > +       These checks verify that neither preserved memory regions nor KHO's
> > > +       internal metadata are allocated from within a KHO scratch area.
> > > +       An overlap can lead to memory corruption during a subsequent kexec
> > > +       operation.
> > > +
> > > +       If an overlap is detected, the kernel will print a warning and the
> > > +       offending operation will fail. This should only be enabled for
> > > +       debugging purposes due to runtime overhead.
> > >  endmenu
> > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > > index 5da21f1510cc..ef1e6f7a234b 100644
> > > --- a/kernel/liveupdate/kexec_handover.c
> > > +++ b/kernel/liveupdate/kexec_handover.c
> > > @@ -141,6 +141,11 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
> > >       if (!elm)
> > >               return ERR_PTR(-ENOMEM);
> > >
> > > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
> > > +             kfree(elm);
> >
> > I think __free() cleanup would be better than this.
> 
> Sorry, not sure what do you mean. kfree() is already is in this
> function in case of failure.

There's __free(kfree) cleanup function defined in include/linux/cleanup.h
that ensures that on return from a function resources are not leaked.
With kfree we could do something like

	void *elm __free(kfree) = NULL;

	if (error)
		return ERR_PTR(errno);

	return no_free_ptr(elm);

There's no __free() definition for free_page() though :(

The second best IMHO is to use goto for error handling rather than free()
inside if (error).

> > > +             return ERR_PTR(-EINVAL);
> > > +     }
> > > +
> > >       res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> > >       if (xa_is_err(res))
> > >               res = ERR_PTR(xa_err(res));
> > > @@ -354,7 +359,13 @@ static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
> > >
> > >       chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > >       if (!chunk)
> > > -             return NULL;
> > > +             return ERR_PTR(-ENOMEM);
> >
> > I don't think it's important to return -errno here, it's not that it's
> > called from a syscall and we need to set errno for the userspace.
> > BTW, the same applies to xa_load_or_alloc() IMO.
> 
> HM, but they are very different errors: ENOMEM, the KHO user can try
> again after more memory is available, but the new -EINVAL return from
> this function tells the caller that there is something broken in the
> system, and using KHO is futile until this bug is fixed.

Do you really see the callers handling this differently? 
And we already have WARN_ON() because something is broken in the system.
 
> > > +
> > > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE))) {
> > > +             kfree(chunk);
> > > +             return ERR_PTR(-EINVAL);
> > > +     }
> > > +

-- 
Sincerely yours,
Mike.

