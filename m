Return-Path: <linux-kselftest+bounces-27372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D846A42B55
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 19:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3D71899C61
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2D266194;
	Mon, 24 Feb 2025 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ig0UXYrW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9F2661BD
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421587; cv=none; b=DovUSd0vyc//GcVRFQ0yNfOYV0WaVxwmv6NA8HNGjGeA/CisRzpN1IGwxXpU+O0KV5ZLbv2KGA/epW7akZUtbzNCtS0RHWpnm+W8N1B2vtDwTrp284sSpG/jxG0fIwexB9jQLnzbgMQe6R5YDQE/qWbCGajaHQhZ+6stXcw+u5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421587; c=relaxed/simple;
	bh=EefIC0GgbydMVFj1nflJtZbXEC98EhKuC4F/3YNrXEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CubqnhaRil9UkqpP63GN+GwsSsVLBxOLA/MCm0sXaBC/3mYsCnqIDW7+bjvMBuM1rsHXaUNjHQDaOXsy4NSGpQ4fQCg6FBpoL0FlaJ1wXvV370zqwL7o42r7IDwl08p8F7Og9Vn06XXmTF7Trg+ClW84WJBjL28pMSn0IFoXJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ig0UXYrW; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 18:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740421571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5J2l0tJZk9nYL86YBBSDH7LqcNOXciko+RDvn9pcvbI=;
	b=Ig0UXYrWUdVAfcJ16aiZ5biBRkXiRRPtmDKip/HoNVI8AHkxL9MMuwK9Cus9SkJUc01Gf1
	6Nmk2DSJC2yaCXYT+drfhGw0owjc7FNf8ky/+t8uESGlyhfpCQ5Xwp0fWUbqlG5yXGXKop
	t1GnSAurCiQpo2z2bMGzSQjkCxqmXSA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 4/4] mm/page_alloc_test: Add smoke-test for page
 allocation
Message-ID: <Z7y5vK1M5IOizIWR@google.com>
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
 <20250224-page-alloc-kunit-v1-4-d337bb440889@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-page-alloc-kunit-v1-4-d337bb440889@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 02:47:14PM +0000, Brendan Jackman wrote:
> This is the bare minimum to illustrate what KUnit code would look like
> that covers the page allocator.
> 
> Even this trivial test illustrates a couple of nice things that are
> possible when testing via KUnit
> 
> 1. We can directly assert that the correct zone was used.
>    (Although note due to the simplistic setup, you can have any zone you
>    like as long as it's ZONE_NORMAL).
> 
> 2. We can assert that a page got freed. It's probably pretty unlikely
>    that we'd have a bug that actually causes a page to get leaked by the
>    allocator, but it serves as a good example of the kind of assertions
>    we can make by judicously peeking at allocator internals.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/page_alloc_test.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 138 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc_test.c b/mm/page_alloc_test.c
> index c6bcfcaf61b57ca35ad1b5fc48fd07d0402843bc..0c4effb151f4cd31ec6a696615a9b6ae4964b332 100644
> --- a/mm/page_alloc_test.c
> +++ b/mm/page_alloc_test.c
> @@ -26,6 +26,139 @@
>  	}									\
>  })
>  
> +#define EXPECT_WITHIN_ZONE(test, page, zone) ({					\

ultranit: the '\' above is unaligned with the ones below.

> +	unsigned long pfn = page_to_pfn(page);					\
> +	unsigned long start_pfn = zone->zone_start_pfn;				\
> +	unsigned long end_pfn = start_pfn + zone->spanned_pages;		\
> +										\
> +	KUNIT_EXPECT_TRUE_MSG(test,						\
> +		pfn >= start_pfn && pfn < end_pfn,				\
> +		"Wanted PFN 0x%lx - 0x%lx, got 0x%lx",				\
> +		start_pfn, end_pfn, pfn);					\
> +	KUNIT_EXPECT_PTR_EQ_MSG(test, page_zone(page), zone,			\
> +		"Wanted %px (%s), got %px (%s)",				\
> +		zone, zone->name, page_zone(page), page_zone(page)->name);	\
> +})
> +
> +static void action_nodemask_free(void *ctx)
> +{
> +	NODEMASK_FREE(ctx);
> +}
> +
> +/*
> + * Call __alloc_pages_noprof with a nodemask containing only the nid.
> + *
> + * Never returns NULL.
> + */
> +static inline struct page *alloc_pages_force_nid(struct kunit *test,
> +						 gfp_t gfp, int order, int nid)
> +{
> +	NODEMASK_ALLOC(nodemask_t, nodemask, GFP_KERNEL);

For the sake of the test can't we just put the nodemask on the stack?

> +	struct page *page;
> +
> +	KUNIT_ASSERT_NOT_NULL(test, nodemask);
> +	kunit_add_action(test, action_nodemask_free, &nodemask);

Why aren't we just freeing the nodemask after using it, before we make
any assertions?

> +	nodes_clear(*nodemask);
> +	node_set(nid, *nodemask);
> +
> +	page = __alloc_pages_noprof(GFP_KERNEL, 0, nid, nodemask);
> +	KUNIT_ASSERT_NOT_NULL(test, page);
> +	return page;
> +}
> +
> +static inline bool page_on_buddy_list(struct page *want_page, struct list_head *head)
> +{
> +	struct page *found_page;

nit: This is just an iterator, we can probably just call it 'page'.
'found' is confusing for me because we didn't really search for it.

> +
> +	list_for_each_entry(found_page, head, buddy_list) {
> +		if (found_page == want_page)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/* Test case parameters that are independent of alloc order.  */
> +static const struct {
> +	gfp_t gfp_flags;
> +	enum zone_type want_zone;
> +} alloc_fresh_gfps[] = {
> +	/*
> +	 * The way we currently set up the isolated node, everything ends up in
> +	 * ZONE_NORMAL.
> +	 */
> +	{ .gfp_flags = GFP_KERNEL,	.want_zone = ZONE_NORMAL },
> +	{ .gfp_flags = GFP_ATOMIC,	.want_zone = ZONE_NORMAL },
> +	{ .gfp_flags = GFP_USER,	.want_zone = ZONE_NORMAL },
> +	{ .gfp_flags = GFP_DMA32,	.want_zone = ZONE_NORMAL },
> +};
> +
> +struct alloc_fresh_test_case {
> +	int order;
> +	int gfp_idx;
> +};
> +
> +/* Generate test cases as the cross product of orders and alloc_fresh_gfps.  */
> +static const void *alloc_fresh_gen_params(const void *prev, char *desc)
> +{
> +	/* Buffer to avoid allocations. */
> +	static struct alloc_fresh_test_case tc;
> +
> +	if (!prev) {
> +		/* First call */
> +		tc.order = 0;
> +		tc.gfp_idx = 0;
> +		return &tc;
> +	}

We need to set 'tc' here to whatever 'prev' is pointing at, right?

> +
> +	tc.gfp_idx++;
> +	if (tc.gfp_idx >= ARRAY_SIZE(alloc_fresh_gfps)) {
> +		tc.gfp_idx = 0;
> +		tc.order++;
> +	}
> +	if (tc.order > MAX_PAGE_ORDER)
> +		/* Finished. */
> +		return NULL;
> +
> +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "order %d %pGg\n",
> +		tc.order, &alloc_fresh_gfps[tc.gfp_idx].gfp_flags);
> +	return &tc;
> +}
> +
> +/* Smoke test: allocate from a node where everything is in a pristine state. */
> +static void test_alloc_fresh(struct kunit *test)
> +{
> +	const struct alloc_fresh_test_case *tc = test->param_value;
> +	gfp_t gfp_flags = alloc_fresh_gfps[tc->gfp_idx].gfp_flags;
> +	enum zone_type want_zone_type = alloc_fresh_gfps[tc->gfp_idx].want_zone;
> +	struct zone *want_zone = &NODE_DATA(isolated_node)->node_zones[want_zone_type];
> +	struct list_head *buddy_list;
> +	struct per_cpu_pages *pcp;
> +	struct page *page, *merged_page;
> +	int cpu;
> +
> +	page = alloc_pages_force_nid(test, gfp_flags, tc->order, isolated_node);
> +
> +	EXPECT_WITHIN_ZONE(test, page, want_zone);
> +
> +	cpu = get_cpu();
> +	__free_pages(page, 0);
> +	pcp = per_cpu_ptr(want_zone->per_cpu_pageset, cpu);
> +	put_cpu();
> +
> +	/*
> +	 * Should end up back in the free area when drained. Because everything
> +	 * is free, it should get buddy-merged up to the maximum order.
> +	 */
> +	drain_zone_pages(want_zone, pcp);
> +	KUNIT_EXPECT_TRUE(test, PageBuddy(page));
> +	KUNIT_EXPECT_EQ(test, buddy_order(page), MAX_PAGE_ORDER);
> +	KUNIT_EXPECT_TRUE(test, list_empty(&pcp->lists[MIGRATE_UNMOVABLE]));
> +	merged_page = pfn_to_page(round_down(page_to_pfn(page), 1 << MAX_PAGE_ORDER));
> +	buddy_list = &want_zone->free_area[MAX_PAGE_ORDER].free_list[MIGRATE_UNMOVABLE];
> +	KUNIT_EXPECT_TRUE(test, page_on_buddy_list(merged_page, buddy_list));
> +}
> +
>  static void action_drain_pages_all(void *unused)
>  {
>  	int cpu;
> @@ -144,7 +277,11 @@ static void depopulate_isolated_node(struct kunit_suite *suite)
>  	WARN_ON(add_memory(0, start, size, MMOP_ONLINE));
>  	WARN_ON(walk_memory_blocks(start, size, NULL, memory_block_online_cb));
>  }
> -static struct kunit_case test_cases[] = { {} };
> +
> +static struct kunit_case test_cases[] = {
> +	KUNIT_CASE_PARAM(test_alloc_fresh, alloc_fresh_gen_params),
> +	{}
> +};
>  
>  struct kunit_suite page_alloc_test_suite = {
>  	.name = "page_alloc",
> 
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 

