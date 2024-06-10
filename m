Return-Path: <linux-kselftest+bounces-11595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EAB90293D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63A91F21295
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E214D2AB;
	Mon, 10 Jun 2024 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDfvkV5c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709314A85;
	Mon, 10 Jun 2024 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047675; cv=none; b=ltFRtXqiNAGsunryJnEldNT7m+ryRycT5PobBNi7zRdsYzrK92qvHK09fGVCZK3LLaZAgxlBpXlI0y/9H2lgU0PIcJPYCcjVoTY/wX97u+jWTkqpY1f8EmjEL5RuRmkPtFILDfY+AJue5qQTSNUezpnie2HuBYMvDkmea3F6nRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047675; c=relaxed/simple;
	bh=QBgN9MHCavIxJhBcDljHXETz/zxwk+Ox8dykt2D+cqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTW1lzskvdYU+0XVtgdQsAjzOA2tRk9eZsngFc48FVqBZh8L7c96+lu10ci59uhMRmHHuov6OmOACIdyjPSWvu8X9MOduBdnJPgHR8jSPRaIJjxMfSP1aFSxWk+LEnKpxQKkC7XMGkCU5BSIyYrum+Jr8hKG7gaN3hlKmEJM0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDfvkV5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AE9C2BBFC;
	Mon, 10 Jun 2024 19:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718047674;
	bh=QBgN9MHCavIxJhBcDljHXETz/zxwk+Ox8dykt2D+cqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDfvkV5c5SnDUKilyooY0hegtuPeodzisyqHBP8aDjVVcZ00qz/umpRPJG53uEJM7
	 RvP9950rmnTzG+cQdlnhFaB1ZhvJ+l8lTFS1/F2iTmaR9wZAkyoCsD3kMioBOEWuPh
	 jw/bw5XWUzM/q46aw79wagIVQo7TCgjul/RVGVhh/MPeWPR8Bk1zzRGtzMnTIGoZS+
	 dRi25BZobTeMjbqAqMcozNeQvV/I8EiTPigMJ2nFXnJbOE4YWl2A1P8Jau19igojuf
	 efwYgck1Rco75IWDugNXbiq6HfrewN+zNdbspXtbxilqL2lhPcu6ZmtQQwIFT5ZN9l
	 v1fu1GSYm1AWg==
Date: Mon, 10 Jun 2024 12:27:54 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] kunit: test: Add vm_mmap() allocation resource
 manager
Message-ID: <202406101217.D14DF2F00@keescook>
References: <20240519190422.work.715-kees@kernel.org>
 <20240519191254.651865-1-keescook@chromium.org>
 <CABVgOSmD-v4rXDkcKgA1o2w-Ypzs_rYBKCx=2i2BWjWgd=o2pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmD-v4rXDkcKgA1o2w-Ypzs_rYBKCx=2i2BWjWgd=o2pg@mail.gmail.com>

On Sat, Jun 08, 2024 at 04:44:16PM +0800, David Gow wrote:
> On Mon, 20 May 2024 at 03:12, Kees Cook <keescook@chromium.org> wrote:
> >
> > For tests that need to allocate using vm_mmap() (e.g. usercopy and
> > execve), provide the interface to have the allocation tracked by KUnit
> > itself. This requires bringing up a placeholder userspace mm.
> >
> > This combines my earlier attempt at this with Mark Rutland's version[1].
> >
> > Link: https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/ [1]
> > Co-developed-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Thanks very much for this!
> 
> A few high-level thoughts:
> - Do we want to move this into a separate file? test.{c,h} is already
> getting pretty big, and this would probably fit more comfortably with
> some of the resource-management bits, which are in their own files.
> Not every test will need mm support.

I'm happy to do that -- I was just following where kunit_kmalloc() was
defined. I'll create a new file for it.

> - It'd be nice for there to be a way to explicitly teardown/reset
> this: I agree that this is made more awkward by KUnit cleanup normally
> running on a different thread, but I could definitely see why a test
> might want to unset/reset this, and it would be more consistent with
> other resources.

Yeah, it's weird, but it's naturally managed?

> Otherwise, I have a few small questions below, but nothing essential.
> There are a couple of test failures/hangs for the usercopy test (on
> i386 and m68k), which may have origins here: I've mentioned them
> there.

I'll look into this. I must have some 64/32 oversight...

> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

> > +/*
> > + * Arbitrarily chosen user address for the base allocation.
> > + */
> > +#define UBUF_ADDR_BASE SZ_2M
> 
> Are there any circumstances where we'd want a _different_ base address
> here? Could it conflict with something / could tests require something
> different?
> 
> I suspect it's fine to leave it like this until such a case actually shows up.

Yeah, it shouldn't be important, and as Mark has pointed out, it might
not be needed at all. I'll see what I can do.

> > +       vres = kunit_alloc_resource(test,
> > +                                   kunit_vm_mmap_init,
> > +                                   kunit_vm_mmap_free,
> > +                                   GFP_KERNEL,
> > +                                   &params);
> 
> It could be easier to use kunit_add_action() here, rather than
> kunit_alloc_resource(), as you wouldn't need the params struct to pass
> things through.
> 
> The advantage to keeping the separate resource is that we can more
> easily look it up later if we, for example, wanted to be able to make
> it current on other threads (is that something we'd ever want to do?).

I like having it follow the pattern of the other resource allocators,
but if there's not a strong reason to switch, I'll leave it as-is.

-- 
Kees Cook

