Return-Path: <linux-kselftest+bounces-17160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B2296C586
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FCC1F243AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE0B1E1303;
	Wed,  4 Sep 2024 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo/495hH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1541E00B7;
	Wed,  4 Sep 2024 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471409; cv=none; b=hBy759VkU6XZRRaYikXrdBZYgR0xhwRzjc+HKlEz3ueh9OBBEVp2VzFX++JsEECcRUluUraLLsu1SM2eVeLBqvkD1CimLme7shhK9DNWlMdBqHXZrnwFpZGf9Ijzn5VPPVe5ss4oSCzpe+RJs2LnYcA+vjohVAqtqP9kPgNMSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471409; c=relaxed/simple;
	bh=kWds04I5pjMm3FhcXtiQkfRW8MvMdUPBrd8CIBFbZac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZW8uC1kd1aNRPjc9IAnBq5Lw5pmi4FcTb5Y82sGCG6E3Qyn/QJ+cxceiZW1DnfdpbmvaQLVIEZRdGCszwpzkh5nR7i12DfWOa58knFVu8fVxWPJi/gwpr4mG6pGVGBf9VMTR0IrwcgkFSv/dx1UqSn8nLYMMaheqGaylN893Nu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo/495hH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C323C4CEC2;
	Wed,  4 Sep 2024 17:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725471409;
	bh=kWds04I5pjMm3FhcXtiQkfRW8MvMdUPBrd8CIBFbZac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fo/495hHWvxt/g2JiEXBugpYAgkiyhgMt6vu9YtlthaxN7JCGZzMwkxO/oy1fD3+m
	 n8JH1BVmZaO3YILnBkhvOPrxqOooUrbv2LH2LKVyT9RjbhSlN+wXchrveI4XuruP5G
	 AdKBUjSuFy3t5JNTw9XjU2GU40WuwD90yOaFM9S9jvB+RVWGBWwQ9508kyQA37cDzf
	 I7NBiBnHLMvCwFqLwVwM7RXfdfrfwDLiZcUi3Mmmz6+2EYIcdxKWeCKZaQGQSTxgwg
	 DX6MBqVk0KgTG6qNFT4i6da45xWmsWme7Ia3bmWz9nwxm/2t370m5vlsm9TVSUrLVm
	 3dnipCkWGHiFw==
From: SeongJae Park <sj@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
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
Date: Wed,  4 Sep 2024 10:36:45 -0700
Message-Id: <20240904173645.1679-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <z7xkdvh6hfjxbt5nazkyxnpuztu6c425rucs2trmwqlfu7ywpq@5w3g7wpsyuji>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 3 Sep 2024 22:43:40 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> * Guenter Roeck <linux@roeck-us.net> [240903 21:54]:
> > On 9/3/24 18:18, SeongJae Park wrote:
> > > On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > 
> > > > On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > > > 
> > > > > * SeongJae Park <sj@kernel.org> [240903 20:45]:
> > > > > > damon_test_three_regions_in_vmas() initializes a maple tree with
> > > > > > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > > > > > mt_lock of the maple tree will not be used.  And therefore the maple
> > > > > > tree initialization code skips initialization of the mt_lock.  However,
> > > > > > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > > > > > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > > > > > problem becomes celar when spinlock debugging is turned on, since it
> > > > > > reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
> > > > > > as promised.
> > > > > 
> > > > > You can't do this, lockdep will tell you this is wrong.
> > > > 
> > > > Hmm, but lockdep was silence on my setup?
> > > > 
> > > > > We need a lock and to use the lock for writes.
> > > > 
> > > > This code is executed by a single-thread test code.  Do we still need the lock?
> > > > 
> > > > > 
> > > > > I'd suggest using different flags so the spinlock is used.
> > > > 
> > > > The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
> > > > causes suspicious RCU usage message.  May I ask if you have a suggestion of
> > > > better flags?
> > > 
> > > I was actually thinking replacing the mt_init_flags() with mt_init(), which
> > > same to mt_init_flags() with zero flag, like below.
> > > 
> > > ```
> > > --- a/mm/damon/tests/vaddr-kunit.h
> > > +++ b/mm/damon/tests/vaddr-kunit.h
> > > @@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
> > >                  (struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
> > >          };
> > > 
> > > -       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> > > +       mt_init(&mm.mm_mt);
> > >          if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
> > >                  kunit_skip(test, "Failed to create VMA tree");
> > > ```
> > > 
> > > And just confirmed it also convinces the reproducer.  But because I'm obviously
> > > not familiar with maple tree, would like to hear some comments from Liam or
> > > others first.
> 
> Again, I'd use the flags "MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU"
> because that gets you the gap tracking that may be necessary for tests
> in the future - it's closer to the MM_MT_FLAGS, so maybe some mm
> function you use depends on that.

Thank you for the nice suggestion with the rationales.  Just posted the v2
following it: https://lore.kernel.org/20240904172931.1284-1-sj@kernel.org

> 
> > > 
> > Same here. That is why I gave up after trying MT_FLAGS_ALLOC_RANGE and
> > "MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU". After all, I really don't know what
> > I am doing and was just playing around ... and there isn't really a good
> > explanation why initializing the maple tree with MT_FLAGS_ALLOC_RANGE (but not
> > MT_FLAGS_USE_RCU) would trigger rcu warnings.
> 
> Thanks, I'll add that to my list of things to do.

Thank you.  I agree that's somewhat we can visit separately.

FYI, I was also unable to reproduce rcu warnings with my v2 patch on my setup.
I will also try to use Guenter's more detailed repro
(https://lore.kernel.org/78880ac2-f7fe-4dc1-b2cb-25942fb0cacf@roeck-us.net).


Thanks,
SJ

> 
> Regards,
> Liam

