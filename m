Return-Path: <linux-kselftest+bounces-17085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F0896AD89
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DE02816F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F62A59;
	Wed,  4 Sep 2024 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8GyIKo4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C139B;
	Wed,  4 Sep 2024 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411500; cv=none; b=fdy4mXs2g91AcKTVROHHUsQ/g7kEpITxpw1D31YlVxGpvBAcf1CI053707me/t0+BYmp+V8mbk12cU4G3vrnWPWwfKS8eAWpa7wAAm71hvfOqjpnig3QESbhCUmEa9KuOerhq53eR0liG9knwPQNYa1hRIdd7mBi8hmvamve7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411500; c=relaxed/simple;
	bh=3J3/SerQsfmG/eTI3HlBph0qoHr1r/J3cfwrtxFgXWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHUQ5XZnI/wuXX1CefdPPKbQb+dzBUWM17IPXIMrPSDLE9I8P4CNetKPdKcpkQ8EMuIM0mkzk+kFhkU3wnamUy+T6OZz13sZf3BacifN+z0PCH01lWeDr2mXShLvR8DDQoWS6LaPG4P6zq22sRqyZOEP/PPITcmQr1/T5EAJSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8GyIKo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0EDC4CEC4;
	Wed,  4 Sep 2024 00:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725411499;
	bh=3J3/SerQsfmG/eTI3HlBph0qoHr1r/J3cfwrtxFgXWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8GyIKo4aQJdavA9FhD8d1dzHGRCMwme5AoKpMI54gNvEXsQZe36J0/srwXGYXGwj
	 XLC3mwkTZidspM/ZZoHQJvzsvJDRiURXB9PsH7Dhj52o43VkIT/G9FLRXE5/kyxKbW
	 lwwpC0eISGSUnNuF8fu+5wXo8W03Z8eyTBPBwJNZdxLgpxLe1Bj3Xzb2VyzlLFCG/d
	 iMi9Q1F5e6CNSV3bprlK40Jki8xgj31V+B0kNe9rNsyIAR/GqANMlVeDQT7Lb2FIiv
	 NW7sz4WLC1Q0Kgbtln9TtgwrXktuZn1vfRj7FfiLL861+QY/pnz7u/yH628cAbbIzS
	 PUIXdjWuo5iQQ==
From: SeongJae Park <sj@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
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
Date: Tue,  3 Sep 2024 17:58:15 -0700
Message-Id: <20240904005815.1388-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <jy6263g6em4jsdhp6tknmh2cljpuvq652kvcet4ko3z2xt7pym@ltc5h5twsszu>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> * SeongJae Park <sj@kernel.org> [240903 20:45]:
> > damon_test_three_regions_in_vmas() initializes a maple tree with
> > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > mt_lock of the maple tree will not be used.  And therefore the maple
> > tree initialization code skips initialization of the mt_lock.  However,
> > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > problem becomes celar when spinlock debugging is turned on, since it
> > reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
> > as promised.
> 
> You can't do this, lockdep will tell you this is wrong.

Hmm, but lockdep was silence on my setup?

> We need a lock and to use the lock for writes.

This code is executed by a single-thread test code.  Do we still need the lock?

> 
> I'd suggest using different flags so the spinlock is used.

The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
causes suspicious RCU usage message.  May I ask if you have a suggestion of
better flags?


Thanks,
SJ

> 
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
> > Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/tests/vaddr-kunit.h | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> > index 83626483f82b..c6c7e0e0ab07 100644
> > --- a/mm/damon/tests/vaddr-kunit.h
> > +++ b/mm/damon/tests/vaddr-kunit.h
> > @@ -17,23 +17,19 @@
> >  static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> >  			ssize_t nr_vmas)
> >  {
> > -	int i, ret = -ENOMEM;
> > +	int i;
> >  	MA_STATE(mas, mt, 0, 0);
> >  
> >  	if (!nr_vmas)
> >  		return 0;
> >  
> > -	mas_lock(&mas);
> >  	for (i = 0; i < nr_vmas; i++) {
> >  		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> >  		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> > -			goto failed;
> > +			return -ENOMEM;
> >  	}
> >  
> > -	ret = 0;
> > -failed:
> > -	mas_unlock(&mas);
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  /*
> > -- 
> > 2.39.2
> >

