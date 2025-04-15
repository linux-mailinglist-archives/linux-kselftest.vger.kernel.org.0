Return-Path: <linux-kselftest+bounces-30831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDD1A8973E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 10:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C30A3A6F18
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E824169D;
	Tue, 15 Apr 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3i1I9o32";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GmSh+KIy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6B1DDC2C;
	Tue, 15 Apr 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707432; cv=none; b=a6HWqnoP32svBJEQ3/TyezJHRAC6rgJ/SwUqPmQSHG3iAVythiagHFpxmKhgOJWjbbMY09oaczPaZIzQkJztjuPZozEkjjTJuFbQNMLJY8qTegQJrGlXqlv6r+fstViQNszjy8SzBolUFrfDt99/6jMPXcH5hKZ4oXQAXEMQDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707432; c=relaxed/simple;
	bh=5Pce2AtEzK93Zhj6F+KU+ZgspdkT5pKPBYL6DtGOlhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euJ5BNl3YLoJ1SPL7O8yirNKbLcQ3WXIri0pEdkwAIY10f4IRfxxJSP8+J0eGc5oH2q+jWlZezaprG8hjJ6nrfiU+ajW8HMn8mIccN4w4Uck2pj/kgQWovOlIWe+yeD1F3XzbFloPFBXDntZ5SWFL+5in3+z80kEH4a1auelA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3i1I9o32; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GmSh+KIy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Apr 2025 10:57:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744707429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBjsTGux679+iBHF6iPUCudibgjbCOoRRQyJB1LO3PA=;
	b=3i1I9o32N0XLBem3RciLxknrcC/EyMni3nv+nLgXE46V2v2gFuraS7GVkcPTK+X12FCtUW
	sa0v5MxAs3h+tymEMWVzjf2ELV+I/Bhps/qAYtSrRmBwT5e2oZwsX0tUJhFf4zDEOuliOk
	XADy8lcYdpQx4zHbqby5M6TngEkBqT2fb3Ps9MUVG7SJUss1zyV8YvImkCpIlpl/h1nAHE
	z9pob277ofLw5z8PYslhDbUD6a4iHyY0OFnwOR+iEN8wALheU355MidVYpVM+92mc9zemr
	iz6p0YaN/PfOBV98WoWW4BhQSrrO9sX3A3CsTD8pBcM3YvPuG1bq4y7Ek5UETw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744707429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBjsTGux679+iBHF6iPUCudibgjbCOoRRQyJB1LO3PA=;
	b=GmSh+KIyx6eP6r5M8Eb1myXLHaWZ23d3UzAKuIqNMPGhMTzm6HtOk4wHtiResiHBxz0IeG
	ES7vT8ZPyeHIl8BQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 1/2] MIPS: Don't crash in stack_top() for tasks
 without ABI or vDSO
Message-ID: <20250415105250-36205f65-86ad-4a56-9886-67a9521d373d@linutronix.de>
References: <20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de>
 <20250415-kunit-mips-v3-1-4ec2461b5a7e@linutronix.de>
 <CAAhV-H5b8ePEkCyECax37BOiqu57ZVRt_FHt11ijbPgsty+r=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5b8ePEkCyECax37BOiqu57ZVRt_FHt11ijbPgsty+r=A@mail.gmail.com>

Hi Huacai,

On Tue, Apr 15, 2025 at 04:47:31PM +0800, Huacai Chen wrote:
> On Tue, Apr 15, 2025 at 3:10 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Not all tasks have an ABI associated or vDSO mapped,
> > for example kthreads never do.
> > If such a task ever ends up calling stack_top(), it will derefence the
> > NULL ABI pointer and crash.
> >
> > This can for example happen when using kunit:
> >
> >     mips_stack_top+0x28/0xc0
> >     arch_pick_mmap_layout+0x190/0x220
> >     kunit_vm_mmap_init+0xf8/0x138
> >     __kunit_add_resource+0x40/0xa8
> >     kunit_vm_mmap+0x88/0xd8
> >     usercopy_test_init+0xb8/0x240
> >     kunit_try_run_case+0x5c/0x1a8
> >     kunit_generic_run_threadfn_adapter+0x28/0x50
> >     kthread+0x118/0x240
> >     ret_from_kernel_thread+0x14/0x1c
> >
> > Only dereference the ABI point if it is set.
> >
> > Also move the randomization adjustment into the same conditional.
> >
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/mips/kernel/process.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> > index b630604c577f9ff3f2493b0f254363e499c8318c..02aa6a04a21da437909eeac4f149155cc298f5b5 100644
> > --- a/arch/mips/kernel/process.c
> > +++ b/arch/mips/kernel/process.c
> > @@ -690,18 +690,20 @@ unsigned long mips_stack_top(void)
> >         }
> >
> >         /* Space for the VDSO, data page & GIC user page */
> > -       top -= PAGE_ALIGN(current->thread.abi->vdso->size);
> > -       top -= PAGE_SIZE;
> > -       top -= mips_gic_present() ? PAGE_SIZE : 0;
> > +       if (current->thread.abi) {
> > +               top -= PAGE_ALIGN(current->thread.abi->vdso->size);
> > +               top -= PAGE_SIZE;
> > +               top -= mips_gic_present() ? PAGE_SIZE : 0;
> I'm not sure, but maybe this line has nothing to do with VDSO.

The GIC page is also used by vDSO.
It is mapped into the process together with the regular vDSO pages in
arch_setup_additional_pages().
They should only ever be there together.


Thomas

> > +
> > +               /* Space to randomize the VDSO base */
> > +               if (current->flags & PF_RANDOMIZE)
> > +                       top -= VDSO_RANDOMIZE_SIZE;
> > +       }
> >
> >         /* Space for cache colour alignment */
> >         if (cpu_has_dc_aliases)
> >                 top -= shm_align_mask + 1;
> >
> > -       /* Space to randomize the VDSO base */
> > -       if (current->flags & PF_RANDOMIZE)
> > -               top -= VDSO_RANDOMIZE_SIZE;
> > -
> >         return top;
> >  }
> >
> >
> > --
> > 2.49.0
> >

