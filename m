Return-Path: <linux-kselftest+bounces-30667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A2DA87E3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EE83AEC0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188227D79E;
	Mon, 14 Apr 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BTsWDRsX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gKgu5XMb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E027E1CC;
	Mon, 14 Apr 2025 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628232; cv=none; b=t02duAv0ogt5pj7Ta79RAgGOwP+eKbBElkKshv8gV2TKXjnJNs/q9ybpnDlb5yuNkd6PSNa1YGuuxACAatYdWWwP955xz1b7mk0vsXA46Ht8zmtArtb1FnaWmxgB0hqhcbLlFQ5jUqNKCrTlDM92ZaBVAZlTe8tcjoxdJsx9FU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628232; c=relaxed/simple;
	bh=Be2ydnxapnJ1r1uZegCpXDABpgwYbmS9LN3MXZ+3AaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwmZxgiJGSGI4LGP1FzQlwACoPhSscy0uCBprfTLAM8cXm5KcOUezZ2gXSyR+xLSgKMk02r+9ChDYMZr2lQ6lDKxx409ymwgZB67qnjKqsf1rIVyRkcfyEPsE/T5W+P1TJSIUtr85lGM8rD4zMjRvhqSQ5HSHJwuSyjQkuS9H+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BTsWDRsX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gKgu5XMb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 12:57:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744628228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0kuMBxWgx+PRLHcph8H3TFWPvSCGgkMX4FLSszxil8=;
	b=BTsWDRsXiDcXPw3gpV903D7uHA09pxR/ZWLgPzlVuqIMaNwtzacrfJPdJ6GDH9ROtY/wvO
	iMYvOIR+zzm20lVV2g0WJm3tYmY9mYUi0jcledeICyCmdgKAT2PGKANHLS0LS7WjvirL6r
	TDB2cOytPHn2P+XH38vUpZNMq1lTAk+5xNi6GLNYj8pSQMzdixy7v6DX/5s4+okj9Dlq4R
	MumeJAvnwd269VP+F1gTTrZ0424hFRda6WdjvOmK3l/3gJoQBcgXR4QGb9RWYps18pjyPA
	Cp6fdHPvToaMAMKzR1ke+xZCozhUGMgQtW8hBNkufYh/rJJ6qNO+dgcM0FIDwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744628228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0kuMBxWgx+PRLHcph8H3TFWPvSCGgkMX4FLSszxil8=;
	b=gKgu5XMbLZ3ojKsH+N//qkaa/GL6pLpdIqpZ0RnJWIdNhDbwz0qX7cAy1F/UfnakHmGDvh
	57IRSZWUH5VxcvCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 1/2] MIPS: Don't crash in stack_top() for tasks
 without ABI or vDSO
Message-ID: <20250414125526-98c48a5a-8950-4a3d-b49a-401cd80ecfba@linutronix.de>
References: <20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de>
 <20250414-kunit-mips-v2-1-4cf01e1a29e6@linutronix.de>
 <CAAhV-H7p9TWLEYjv2K-sXUD9roMBJtkbjyq6NCEnyavG9PnWKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7p9TWLEYjv2K-sXUD9roMBJtkbjyq6NCEnyavG9PnWKw@mail.gmail.com>

On Mon, Apr 14, 2025 at 05:32:47PM +0800, Huacai Chen wrote:
> Hi, Thomas,
> 
> On Mon, Apr 14, 2025 at 4:29 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Not all tasks have an ABI associated or vDSO mapped,
> > for example kthreads never do.
> > If such a task ever ends up calling stack_top(), it will derefence the
> > NULL vdso pointer and crash.
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
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/mips/kernel/process.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> > index b630604c577f9ff3f2493b0f254363e499c8318c..66343cb6c1737c4217ddd8a2c3ca244fac0ef8a5 100644
> > --- a/arch/mips/kernel/process.c
> > +++ b/arch/mips/kernel/process.c
> > @@ -690,9 +690,11 @@ unsigned long mips_stack_top(void)
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
> > +       }
> I think the below code should also exist only when VDSO exists.
> 
>         if (current->flags & PF_RANDOMIZE)
>                 top -= VDSO_RANDOMIZE_SIZE;

Good point, thanks.
I'll move that up into the same new conditional block.

> Huacai
> 
> >
> >         /* Space for cache colour alignment */
> >         if (cpu_has_dc_aliases)
> >
> > --
> > 2.49.0
> >
> >

