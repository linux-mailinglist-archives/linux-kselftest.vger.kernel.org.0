Return-Path: <linux-kselftest+bounces-27354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4925EA4249B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 15:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9392117B959
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4062580C9;
	Mon, 24 Feb 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPgm+K37"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAC254867
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408458; cv=none; b=OV2+758AzbELVPVObvofa07pl82APqN0CurK8x6soUXUztppx3/1wRGOEkdqLBgm4K/CiGVSnj7wqCb3jYHEkwA6zj2gGjBOPSs4GkjFzc9W+L2H36usxNTtyk8oLcF1qOlrZkSHhVffZd9XfK5GY9MBaCra1iK7Li0/8iJwZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408458; c=relaxed/simple;
	bh=/rC3zjRkXgsFNzgn2Bsk3EVpsKL8TMjcDS8os7nggNM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J6cRH8kOhhtSJoSUfuWmucAGHtrZ6mQo2JfykGqFpCyT2fTDRNxzo/p3X+1Hgg4j7c4dDNbPqi/X+MO8At6oTCl/40fn8Pf8HRM6GM4v7YwE5PSe/arzSQRpKjMzXra3+dQV6Pm552qdWdysMMe8FOcemDDE26q0QvhcYIPVxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPgm+K37; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438da39bb69so34037705e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 06:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740408455; x=1741013255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fz5NU1PueoQjecq9oG9iR+vgvt/Z95TUw+fwY0nW88=;
        b=gPgm+K37fqYvaDkfm7GVEUrYczTQ/Bsmn4SHyGO4f7z5BbjjYblXV9Wn/Moe0H9VC5
         l2KhQK88qE0EC9LJn6F2XGZ+I7ocLEMWRa3WJmug/LQ+h+6lgj7RHW6lp+naY1gpOuGv
         O7lCCWaKjW9k5a6EoMJnkJ5W/AuAye5aB8+L9+H+j/AobvSnVcG93QrutQY4y95eNzsy
         pjsbc5mXfLQnpOtegU42G4CSDi136WoReehZRE8jmFZ7FZmQOgIz1h+y8NjJLeCwGNeU
         r2bP/SpcMMxP4XNsbHOqa+zXSra8NzgcgU34mxCjS+Ojg6yb+o16Hlcfev7RzFtYNmtY
         GcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740408455; x=1741013255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fz5NU1PueoQjecq9oG9iR+vgvt/Z95TUw+fwY0nW88=;
        b=fO44RYgved7+apoUU9IHqveEnB1rx7Atb5+3Ke65UD3YQTnisq456OpJ++fYMIy78I
         aY1hzmdI+zeTcV7kSl+vLlOtkOqP6VWY+2A6UiAO5RlmXOnH3WO/OhHu9M2YnnGXvP0h
         yI44oVDygVAVCMdtZ2pqCXOfS775f4XodHGF+sqv/a6Vu3x0qfQgnb7MOy/yec5kZ79t
         KfqIH+4220Sr7Hk0Pu1uN6ZiqM5zqnlnyHZXGsgDpfVNzpI8krLStz8LsETHjK+FMKrH
         qqkzsdtGOWOyuBOKKTecqiABxTER/+wqoXsEFwfD3HQnz0YPgfxaqKRU6GL7daAljdiK
         ZYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+uS/bBea2HIMABjPZ5JsPHPpObYUasOEYt7e2PcR6izB0soOHD3ok9JTtDB6aAyarosPINiLp8RAsfvgfwBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygmat9EmndmQpOz2arxPWjrui9fi7/ysAzDHcawxeI9ZS0BG1F
	3JFjUnHBxz0Mj49C84v3gsSHZjGwzUwNV7NOa7xYD/SjAp2DaNxiDJuup+TVJGVlT07nxwyxJ+e
	4uwzsgniXTA==
X-Google-Smtp-Source: AGHT+IEAGhOq6ZLG1kWNmTBHOtlzeySJw4C81f6PzEKZO3mD1LQVv/+voZGC5+kCMIWufaPww+gOqaaEPDa8Ww==
X-Received: from wmqe19.prod.google.com ([2002:a05:600c:4e53:b0:439:831e:ca7c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468f:b0:439:5541:53cc with SMTP id 5b1f17b1804b1-439ae2206d5mr101272755e9.29.1740408455220;
 Mon, 24 Feb 2025 06:47:35 -0800 (PST)
Date: Mon, 24 Feb 2025 14:47:14 +0000
In-Reply-To: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250224-page-alloc-kunit-v1-4-d337bb440889@google.com>
Subject: [PATCH RFC 4/4] mm/page_alloc_test: Add smoke-test for page allocation
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Brendan Jackman <jackmanb@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

This is the bare minimum to illustrate what KUnit code would look like
that covers the page allocator.

Even this trivial test illustrates a couple of nice things that are
possible when testing via KUnit

1. We can directly assert that the correct zone was used.
   (Although note due to the simplistic setup, you can have any zone you
   like as long as it's ZONE_NORMAL).

2. We can assert that a page got freed. It's probably pretty unlikely
   that we'd have a bug that actually causes a page to get leaked by the
   allocator, but it serves as a good example of the kind of assertions
   we can make by judicously peeking at allocator internals.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc_test.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc_test.c b/mm/page_alloc_test.c
index c6bcfcaf61b57ca35ad1b5fc48fd07d0402843bc..0c4effb151f4cd31ec6a696615a9b6ae4964b332 100644
--- a/mm/page_alloc_test.c
+++ b/mm/page_alloc_test.c
@@ -26,6 +26,139 @@
 	}									\
 })
 
+#define EXPECT_WITHIN_ZONE(test, page, zone) ({					\
+	unsigned long pfn = page_to_pfn(page);					\
+	unsigned long start_pfn = zone->zone_start_pfn;				\
+	unsigned long end_pfn = start_pfn + zone->spanned_pages;		\
+										\
+	KUNIT_EXPECT_TRUE_MSG(test,						\
+		pfn >= start_pfn && pfn < end_pfn,				\
+		"Wanted PFN 0x%lx - 0x%lx, got 0x%lx",				\
+		start_pfn, end_pfn, pfn);					\
+	KUNIT_EXPECT_PTR_EQ_MSG(test, page_zone(page), zone,			\
+		"Wanted %px (%s), got %px (%s)",				\
+		zone, zone->name, page_zone(page), page_zone(page)->name);	\
+})
+
+static void action_nodemask_free(void *ctx)
+{
+	NODEMASK_FREE(ctx);
+}
+
+/*
+ * Call __alloc_pages_noprof with a nodemask containing only the nid.
+ *
+ * Never returns NULL.
+ */
+static inline struct page *alloc_pages_force_nid(struct kunit *test,
+						 gfp_t gfp, int order, int nid)
+{
+	NODEMASK_ALLOC(nodemask_t, nodemask, GFP_KERNEL);
+	struct page *page;
+
+	KUNIT_ASSERT_NOT_NULL(test, nodemask);
+	kunit_add_action(test, action_nodemask_free, &nodemask);
+	nodes_clear(*nodemask);
+	node_set(nid, *nodemask);
+
+	page = __alloc_pages_noprof(GFP_KERNEL, 0, nid, nodemask);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	return page;
+}
+
+static inline bool page_on_buddy_list(struct page *want_page, struct list_head *head)
+{
+	struct page *found_page;
+
+	list_for_each_entry(found_page, head, buddy_list) {
+		if (found_page == want_page)
+			return true;
+	}
+
+	return false;
+}
+
+/* Test case parameters that are independent of alloc order.  */
+static const struct {
+	gfp_t gfp_flags;
+	enum zone_type want_zone;
+} alloc_fresh_gfps[] = {
+	/*
+	 * The way we currently set up the isolated node, everything ends up in
+	 * ZONE_NORMAL.
+	 */
+	{ .gfp_flags = GFP_KERNEL,	.want_zone = ZONE_NORMAL },
+	{ .gfp_flags = GFP_ATOMIC,	.want_zone = ZONE_NORMAL },
+	{ .gfp_flags = GFP_USER,	.want_zone = ZONE_NORMAL },
+	{ .gfp_flags = GFP_DMA32,	.want_zone = ZONE_NORMAL },
+};
+
+struct alloc_fresh_test_case {
+	int order;
+	int gfp_idx;
+};
+
+/* Generate test cases as the cross product of orders and alloc_fresh_gfps.  */
+static const void *alloc_fresh_gen_params(const void *prev, char *desc)
+{
+	/* Buffer to avoid allocations. */
+	static struct alloc_fresh_test_case tc;
+
+	if (!prev) {
+		/* First call */
+		tc.order = 0;
+		tc.gfp_idx = 0;
+		return &tc;
+	}
+
+	tc.gfp_idx++;
+	if (tc.gfp_idx >= ARRAY_SIZE(alloc_fresh_gfps)) {
+		tc.gfp_idx = 0;
+		tc.order++;
+	}
+	if (tc.order > MAX_PAGE_ORDER)
+		/* Finished. */
+		return NULL;
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "order %d %pGg\n",
+		tc.order, &alloc_fresh_gfps[tc.gfp_idx].gfp_flags);
+	return &tc;
+}
+
+/* Smoke test: allocate from a node where everything is in a pristine state. */
+static void test_alloc_fresh(struct kunit *test)
+{
+	const struct alloc_fresh_test_case *tc = test->param_value;
+	gfp_t gfp_flags = alloc_fresh_gfps[tc->gfp_idx].gfp_flags;
+	enum zone_type want_zone_type = alloc_fresh_gfps[tc->gfp_idx].want_zone;
+	struct zone *want_zone = &NODE_DATA(isolated_node)->node_zones[want_zone_type];
+	struct list_head *buddy_list;
+	struct per_cpu_pages *pcp;
+	struct page *page, *merged_page;
+	int cpu;
+
+	page = alloc_pages_force_nid(test, gfp_flags, tc->order, isolated_node);
+
+	EXPECT_WITHIN_ZONE(test, page, want_zone);
+
+	cpu = get_cpu();
+	__free_pages(page, 0);
+	pcp = per_cpu_ptr(want_zone->per_cpu_pageset, cpu);
+	put_cpu();
+
+	/*
+	 * Should end up back in the free area when drained. Because everything
+	 * is free, it should get buddy-merged up to the maximum order.
+	 */
+	drain_zone_pages(want_zone, pcp);
+	KUNIT_EXPECT_TRUE(test, PageBuddy(page));
+	KUNIT_EXPECT_EQ(test, buddy_order(page), MAX_PAGE_ORDER);
+	KUNIT_EXPECT_TRUE(test, list_empty(&pcp->lists[MIGRATE_UNMOVABLE]));
+	merged_page = pfn_to_page(round_down(page_to_pfn(page), 1 << MAX_PAGE_ORDER));
+	buddy_list = &want_zone->free_area[MAX_PAGE_ORDER].free_list[MIGRATE_UNMOVABLE];
+	KUNIT_EXPECT_TRUE(test, page_on_buddy_list(merged_page, buddy_list));
+}
+
 static void action_drain_pages_all(void *unused)
 {
 	int cpu;
@@ -144,7 +277,11 @@ static void depopulate_isolated_node(struct kunit_suite *suite)
 	WARN_ON(add_memory(0, start, size, MMOP_ONLINE));
 	WARN_ON(walk_memory_blocks(start, size, NULL, memory_block_online_cb));
 }
-static struct kunit_case test_cases[] = { {} };
+
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE_PARAM(test_alloc_fresh, alloc_fresh_gen_params),
+	{}
+};
 
 struct kunit_suite page_alloc_test_suite = {
 	.name = "page_alloc",

-- 
2.48.1.601.g30ceb7b040-goog


