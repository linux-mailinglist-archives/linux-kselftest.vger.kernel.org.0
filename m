Return-Path: <linux-kselftest+bounces-17189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6553096CBB3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 02:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8501B22956
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 00:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB77FD;
	Thu,  5 Sep 2024 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR0zHqsY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36143C2C8;
	Thu,  5 Sep 2024 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495594; cv=none; b=dH70+vpR8trlXXesDG1EcV7qiXT2fwCxjZVS2WHtg3U0bgcrhyzI6awRvNTJ3WNiekKSw7CJ4N6RwVEujO0jnSE70Yt3zFLW12AQme0tr+femFPhnV28T7q3oXfTTo6zISdhFAuxr38aVTlkzcyoMju0/Bvd3Hbal0c4moFN1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495594; c=relaxed/simple;
	bh=Wa8DpztL76ccEY5Yc633xmiKRM0F+ZVOwn8AO4/rqyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlF6kFwY7Y5/7+9BHhQqRTEJas7s4/LO+lw7IkIQj1Pv3/bObujBD+xTaXhahRhvZh3tBVe8f0rNncTofrMp5/e4UbOnkas9xDHborBEFF1vsWmYbVY+dz1yWxwZoaNyNffxO4A70B2dIsNjB243xoU5gNQH+/fAIfn9AzlgBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR0zHqsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2EBC4CEC2;
	Thu,  5 Sep 2024 00:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725495594;
	bh=Wa8DpztL76ccEY5Yc633xmiKRM0F+ZVOwn8AO4/rqyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GR0zHqsYxxHVjKOw1GPcI1n3SsJ2OllLHEGW8LZGsVTlEk6cJjNl+u0x2hVGED4JG
	 rwng7fH64ES7Do2ryOEmFzgQAKUbDbHZze6Trx4BWpzRNd52O1RHxPsW7WV5iYbJxI
	 tpW1Hcm3ryfgZ4JRpnY1svUKOtXuBVXMdIGnhKcNzLfxpBzDRZ+sFW1JVSxpkv/doN
	 ruti7xCmaOmy7DTY7mt8xDZSVIsWZPCvUipLEbWWBkg5PoJX9mzueTaBSFrfQR1NOB
	 ougbpBDVZ0rUxIjGTixD4nJmvsQzWlCPg+jsvJGerdYFftGk7SMrxyj3mJpQgsofpt
	 HThTJtmWDLWcw==
From: SeongJae Park <sj@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for MM_MT_FLAGS-initialized maple tree
Date: Wed,  4 Sep 2024 17:19:50 -0700
Message-Id: <20240905001950.1962-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <274f253a-e44e-431b-9dd3-a499843be96f@roeck-us.net>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 Sep 2024 12:56:33 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/4/24 12:26, Liam R. Howlett wrote:
> > * Guenter Roeck <linux@roeck-us.net> [240904 00:27]:
> >> On 9/3/24 20:36, Liam R. Howlett wrote:
> >>> * Guenter Roeck <linux@roeck-us.net> [240903 22:38]:
> >>>> On 9/3/24 19:31, Liam R. Howlett wrote:
> >>>>> * SeongJae Park <sj@kernel.org> [240903 21:18]:
> >>>>>> On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> >>>>>>
> >>>>>>> On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> >>>>>>>
> >>>>>>>> * SeongJae Park <sj@kernel.org> [240903 20:45]:
[...]
> >>> I am running ./tools/testing/kunit/kunit.py run '*damon*' --arch x86_64 --raw
> >>> with:
> >>> CONFIG_LOCKDEP=y
> >>> CONFIG_DEBUG_SPINLOCK=y
> >>>
> >>> and I don't have any issue with locking in the existing code.  How do I
> >>> recreate this issue?
> >>>
> >>
> >> I tested again, and I still see
> >>
> >>
> >> [    6.233483] ok 4 damon
> >> [    6.234190]     KTAP version 1
> >> [    6.234263]     # Subtest: damon-operations
> >> [    6.234335]     # module: vaddr
> >> [    6.234384]     1..6
> >> [    6.235726]
> >> [    6.235931] =============================
> >> [    6.236018] WARNING: suspicious RCU usage
> >> [    6.236280] 6.11.0-rc6-00029-gda66250b210f-dirty #1 Tainted: G                 N
> >> [    6.236398] -----------------------------
> >> [    6.236474] lib/maple_tree.c:832 suspicious rcu_dereference_check() usage!
> >> [    6.236579]
> >> [    6.236579] other info that might help us debug this:
> >> [    6.236579]
> >> [    6.236738]
> >> [    6.236738] rcu_scheduler_active = 2, debug_locks = 1
> >> [    6.237039] no locks held by kunit_try_catch/208.
> >> [    6.237166]
> >> [    6.237166] stack backtrace:
> >> [    6.237385] CPU: 0 UID: 0 PID: 208 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00029-gda66250b210f-dirty #1
> >> [    6.237629] Tainted: [N]=TEST
> >> [    6.237714] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >> [    6.238065] Call Trace:
> >> [    6.238233]  <TASK>
> >> [    6.238547]  dump_stack_lvl+0x9e/0xe0
> >> [    6.239473]  lockdep_rcu_suspicious+0x145/0x1b0
> >> [    6.239621]  mas_walk+0x19f/0x1d0
> >> [    6.239765]  mas_find+0xb5/0x150
> >> [    6.239873]  __damon_va_three_regions+0x7e/0x130

I was able to reproduce this by further enabling PROVE_LOCKING.

> > 
> > This function isn't taking the rcu read lock while iterating the tree.
> > 
> > Try this:
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index b0e8b361891d..08cfd22b5249 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -126,6 +126,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
> >           * If this is too slow, it can be optimised to examine the maple
> >           * tree gaps.
> >           */
> > +       rcu_read_lock();
> >          for_each_vma(vmi, vma) {
> >                  unsigned long gap;
> >   
> > @@ -146,6 +147,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
> >   next:
> >                  prev = vma;
> >          }
> > +       rcu_read_unlock();
> >   
> >          if (!sz_range(&second_gap) || !sz_range(&first_gap))
> >                  return -EINVAL;
> > 
> 
> 
> Yes, that fixes the problem for me.

Thank you for the fix, Liam.  Thank you for the test, Guenter.  I also
confirmed this fix works on my setup.

I posted the fix as a formal patch:
https://lore.kernel.org/20240905001204.1481-1-sj@kernel.org


Thanks,
SJ

> 
> Thanks,
> Guenter

