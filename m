Return-Path: <linux-kselftest+bounces-4025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C118475B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 18:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C012293674
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22214A4F4;
	Fri,  2 Feb 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="3zgv7TD/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A21420B3;
	Fri,  2 Feb 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893547; cv=none; b=mriKGij5w24zX+l2n5jjpDFp4H93Pq5OhX0GjFdQI5DbYRGHe4t35Egd31+pLE7++3TagzCHPBaAPSp3gNi6hZRH7t94qsVEbZwewe2lnJDC/Sux4hG3qcTHxTHfq/30VmTuhGKK7X0kpjjM5f9y6wIN+/2ZllrLH4JCaLzIfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893547; c=relaxed/simple;
	bh=BAwvHs1egQiGyh3Tep3tXQoRaot7EO9KKStazGkphj8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=uRzfieG6tTHAlX5GpfEM/1EsQ+a2fi7MLGxQbMElnxQVEZRJ9B1MujCN5+gkWzZ3s4xY3I8sKdjrus6UIoIJE/T6MZdkCVU1iidH9EPYYfox5OQgIlF7PkVQO+uUQTcYkiRrv+26IpAouJc+QsdRDVsR6PYmmSCogmb9qfEm33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=3zgv7TD/; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=BAwvHs1egQ
	iGyh3Tep3tXQoRaot7EO9KKStazGkphj8=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=3zgv7TD/ZhY+aUl0O7cUsE/W4VVRIWxeD
	MKVJaQwalupXyQ9cd/mhDSVOFEJmr7qpl+Dj4k1x8hh61Ao1qVQdaBTm2vFYSCo+nd0cdN
	jgIAK6z+F94bc6MtyRqcZN9tRbz6V5BzwE4RYcZapApJhS0SQeTS4tTXp9ZDsZkdd1Qwcz
	3K+WKRIiTh/kD/gPXvdQd5CyGmHAjZvja4JxoKYC1Zc7gMu6ztpnhCj1b+gZQ/86FWI2vR
	SKNXSYcY1E0uG8XGN3T8ayov7q1ihEb3QY9kh5GfwMsAP3mS1BQMy4G6bZLcUFNz5mCAM5
	3i29NM/koL7kJT9x3vSOva+ioeorg==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id e09d1d9f;
	Fri, 2 Feb 2024 10:05:43 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Jeff Xu <jeffxu@chromium.org>,
    "Liam R. Howlett" <Liam.Howlett@oracle.com>,
    Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com,
    jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
In-reply-to: <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver> <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com> <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com> <58408.1706828083@cvs.openbsd.org> <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
Comments: In-reply-to Linus Torvalds <torvalds@linux-foundation.org>
   message dated "Thu, 01 Feb 2024 15:15:27 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95708.1706893543.1@cvs.openbsd.org>
Date: Fri, 02 Feb 2024 10:05:43 -0700
Message-ID: <66496.1706893543@cvs.openbsd.org>

Another interaction to consider is sigaltstack().

In OpenBSD, sigaltstack() forces MAP_STACK onto the specified
(pre-allocated) region, because on kernel-entry we require the "sp"
register to point to a MAP_STACK region (this severely damages ROP pivot
methods).  Linux does not have MAP_STACK enforcement (yet), but one day
someone may try to do that work.

This interacted poorly with mimmutable() because some applications
allocate the memory being provided poorly.  I won't get into the details
unless pushed, because what we found makes me upset.  Over the years,
we've upstreamed diffs to applications to resolve all the nasty
allocation patterns.  I think the software ecosystem is now mostly
clean.

I suggest someone in Linux look into whether sigaltstack() is a mseal()
bypass, perhaps somewhat similar to madvise MADV_FREE, and consider the
correct strategy.

This is our documented strategy:

     On OpenBSD some additional restrictions prevent dangerous address space
     modifications.  The proposed space at ss_sp is verified to be
     contiguously mapped for read-write permissions (no execute) and incapable
     of syscall entry (see msyscall(2)).  If those conditions are met, a page-
     aligned inner region will be freshly mapped (all zero) with MAP_STACK
     (see mmap(2)), destroying the pre-existing data in the region.  Once the
     sigaltstack is disabled, the MAP_STACK attribute remains on the memory,
     so it is best to deallocate the memory via a method that results in
     munmap(2).

OK, I better provide the details of what people were doing.
sigaltstacks() in .data, in .bss, using malloc(), on a buffer on the
stack, we even found one creating a sigaltstack inside a buffer on a
pthread stack.  We told everyone to use mmap() and munmap(), with MAP_STACK
if #ifdef MAP_STACK finds a definition.

