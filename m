Return-Path: <linux-kselftest+bounces-17086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1991E96ADBA
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 03:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8BAB24244
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 01:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4823BE49;
	Wed,  4 Sep 2024 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6vaW8G9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B094BA50;
	Wed,  4 Sep 2024 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412724; cv=none; b=XWFzx+1nDZNwmsqmwWEfAjJHvym8/HyKbv+eYJtjueFI/j8PZON6avNcvtdr+wlpoQY7HwLK6gEIX5RSPGqy8+bS5TaxLinziobKyDXL8jHDg09RMc5ohDXvOxLdrk73LoI3UvRkgI2dcsXqMu/PqX8DYFPBQX4Vl11kpYB79W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412724; c=relaxed/simple;
	bh=y/3yN1UyvYk8Wq999clT14OsLdRzhWfqeZkW6GvxlHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XH+QWqH58r02FZJZkhtqARNM1wGYs5i88VtZfSEvX5SIsrqWhOAniS8V+22eCCmX8lo33krEILxNte4lkE8cdzaCZW+7vLqmsNC8gOyVyXjg/Cz6wBmQQtIRdUUU4A98juEA1J9ic9jeYCJ+Krkts93mrL6QyaeJ+ZEbLemkb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6vaW8G9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F76C4CEC4;
	Wed,  4 Sep 2024 01:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725412724;
	bh=y/3yN1UyvYk8Wq999clT14OsLdRzhWfqeZkW6GvxlHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6vaW8G9clbLDlTrj5RrieA6o0MP9RhjYpO5XdSMVRsEzfTWOTQCmNXcFNt29K/IE
	 Ii6ZGn7bfMcRf9/BxwyraAucHwdFQ6+7gAQoraG9nsZ6hYFSgoQZaFsRCknIYjQQ3t
	 nBvL7hYmdoj2l2F/sOXP89SfG8UwffnmELIKoFrW2Jyt/TMEIj6cPP2xdQJ0dvs5y9
	 1ljtUwltwh4os+Om2vmyvBo05lsV9t6Cl0lO9NOYBns/dXhyzy7LQTR6dvnqAg7Ys8
	 cg6xSdBi5FKzEDciSnQDxuvFj+IllEa9oFoFHzDAcr6R3v7CJsDHuZKHuq/IFP6OqZ
	 B+7265UR+Cssg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for MM_MT_FLAGS-initialized maple tree
Date: Tue,  3 Sep 2024 18:18:40 -0700
Message-Id: <20240904011840.973-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240904005815.1388-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > * SeongJae Park <sj@kernel.org> [240903 20:45]:
> > > damon_test_three_regions_in_vmas() initializes a maple tree with
> > > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > > mt_lock of the maple tree will not be used.  And therefore the maple
> > > tree initialization code skips initialization of the mt_lock.  However,
> > > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > > problem becomes celar when spinlock debugging is turned on, since it
> > > reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
> > > as promised.
> > 
> > You can't do this, lockdep will tell you this is wrong.
> 
> Hmm, but lockdep was silence on my setup?
> 
> > We need a lock and to use the lock for writes.
> 
> This code is executed by a single-thread test code.  Do we still need the lock?
> 
> > 
> > I'd suggest using different flags so the spinlock is used.
> 
> The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
> causes suspicious RCU usage message.  May I ask if you have a suggestion of
> better flags?

I was actually thinking replacing the mt_init_flags() with mt_init(), which
same to mt_init_flags() with zero flag, like below.

```
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
                (struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
        };

-       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
+       mt_init(&mm.mm_mt);
        if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
                kunit_skip(test, "Failed to create VMA tree");
```

And just confirmed it also convinces the reproducer.  But because I'm obviously
not familiar with maple tree, would like to hear some comments from Liam or
others first.

FYI, I ended up writing v1 to simply remove lock usage based on my humble
understanding of the documetnation.

    The maple tree uses a spinlock by default, but external locks can be used for
    tree updates as well.  To use an external lock, the tree must be initialized
    with the ``MT_FLAGS_LOCK_EXTERN flag``, this is usually done with the
    MTREE_INIT_EXT() #define, which takes an external lock as an argument.

(from Documentation/core-api/maple_tree.rst)

I was thinking the fact that the test code is executed in single thread is same
to use of external lock.  I will be happy to learn if I missed something.


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
> > 
> > > 
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
> > > Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > >  mm/damon/tests/vaddr-kunit.h | 10 +++-------
> > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> > > index 83626483f82b..c6c7e0e0ab07 100644
> > > --- a/mm/damon/tests/vaddr-kunit.h
> > > +++ b/mm/damon/tests/vaddr-kunit.h
> > > @@ -17,23 +17,19 @@
> > >  static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> > >  			ssize_t nr_vmas)
> > >  {
> > > -	int i, ret = -ENOMEM;
> > > +	int i;
> > >  	MA_STATE(mas, mt, 0, 0);
> > >  
> > >  	if (!nr_vmas)
> > >  		return 0;
> > >  
> > > -	mas_lock(&mas);
> > >  	for (i = 0; i < nr_vmas; i++) {
> > >  		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> > >  		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> > > -			goto failed;
> > > +			return -ENOMEM;
> > >  	}
> > >  
> > > -	ret = 0;
> > > -failed:
> > > -	mas_unlock(&mas);
> > > -	return ret;
> > > +	return 0;
> > >  }
> > >  
> > >  /*
> > > -- 
> > > 2.39.2
> > >

