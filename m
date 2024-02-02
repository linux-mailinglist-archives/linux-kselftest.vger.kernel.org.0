Return-Path: <linux-kselftest+bounces-3984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B628466BE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 05:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1093028DEE8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D9D27F;
	Fri,  2 Feb 2024 04:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="rRkd3Y9t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB6E55E;
	Fri,  2 Feb 2024 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846712; cv=none; b=A7eE2M3aQz977k4dYrkxGKxrTPSoznpyN3top40U25ya9MB8ixYs2epy+QQ4agVM4YomR9XFWllJ9SULufBUgM3XNeQY1zKq5KbXGdLvU4nutpq1eEnALrvmohLYbZBR6ieMpywJ8jPYQ/BJTB29bSIsVg8PF/roKeDL8JjYceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846712; c=relaxed/simple;
	bh=NNLcYCuc4BF/659D3HxJb+VQHj1+QX8RRAYRfMCjV08=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Sxx8xBxLAcOvLwnx85/nNcXtYfJWwQwNQGUPQyMA5QedmJGYMvEfevVNxodLs0Nj3woRoIk6M1IckDSzMmfK5SNgD+P+Xmmt+s4bBXhJlhRNRj4L9WCZDiWPgwsJt1Fp7AVbbCyLynn6bXGY69qTG1UH11uDrU+JaMw1seMdTD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=rRkd3Y9t; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=NNLcYCuc4B
	F/659D3HxJb+VQHj1+QX8RRAYRfMCjV08=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=rRkd3Y9tCaT99HAOzulVgYIo663rTR0TJ
	HOrCKvy1wvCo9kQ+VIuoYTuLARxRSwx0FNcS834C5NKE6XhczFPzhxJWbYtiCCCK4o44xQ
	WYENp4Ro9L5NOlkFoBwFe/MNm6LMRxaQuf9ds27DuUGE6knsEcFGCgb/ZbA60s6scfYD5u
	b9YJpdlnmv3LxZGFuio1O8F9hp+cqkUZhslMryt1sfmvGhC2OJEd2vwpiZJAycQexyJcvo
	yw4t24gxBgj2ZJDaZ6Q1JsNnReiVPFff1skgGdcz105x8f3SyERpwV7kjrBqb+velzGYDI
	tdBDE/yrWOidAHQk5Kqz3YmL3UFAQ==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 92cf0eba;
	Thu, 1 Feb 2024 21:05:10 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@google.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
    Jeff Xu <jeffxu@chromium.org>,
    "Liam R. Howlett" <Liam.Howlett@oracle.com>,
    Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    usama.anjum@collabora.com, rdunlap@infradead.org,
    jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
In-reply-to: <CALmYWFtqcixi3p3Ab44wENJr+n2k2SNaCJEofNm_awnNdJZnDQ@mail.gmail.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver> <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com> <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com> <58408.1706828083@cvs.openbsd.org> <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com> <CALmYWFtqcixi3p3Ab44wENJr+n2k2SNaCJEofNm_awnNdJZnDQ@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@google.com>
   message dated "Thu, 01 Feb 2024 19:20:08 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64877.1706846710.1@cvs.openbsd.org>
Date: Thu, 01 Feb 2024 21:05:10 -0700
Message-ID: <8744.1706846710@cvs.openbsd.org>

Jeff Xu <jeffxu@google.com> wrote:

> To me, the most important thing is to deliver a feature that's easy to
> use and works well. I don't want users to mess things up, so if I'm
> the one giving them the tools, I'm going to make sure they have all
> the information they need and that there are safeguards in place.
> 
> e.g. considering the following user case:
> 1> a security sensitive data is allocated from heap, using malloc,
> from the software component A, and filled with information.
> 2> software component B then uses mprotect to change it to RO, and
> seal it using mseal().

  p = malloc(80);
  mprotect(p & ~4095, 4096, PROT_NONE);
  free(p);

Will you save such a developer also?  No.

Since the same problem you describe already exists with mprotect() what
does mseal() even have to do with your proposal?

What about this?

  p = malloc(80);
  munmap(p & ~4095, 4096);
  free(p);

And since it is not sealed, how about madvise operations on a proper
non-malloc memory allocation?  Well, the process smashes it's own
memory.  And why is it not sealed?  You make it harder to seal memory!

How about this?

  p = malloc(80);
  bzero(p, 100000;

Yes it is a buffer overflow.  But this is all the same class of software
problem:

Memory belongs to processes, which belongs to the program, which is coded
by the programmer, who has to learn to be careful and handle the memory correctly.

mseal() / mimmutable() add *no new expectation* to a careful programmer,
because they expected to only use it on memory that they *promise will never
be de-allocated or re-permissioned*.

What you are proposing is not a "mitigation", it entirely cripples the
proposed subsystem because you are afraid of it; because you have cloned a
memory subsystem primitive you don't fully understand; and this is because
you've not seen a complete operating system using it.

When was the last time you developed outside of Chrome?

This is systems programming.  The kernel supports all the programs, not
just the one holy program from god.

