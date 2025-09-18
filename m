Return-Path: <linux-kselftest+bounces-40112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C5B38E2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D987B8985
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13D8312836;
	Wed, 27 Aug 2025 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0AykLCX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5101A9FB0
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332848; cv=none; b=PEF0Yy9uN18dP8v05+DCQXNA2NY6t+qfrlsTN+vWzFqwpcFhzlTV7ow2R4jl82Fyc1v8S2wl/RQe+zJbCJciT8quU56QrIZPhIMHhoJ1+cFiGM0dOqlSTA7YYWIWcgrMry9OTawyuyQQqn+mRNO0afyMTMddiA+Le5IhIxs2Wgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332848; c=relaxed/simple;
	bh=qYYk6KZcslwxGKEwqkJsa/AY4n3xHnxHh8FtUFt6+As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfTTBrjHrhF0TckkMoHW35HjKcbq7amrXoLvjO2tJs0PF+MkNXw1avnsl6Fabs5cIOD0kTJIPv7cfVTRKP4iS+3YBpfcKMTUf2+mur1PZOZJPcs0OZ9bLHq/1eXgf5LlZddl5DjbyHTJTrIZLehC1kdLP3vwF64IMbmhbC+V1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0AykLCX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756332846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jt1gUZzcr2XqEG7AN90PiEkY48hGbYno8tKmbdcHa9Y=;
	b=M0AykLCX0yZ5uL5W11zeQxBMd2kUOzwM2A+bzarAKsFZXWvZWECyrkQbl4S9depP6FELa4
	REnLtkiot0qI0lfyepswQke1pGWryLNPsil8TXDU57n3L4oJaCI0fnnVGzF08RzB59OBtk
	YZCLzgKmTE1UV2yShKMzyt/1NKQoga8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-J9sCWjtzNZKv3p8K8yqDNQ-1; Wed,
 27 Aug 2025 18:06:02 -0400
X-MC-Unique: J9sCWjtzNZKv3p8K8yqDNQ-1
X-Mimecast-MFC-AGG-ID: J9sCWjtzNZKv3p8K8yqDNQ_1756332357
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 230CF19560B0;
	Wed, 27 Aug 2025 22:05:57 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.80.195])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5908830001A1;
	Wed, 27 Aug 2025 22:05:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 13/36] mm/hugetlb: cleanup hugetlb_folio_init_tail_vmemmap()
Date: Thu, 28 Aug 2025 00:01:17 +0200
Message-ID: <20250827220141.262669-14-david@redhat.com>
In-Reply-To: <20250827220141.262669-1-david@redhat.com>
References: <20250827220141.262669-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We can now safely iterate over all pages in a folio, so no need for the
pfn_to_page().

Also, as we already force the refcount in __init_single_page() to 1,
we can just set the refcount to 0 and avoid page_ref_freeze() +
VM_BUG_ON. Likely, in the future, we would just want to tell
__init_single_page() to which value to initialize the refcount.

Further, adjust the comments to highlight that we are dealing with an
open-coded prep_compound_page() variant, and add another comment explaining
why we really need the __init_single_page() only on the tail pages.

Note that the current code was likely problematic, but we never ran into
it: prep_compound_tail() would have been called with an offset that might
exceed a memory section, and prep_compound_tail() would have simply
added that offset to the page pointer -- which would not have done the
right thing on sparsemem without vmemmap.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a97e4f14c0dc..1f42186a85ea4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3237,17 +3237,18 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 {
 	enum zone_type zone = zone_idx(folio_zone(folio));
 	int nid = folio_nid(folio);
+	struct page *page = folio_page(folio, start_page_number);
 	unsigned long head_pfn = folio_pfn(folio);
 	unsigned long pfn, end_pfn = head_pfn + end_page_number;
-	int ret;
-
-	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
-		struct page *page = pfn_to_page(pfn);
 
+	/*
+	 * We mark all tail pages with memblock_reserved_mark_noinit(),
+	 * so these pages are completely uninitialized.
+	 */
+	for (pfn = head_pfn + start_page_number; pfn < end_pfn; page++, pfn++) {
 		__init_single_page(page, pfn, zone, nid);
 		prep_compound_tail((struct page *)folio, pfn - head_pfn);
-		ret = page_ref_freeze(page, 1);
-		VM_BUG_ON(!ret);
+		set_page_count(page, 0);
 	}
 }
 
@@ -3257,12 +3258,15 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 {
 	int ret;
 
-	/* Prepare folio head */
+	/*
+	 * This is an open-coded prep_compound_page() whereby we avoid
+	 * walking pages twice by initializing/preparing+freezing them in the
+	 * same go.
+	 */
 	__folio_clear_reserved(folio);
 	__folio_set_head(folio);
 	ret = folio_ref_freeze(folio, 1);
 	VM_BUG_ON(!ret);
-	/* Initialize the necessary tail struct pages */
 	hugetlb_folio_init_tail_vmemmap(folio, 1, nr_pages);
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
-- 
2.50.1


