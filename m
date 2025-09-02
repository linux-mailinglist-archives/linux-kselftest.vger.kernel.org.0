Return-Path: <linux-kselftest+bounces-40625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E805B40A87
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059DF1BA2824
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A633CE8E;
	Tue,  2 Sep 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc317jNV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91A3314C8
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830352; cv=none; b=eB/mJ7zNuJJhKW42+bntXKy30Uc5tUg8uV51jVGWF0A5BvertyCta/XqiiJrwCzRFrNYT+Bb7+HYs5SnASPEWwxKQjYqTXeY7cy3XMdPV3nL0Mg5kGl+qY7D6gUdmaxBOtViKVYgf7EZD+TRjtVuR3dMekzun6KBGhTuAJ61jH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830352; c=relaxed/simple;
	bh=ASh/x9X/3Itsj4Qm1O67fkentIoPBZyLTFXa8/VaSzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwK9Wi/ZWWnFYbMDGgbghM6OiXU0o/d7YVa0ALwFVGXNedCvnIfs4BAB3HHZk51X9ISwNGib6JUyIzJks//m8F6TeqEMSW1kK0q8HYuy1pjvrl1iORuYR67ySRPd2nvv/fDP5SiYXuoy0BcaED+MUoWEOpoGwdojglF1UgWPOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc317jNV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756830349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGt+rfAZPqOpC/usLmyRdPXY0e3SkpciH6+5LLOoAzw=;
	b=Sc317jNVjK/DiyAK/nLbHp3t6XNFAYUTHSoZzaPL6Ox7shjvSbqD45wtUjW5ewtUP+YFNd
	q0sGSdYrLCU0MppKTw5fY0GzAtlsIjT5Jaj2ESarX0gElzHjeE8jPBv2pVawULW9avnRmS
	52SpXFBFKeO/uiVEPtZrF2PQKEWfN9g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-bSUXBqyPNWqsMD_lkbXvuA-1; Tue,
 02 Sep 2025 12:25:46 -0400
X-MC-Unique: bSUXBqyPNWqsMD_lkbXvuA-1
X-Mimecast-MFC-AGG-ID: bSUXBqyPNWqsMD_lkbXvuA_1756830345
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 983FE19560AD;
	Tue,  2 Sep 2025 16:25:45 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.80.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D482230001A7;
	Tue,  2 Sep 2025 16:25:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/2] selftests/mm: split_huge_page_test: fix occasional is_backed_by_folio() wrong results
Date: Tue,  2 Sep 2025 18:25:35 +0200
Message-ID: <20250902162536.956465-2-david@redhat.com>
In-Reply-To: <20250902162536.956465-1-david@redhat.com>
References: <20250902162536.956465-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When checking for actual tail or head pages of a folio, we must make
sure that the KPF_COMPOUND_HEAD/KPF_COMPOUND_TAIL flag is paired with
KPF_THP.

For example, if we have another large folio after our large folio in
physical memory, our "pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL" would
trigger even though it's actually a head page of the next folio.

If is_backed_by_folio() returns a wrong result, split_pte_mapped_thp()
can fail with "Some THPs are missing during mremap".

Fix it by checking for head/tail pages of folios properly. Add
folio_tail_flags/folio_head_flags to improve readability and use these
masks also when just testing for any compound page.

Fixes: 169b456b0162 ("selftests/mm: reimplement is_backed_by_thp() with more precise check")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 10ae65ea032f6..72d6d8bb329ed 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -44,6 +44,8 @@ int kpageflags_fd;
 static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 		int kpageflags_fd)
 {
+	const uint64_t folio_head_flags = KPF_THP | KPF_COMPOUND_HEAD;
+	const uint64_t folio_tail_flags = KPF_THP | KPF_COMPOUND_TAIL;
 	const unsigned long nr_pages = 1UL << order;
 	unsigned long pfn_head;
 	uint64_t pfn_flags;
@@ -61,7 +63,7 @@ static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 
 	/* check for order-0 pages */
 	if (!order) {
-		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
+		if (pfn_flags & (folio_head_flags | folio_tail_flags))
 			return false;
 		return true;
 	}
@@ -76,14 +78,14 @@ static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 		goto fail;
 
 	/* head PFN has no compound_head flag set */
-	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
+	if ((pfn_flags & folio_head_flags) != folio_head_flags)
 		return false;
 
 	/* check all tail PFN flags */
 	for (i = 1; i < nr_pages; i++) {
 		if (pageflags_get(pfn_head + i, kpageflags_fd, &pfn_flags))
 			goto fail;
-		if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)))
+		if ((pfn_flags & folio_tail_flags) != folio_tail_flags)
 			return false;
 	}
 
@@ -94,11 +96,8 @@ static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
 	if (pageflags_get(pfn_head + nr_pages, kpageflags_fd, &pfn_flags))
 		return true;
 
-	/* this folio is bigger than the given order */
-	if (pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL))
-		return false;
-
-	return true;
+	/* If we find another tail page, then the folio is larger. */
+	return (pfn_flags & folio_tail_flags) != folio_tail_flags;
 fail:
 	ksft_exit_fail_msg("Failed to get folio info\n");
 	return false;
-- 
2.50.1


