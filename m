Return-Path: <linux-kselftest+bounces-39572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37AFB30511
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0283A1534
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC603728A5;
	Thu, 21 Aug 2025 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6rdZa0L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B31371EBB
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806905; cv=none; b=PI/Pn6gjorgMLe1WtSSHQ9zHEpsFRP3eDcsjxlqudH71TajSLJeIKQdBaXgpVvSjEFNs9VN+2d1Bl18L/AfArrE7HDC9QbibsEB2jNh8ZsUcqdhWAsBVEo5lqsnh+2eBOjniNeVyOCX8DdqSwZivieTcHUN4Ijy0yoRJO3Boccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806905; c=relaxed/simple;
	bh=I7luCT+CObepmsBOKpah/UXsbrY2375DH2pptgGLgo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9CajA3RmQao6x56v3zUp038J5GTXHS4se6N9wus/YQmmqCdVAv8MfUa7ookP5yoD0lHagDB+cudgi7xwUlmrIl00Tdd8X3d2+9zXnqsdGE0BtsXtm434L53lUmfEkwKt500E1xuopgudbWNBn0B6wnbAN5VZJeDhrPysX/Wdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6rdZa0L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXj+9vT03G0X8fnCGUCy6hSTWwnZnWm2sdD6cJzGZDI=;
	b=M6rdZa0LchQFrLtI1E9k9A8Cbdj5oSLN+8n0tGDxaUX5RemDz8FpiveUXa308MHOtHPQDx
	CiYAE3s33ONqZUUCqDt1PrDoo4pFWl1+orTNVHLRyJ6LQpTOoE7K8FShRLepU8d0XT1GHo
	Mejclh3XeYEZ2j/DotMlYxwqUGII5uw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-4tkxYndON2-Wg-TBWyUCtg-1; Thu, 21 Aug 2025 16:07:36 -0400
X-MC-Unique: 4tkxYndON2-Wg-TBWyUCtg-1
X-Mimecast-MFC-AGG-ID: 4tkxYndON2-Wg-TBWyUCtg_1755806855
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41b779aso818605f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806855; x=1756411655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXj+9vT03G0X8fnCGUCy6hSTWwnZnWm2sdD6cJzGZDI=;
        b=l58akFgdRSxL+DOqI7kOD4VIumfKOf790EdAORV9x3njD4mvmrEv1PyHy9epW8c/vh
         RskxbnRCxHdPKymzKCwJNrne16vHyZhEAKAo9MlgG9U2RoZmZxRnOu/A1EdMJf/3DAuq
         gh6P2DxKFjMur6oEqlVNrihW7mkzs3Z+FXxn4UYI9iaaGdnpv8WPL3x7ql5RAlqMOrFT
         TLpFpiPdDO6PeWsAChpotkpmKtA/F/5lfqETO8mAnWA3mej5Uv+/JqARxBd/2wHaa1VC
         QwU2E9DKVG9kWsGyiqvGuKFRCh5VB1lSAcJOYeK8Q2RXyKujWn93IeSMU/MGPrNZ/WgH
         jzwg==
X-Forwarded-Encrypted: i=1; AJvYcCWwNX/l+09ahfQLQWl21b9MaS6l1Idnti6WOIIkORfWmpuY2vV5S23vvtCocP15vSlwoUQ5cvo8TyBTRdD2QK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3eBroBBRG1FLU+226mx9t2MANMdSaHWrnhaKPos18wrFeu51a
	lkx1fltQK80SeBI8cBnpW/Sr0UA/GdRzbpiiZvjxpIjZzm2fjQ7dIX4tE2T8APiBTC4PWm3AImD
	ZY2Nm2PX+F7CAvFCgodiWXsirWgpCXx5EFNqz01NjsDIZQU7Ld+YeNS7XSlSQxElctp4R7w==
X-Gm-Gg: ASbGncsYbgQ8xySCU6hlkL9UGgP7p+AgCUkQhOBQW1AChhrW7leBR9/lcObCmIMkXA6
	yVB/qtc20AhepxcLtIIZWPbHqD/pOyxYiThWhUjnAa0ZLzRVBaOzqKZEm2UeHH08u0fW0U1iku4
	deZ6kS9fJJIGcCJ2zVzgk0qe/2odegf2fLeiwTWVw9ubzwshipRYh1A0NrI+REShqZEI8lU9zs+
	GPLnriiELNPGovUbRT+j0mDIbMBZ/iF8Nf/+1gdAfKGKzjmPcklQdSmjm8I0SHHq8IjnnnO7ol/
	qZlE3YoZlpVzsT3JQ7bmfxLQK+p38PTSIbtn9yww34z3AWMV71b1gg7nt4ME0OhwjsteqIW0odI
	TlWnit9HOljoZuyGr6Roj6A==
X-Received: by 2002:a05:6000:2303:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3c5ddd7f36emr169098f8f.47.1755806855307;
        Thu, 21 Aug 2025 13:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbzCbSL6MUAhNqtGz96KSex+k6XoYEx77XRmSFhqyAAErvnD4a434thNrJcfmyX2YJjFDsxQ==
X-Received: by 2002:a05:6000:2303:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3c5ddd7f36emr169035f8f.47.1755806854709;
        Thu, 21 Aug 2025 13:07:34 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077788b39sm12802789f8f.47.2025.08.21.13.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:34 -0700 (PDT)
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
Subject: [PATCH RFC 10/35] mm/hugetlb: cleanup hugetlb_folio_init_tail_vmemmap()
Date: Thu, 21 Aug 2025 22:06:36 +0200
Message-ID: <20250821200701.1329277-11-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All pages were already initialized and set to PageReserved() with a
refcount of 1 by MM init code.

In fact, by using __init_single_page(), we will be setting the refcount to
1 just to freeze it again immediately afterwards.

So drop the __init_single_page() and use __ClearPageReserved() instead.
Adjust the comments to highlight that we are dealing with an open-coded
prep_compound_page() variant.

Further, as we can now safely iterate over all pages in a folio, let's
avoid the page-pfn dance and just iterate the pages directly.

Note that the current code was likely problematic, but we never ran into
it: prep_compound_tail() would have been called with an offset that might
exceed a memory section, and prep_compound_tail() would have simply
added that offset to the page pointer -- which would not have done the
right thing on sparsemem without vmemmap.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d12a9d5146af4..ae82a845b14ad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3235,17 +3235,14 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 					unsigned long start_page_number,
 					unsigned long end_page_number)
 {
-	enum zone_type zone = zone_idx(folio_zone(folio));
-	int nid = folio_nid(folio);
-	unsigned long head_pfn = folio_pfn(folio);
-	unsigned long pfn, end_pfn = head_pfn + end_page_number;
+	struct page *head_page = folio_page(folio, 0);
+	struct page *page = folio_page(folio, start_page_number);
+	unsigned long i;
 	int ret;
 
-	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
-		struct page *page = pfn_to_page(pfn);
-
-		__init_single_page(page, pfn, zone, nid);
-		prep_compound_tail((struct page *)folio, pfn - head_pfn);
+	for (i = start_page_number; i < end_page_number; i++, page++) {
+		__ClearPageReserved(page);
+		prep_compound_tail(head_page, i);
 		ret = page_ref_freeze(page, 1);
 		VM_BUG_ON(!ret);
 	}
@@ -3257,12 +3254,14 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 {
 	int ret;
 
-	/* Prepare folio head */
+	/*
+	 * This is an open-coded prep_compound_page() whereby we avoid
+	 * walking pages twice by preparing+freezing them in the same go.
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


