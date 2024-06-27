Return-Path: <linux-kselftest+bounces-12872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C5191AD66
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7D41F268E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C80619A282;
	Thu, 27 Jun 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8ppLUtD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF09199EB2;
	Thu, 27 Jun 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508043; cv=none; b=RE4trZWUkQKUkRCuewBXbo8E5Mlt1jqijW5/hYY5bIGg0G8Nvhe9G3oIsDcqQEvesSuC8pbi86zGptpSo7mStrq0lo0CXZu4QtgeaAxKIH98LcsaS0qnsOPhy2JgKuCEwvYYg3w+aZa+vmrLQMPSzBSHWHFuGehG3QRfEwOn6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508043; c=relaxed/simple;
	bh=dCecJH51CViqti7qWLv13tYkYfTd/WBIfPitvC5HPdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8Nln0Z4LNNqhR2RhlWgOfHC7bpHyRIRgj16uQraDUDtNcqZadm8MWgp6FxFLWQURPEpLA5M1NzWpdvC2rJZs0nrcNvElK1O6svIaxYB3NinXn6L9UyrYvnxe/iw6YzaYdo7/UBR5HS9lsqKCN+XreORpSdsTzyWBhtZZk6BBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8ppLUtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6822C2BD10;
	Thu, 27 Jun 2024 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508042;
	bh=dCecJH51CViqti7qWLv13tYkYfTd/WBIfPitvC5HPdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8ppLUtDZSj40GoxCJkBdtnipmTOwT7siZJmIBCDzKP6WEeYPpYN+KQAeBHBZMZnV
	 xHigF/m20LEu2obCWRbRKgLfI0WMFHW6UiFs1rTqK0EApwkJiLx0hyxKaOFwJCSevk
	 mOxmr0nCMEUbkOCW90BDdUFpUWqa6nuwcW3lIo4JtwZmiCF7511gnHOVCeX1dsMg0A
	 ay8JjnIvgjtKyn4QrkgLRqi2TKn8BZLljfDLZeUJuuZNJgDJmVPYX4fy7sb0f7TE1l
	 nsRROyftHTyOJc0Gilaq2rbz5jXeh7knp42xLlYyoCr9NkF2CPj1Aad8ixc03adTNY
	 Pt0RxZ7375R8A==
Date: Thu, 27 Jun 2024 10:07:22 -0700
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Rae Moar <rmoar@google.com>, kernel test robot <lkp@intel.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kunit/usercopy: Disable testing on !CONFIG_MMU
Message-ID: <202406271005.4E767DAE@keescook>
References: <20240619202511.it.861-kees@kernel.org>
 <CA+GJov5ZpFxKxK44SAb_B8SzWUF9uQV13A8BcVPijo0CV0mStg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+GJov5ZpFxKxK44SAb_B8SzWUF9uQV13A8BcVPijo0CV0mStg@mail.gmail.com>

Hi Shuah,

Can you please add this to your -next tree since it fixes test failures
on non-MMU systems, after commit cf6219ee889f ("usercopy: Convert
test_user_copy to KUnit test").

Thanks!

-Kees

On Thu, Jun 20, 2024 at 05:13:35PM -0400, Rae Moar wrote:
> On Wed, Jun 19, 2024 at 4:25 PM Kees Cook <kees@kernel.org> wrote:
> >
> > Since arch_pick_mmap_layout() is an inline for non-MMU systems, disable
> > this test there.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406160505.uBge6TMY-lkp@intel.com/
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Hello!
> 
> This looks good to me. And seems to fix the problem. Thanks for the fix!
> 
> Reviewed-by: Rae Moar <rmoar@google.com>
> 
> -Rae
> 
> > ---
> > Resending as v2 with Shuah in To:
> > ---
> > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Cc: linux-hardening@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > ---
> >  lib/kunit/user_alloc.c | 4 ++++
> >  lib/usercopy_kunit.c   | 5 +++++
> >  mm/util.c              | 2 ++
> >  3 files changed, 11 insertions(+)
> >
> > diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> > index 76d3d1345ed7..ae935df09a5e 100644
> > --- a/lib/kunit/user_alloc.c
> > +++ b/lib/kunit/user_alloc.c
> > @@ -30,6 +30,10 @@ static int kunit_attach_mm(void)
> >         if (current->mm)
> >                 return 0;
> >
> > +       /* arch_pick_mmap_layout() is only sane with MMU systems. */
> > +       if (!IS_ENABLED(CONFIG_MMU))
> > +               return -EINVAL;
> > +
> >         mm = mm_alloc();
> >         if (!mm)
> >                 return -ENOMEM;
> > diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
> > index 45f1e558c464..e819561a540d 100644
> > --- a/lib/usercopy_kunit.c
> > +++ b/lib/usercopy_kunit.c
> > @@ -290,6 +290,11 @@ static int usercopy_test_init(struct kunit *test)
> >         struct usercopy_test_priv *priv;
> >         unsigned long user_addr;
> >
> > +       if (!IS_ENABLED(CONFIG_MMU)) {
> > +               kunit_skip(test, "Userspace allocation testing not available on non-MMU systems");
> > +               return 0;
> > +       }
> > +
> >         priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> >         test->priv = priv;
> > diff --git a/mm/util.c b/mm/util.c
> > index df37c47d9374..e70e8e439258 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -484,7 +484,9 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> >         clear_bit(MMF_TOPDOWN, &mm->flags);
> >  }
> >  #endif
> > +#ifdef CONFIG_MMU
> >  EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
> > +#endif
> >
> >  /**
> >   * __account_locked_vm - account locked pages to an mm's locked_vm
> > --
> > 2.34.1
> >

-- 
Kees Cook

