Return-Path: <linux-kselftest+bounces-40626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C69B40A88
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 18:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A131BA275C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB2322743;
	Tue,  2 Sep 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfBJWZ+0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C6338F4A
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830353; cv=none; b=Qcw4kSyhL9Jv6TsGd8RoazPixXl8HADrEz0h5AZ3ADNF+SssxkA44/ujbAre17aMTBUVr+aenOgl4fm57v6s4HL57qU0LG8t+H2g9PNT23F9hMcVnIlJQM/7Z43HiqZBf5gf2DiE/mUmTbNcdjuvZwVmTxSvGCDmv7ubSTUDcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830353; c=relaxed/simple;
	bh=EPDKgQOgK+7zSwZkJ82YqCzR2US+XMjNJC6FYAnV0bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omHpM2hBOI/dp7CfHfRi7+w5cruYx+8Dn+B4WNYeuIL/pP0jUu8tXsFEfgV+6dHhz/KewcgKtbsZt+pvhoct5dB+teR4N4yAeqiXPVqHouE+LPniAySJUujg9Uy9brDuCJr8S5L01UF6U3MYAns/uSQOZCnyK1s1vxtBFIK6FTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfBJWZ+0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756830350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMnknAcw0zGmxUXxtl0RJkmxRxufvbi04WvYxzB4SiQ=;
	b=KfBJWZ+0XcJwbxA4FdoLYPfq44UPvQUe9sYbnYLFQm8VUWjAXDwnjXHsgbHI7Noh9kAO2y
	tWW9xHiggcD800HLfwJE6xR17P5j//J+2jp+mB3QkeXCT+rc37C4AOxD/3Bhl7l/kyqnJq
	ksTajij0BA+BUSViGZz6vblyAMZZEmc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-W1xsoQL6PVWgUup9MWJIow-1; Tue,
 02 Sep 2025 12:25:49 -0400
X-MC-Unique: W1xsoQL6PVWgUup9MWJIow-1
X-Mimecast-MFC-AGG-ID: W1xsoQL6PVWgUup9MWJIow_1756830348
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C7951800290;
	Tue,  2 Sep 2025 16:25:48 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.80.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C0AB300019F;
	Tue,  2 Sep 2025 16:25:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 2/2] selftests/mm: split_huge_page_test: cleanups for split_pte_mapped_thp test
Date: Tue,  2 Sep 2025 18:25:36 +0200
Message-ID: <20250902162536.956465-3-david@redhat.com>
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

There is room for improvement, so let's clean up a bit:

(1) Define "4" as a constant.

(2) SKIP if we fail to allocate all THPs (e.g., fragmented) and add
    recovery code for all other failure cases: no need to exit the test.

(3) Rename "len" to thp_area_size, and "one_page" to "thp_area".

(4) Allocate a new area "page_area" into which we will mremap the
    pages; add "page_area_size". Now we can easily merge the two
    mremap instances into a single one.

(5) Iterate THPs instead of bytes when checking for missed THPs after
    mremap.

(6) Rename "pte_mapped2" to "tmp", used to verify mremap(MAP_FIXED)
    result.

(7) Split the corruption test from the failed-split test, so we can just
    iterate bytes vs. thps naturally.

(8) Extend comments and clarify why we are using mremap in the first
    place.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/split_huge_page_test.c       | 123 +++++++++++-------
 1 file changed, 74 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 72d6d8bb329ed..7731191cc8e9b 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -389,67 +389,92 @@ static void split_pmd_thp_to_order(int order)
 
 static void split_pte_mapped_thp(void)
 {
-	char *one_page, *pte_mapped, *pte_mapped2;
-	size_t len = 4 * pmd_pagesize;
-	uint64_t thp_size;
+	const size_t nr_thps = 4;
+	const size_t thp_area_size = nr_thps * pmd_pagesize;
+	const size_t page_area_size = nr_thps * pagesize;
+	char *thp_area, *tmp, *page_area = MAP_FAILED;
 	size_t i;
 
-	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
+	thp_area = mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PROT_WRITE,
 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (one_page == MAP_FAILED)
-		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
+	if (thp_area == MAP_FAILED) {
+		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
+		return;
+	}
 
-	madvise(one_page, len, MADV_HUGEPAGE);
+	madvise(thp_area, thp_area_size, MADV_HUGEPAGE);
 
-	for (i = 0; i < len; i++)
-		one_page[i] = (char)i;
+	for (i = 0; i < thp_area_size; i++)
+		thp_area[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize))
-		ksft_exit_fail_msg("No THP is allocated\n");
+	if (!check_huge_anon(thp_area, nr_thps, pmd_pagesize)) {
+		ksft_test_result_skip("Not all THPs allocated\n");
+		goto out;
+	}
 
-	/* remap the first pagesize of first THP */
-	pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
-
-	/* remap the Nth pagesize of Nth THP */
-	for (i = 1; i < 4; i++) {
-		pte_mapped2 = mremap(one_page + pmd_pagesize * i + pagesize * i,
-				     pagesize, pagesize,
-				     MREMAP_MAYMOVE|MREMAP_FIXED,
-				     pte_mapped + pagesize * i);
-		if (pte_mapped2 == MAP_FAILED)
-			ksft_exit_fail_msg("mremap failed: %s\n", strerror(errno));
-	}
-
-	/* smap does not show THPs after mremap, use kpageflags instead */
-	thp_size = 0;
-	for (i = 0; i < pagesize * 4; i++)
-		if (i % pagesize == 0 &&
-		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
-			thp_size++;
-
-	if (thp_size != 4)
-		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
-
-	/* split all remapped THPs */
-	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
-		      (uint64_t)pte_mapped + pagesize * 4, 0);
-
-	/* smap does not show THPs after mremap, use kpageflags instead */
-	thp_size = 0;
-	for (i = 0; i < pagesize * 4; i++) {
-		if (pte_mapped[i] != (char)i)
-			ksft_exit_fail_msg("%ld byte corrupted\n", i);
+	/*
+	 * To challenge spitting code, we will mremap a single page of each
+	 * THP (page[i] of thp[i]) in the thp_area into page_area. This will
+	 * replace the PMD mappings in the thp_area by PTE mappings first,
+	 * but leaving the THP unsplit, to then create a page-sized hole in
+	 * the thp_area.
+	 * We will then manually trigger splitting of all THPs through the
+	 * single mremap'ed pages of each THP in the page_area.
+	 */
+	page_area = mmap(NULL, page_area_size, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (page_area == MAP_FAILED) {
+		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
+		goto out;
+	}
 
-		if (i % pagesize == 0 &&
-		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
-			thp_size++;
+	for (i = 0; i < nr_thps; i++) {
+		tmp = mremap(thp_area + pmd_pagesize * i + pagesize * i,
+			     pagesize, pagesize, MREMAP_MAYMOVE|MREMAP_FIXED,
+			     page_area + pagesize * i);
+		if (tmp != MAP_FAILED)
+			continue;
+		ksft_test_result_fail("mremap failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	/*
+	 * Verify that our THPs were not split yet. Note that
+	 * check_huge_anon() cannot be used as it checks for PMD mappings.
+	 */
+	for (i = 0; i < nr_thps; i++) {
+		if (is_backed_by_folio(page_area + i * pagesize, pmd_order,
+				       pagemap_fd, kpageflags_fd))
+			continue;
+		ksft_test_result_fail("THP %zu missing after mremap\n", i);
+		goto out;
 	}
 
-	if (thp_size)
-		ksft_exit_fail_msg("Still %ld THPs not split\n", thp_size);
+	/* Split all THPs through the remapped pages. */
+	write_debugfs(PID_FMT, getpid(), (uint64_t)page_area,
+		      (uint64_t)page_area + page_area_size, 0);
+
+	/* Corruption during mremap or split? */
+	for (i = 0; i < page_area_size; i++) {
+		if (page_area[i] == (char)i)
+			continue;
+		ksft_test_result_fail("%zu byte corrupted\n", i);
+		goto out;
+	}
+
+	/* Split failed? */
+	for (i = 0; i < nr_thps; i++) {
+		if (is_backed_by_folio(page_area + i * pagesize, 0,
+				       pagemap_fd, kpageflags_fd))
+			continue;
+		ksft_test_result_fail("THP %zu not split\n", i);
+	}
 
 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
-	munmap(one_page, len);
+out:
+	munmap(thp_area, thp_area_size);
+	if (page_area != MAP_FAILED)
+		munmap(page_area, page_area_size);
 }
 
 static void split_file_backed_thp(int order)
-- 
2.50.1


