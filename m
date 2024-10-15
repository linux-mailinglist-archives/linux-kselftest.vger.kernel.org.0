Return-Path: <linux-kselftest+bounces-19701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2700799DE03
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CFB1C21137
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 06:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D15189B81;
	Tue, 15 Oct 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m++N9N8J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLS1ayk5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9518991B;
	Tue, 15 Oct 2024 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972845; cv=none; b=GnS47pBbj2lzo2004jigA9q6dAYfaqdMdjtoTdUtTHarO05348eBRyiD/QQVync8o+eISEKJzDVumA03kzTH3CN58aNAcbI5VzNz4qfZ9btDJsqf7Jj9rXbyOWqCK39IN04BIArlYixq4R/mX7mFTNwAHKFBPR6hSWC++bXS9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972845; c=relaxed/simple;
	bh=5ezQ4iOfjQC4QXS6QdvYdJ7iFydplzaRqru6e+xglpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3TOZQWV2GfDEthkD95DumlN8i7wDIMHHlJPdM2MaBekU2jvfB+Q9cJHhyWYvjkxQ99QbmjwrKDnw2vtVxJOjP/TUfb+HHTXjxaUvXI/BzIweiy4ClM7nBau73RLmZlCLI2ze6jGdwlq94oX03JmP+nOwiYNrjYrSmHRtLDhDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m++N9N8J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLS1ayk5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 08:14:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728972840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CTuybMTKk4xqMVTcmv0cjAnhK4J0k49VxoBvvmZlUg=;
	b=m++N9N8JgHQ7iw5dh4kt6PVN5qDlxzUnqbZJReTt0BFZ9aOxXbabzCchKhdK6Uztjy+CF7
	11RDYP+RIrQseXzpWjPQ32xEHqtyNSx5K1uM87ZlLoKC6BudeUsyStYDhC6HgiZfUTjxyk
	IDhm+hds/6zLibZ3OmuBKPahL4xIKbS1fuRFVWTXOllivBSy4K4ZfMrk149N35oX8Yen2x
	FyO1Na7yRvgIGzbexo3UYwK5gQhgWcf3NatMuOqegqzhoW7rEfJ/bT1BF7/d7NPY2fGprQ
	1IiTTIdmJBWXE6XwNEjKtmk0Bh++LXcmMy1ee9sScE2Lrioey42Obw8ZH5R2lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728972840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CTuybMTKk4xqMVTcmv0cjAnhK4J0k49VxoBvvmZlUg=;
	b=NLS1ayk560aF7rmCk8VBhbsOZRk0VVKh4Yxyk4bpDCWyPFIcK0GbzAPHfJlBWXOeZmq8HZ
	8GKxeknLIreEN2Aw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/4] LoongArch: Don't crash in stack_top() for tasks
 without vDSO
Message-ID: <20241015080942-1c451e52-39b4-473d-9919-6b03dbfb7008@linutronix.de>
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
 <20241014-kunit-loongarch-v1-1-1699b2ad6099@linutronix.de>
 <CAAhV-H4GvYVphn+srVFEdPboxCz-z04vXa-=e5ptJpdJZgPp=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4GvYVphn+srVFEdPboxCz-z04vXa-=e5ptJpdJZgPp=g@mail.gmail.com>

Hi Huacai,

On Tue, Oct 15, 2024 at 10:15:39AM +0800, Huacai Chen wrote:
> I can take this patch to the loongarch tree, but I think others should
> get upstream via kselftests tree?

Yes, sounds good.
Could you take a look at patches 2 and 4, too?

Thanks,
Thomas

> On Mon, Oct 14, 2024 at 7:36 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Not all tasks have a vDSO mapped, for example kthreads never do.
> > If such a task ever ends up calling stack_top(), it will derefence the
> > NULL vdso pointer and crash.
> >
> > This can for example happen when using kunit:
> >
> >         [<9000000000203874>] stack_top+0x58/0xa8
> >         [<90000000002956cc>] arch_pick_mmap_layout+0x164/0x220
> >         [<90000000003c284c>] kunit_vm_mmap_init+0x108/0x12c
> >         [<90000000003c1fbc>] __kunit_add_resource+0x38/0x8c
> >         [<90000000003c2704>] kunit_vm_mmap+0x88/0xc8
> >         [<9000000000410b14>] usercopy_test_init+0xbc/0x25c
> >         [<90000000003c1db4>] kunit_try_run_case+0x5c/0x184
> >         [<90000000003c3d54>] kunit_generic_run_threadfn_adapter+0x24/0x48
> >         [<900000000022e4bc>] kthread+0xc8/0xd4
> >         [<9000000000200ce8>] ret_from_kernel_thread+0xc/0xa4
> >
> > Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/loongarch/kernel/process.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> > index f2ff8b5d591e4fd638109d2c98d75543c01a112c..6e58f65455c7ca3eae2e88ed852c8655a6701e5c 100644
> > --- a/arch/loongarch/kernel/process.c
> > +++ b/arch/loongarch/kernel/process.c
> > @@ -293,13 +293,15 @@ unsigned long stack_top(void)
> >  {
> >         unsigned long top = TASK_SIZE & PAGE_MASK;
> >
> > -       /* Space for the VDSO & data page */
> > -       top -= PAGE_ALIGN(current->thread.vdso->size);
> > -       top -= VVAR_SIZE;
> > -
> > -       /* Space to randomize the VDSO base */
> > -       if (current->flags & PF_RANDOMIZE)
> > -               top -= VDSO_RANDOMIZE_SIZE;
> > +       if (current->thread.vdso) {
> > +               /* Space for the VDSO & data page */
> > +               top -= PAGE_ALIGN(current->thread.vdso->size);
> > +               top -= VVAR_SIZE;
> > +
> > +               /* Space to randomize the VDSO base */
> > +               if (current->flags & PF_RANDOMIZE)
> > +                       top -= VDSO_RANDOMIZE_SIZE;
> > +       }
> >
> >         return top;
> >  }
> >
> > --
> > 2.47.0
> >

