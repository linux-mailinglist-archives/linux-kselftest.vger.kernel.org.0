Return-Path: <linux-kselftest+bounces-40681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4268DB415C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 09:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DDB564EF5
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F922DA743;
	Wed,  3 Sep 2025 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5Do6XWa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E72D9EDC
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Sep 2025 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882985; cv=none; b=imoSa5Kbc0TkcDenEXzSPhkvbdFz7suX38/MFJG2lVnCBTnIyqMH+9rrr+0pe3Acwc4q0CVtIwR5I09gzuEHMOPJhDDcoYgiXc3SqjxeDvbpg0BMYOJEDDKzXakh0nsIlV1qz6OmwvbQyNWX+K0JPD/C2O8ZuGkHRmf5Dsoea80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882985; c=relaxed/simple;
	bh=G6t/5pjet8mpzpHi5mysP4dTkQrjBmUPbnhJ0MhbR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0cGZuKSdnrdM7d+IUn891HeEvj++A1LdO6MG5r60aiYP4JJ+uCQELLx5crv7oDZJyuNZr0VoCyqkFePAqi2McOKMfo9OtbaNfIognFDkizPMbqy4chkv9Lg9VNF/Ta6pKH4zr9dlAYuzvFQnhKZHBbFwcF0qvzcpJtpzDIcMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5Do6XWa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756882982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2sRWSVC6muW7v9K/79DawocgKSZMBM0YbSqQ+7W344=;
	b=I5Do6XWaWefkT5WLjKn52qa/M+ukaGDML8edr1PfsaE23Le/of+FMLWtYGU3bUP/5sRQJl
	eQPgWV4VBY9MigY7k2xAyuPdD5Ws78DiRDatY+3CS/T+uqOcMvOc7W8wP41v09rMDCrLKP
	8dtrYiDGQNECmjcSziRinwb6EkSQ4uA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-3335_IOvNNyqrQzqpGdOOQ-1; Wed, 03 Sep 2025 03:03:00 -0400
X-MC-Unique: 3335_IOvNNyqrQzqpGdOOQ-1
X-Mimecast-MFC-AGG-ID: 3335_IOvNNyqrQzqpGdOOQ_1756882980
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dc3f943e6eso395332f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 00:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882979; x=1757487779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2sRWSVC6muW7v9K/79DawocgKSZMBM0YbSqQ+7W344=;
        b=dhTjMFpaBytYw0Ulmrma6HaUX+XywwLyVJYBHUhgL6TyxtHkQQnRtdctZkBWmYDz0U
         /0KzI52XOgY4OmgDk6MbAWy15usUuVmEOXCX/pe/EZUOKKFsH4kOJ4y84LrCdgiG/1WG
         RdQ5Jr4FUX6yOzKNMXnM1J5RyHYeqc5pA3CROMLxNyguus5qUR7EF2rMAJcaC612A0La
         cCzAgrRLLsfwKisjobuR4yE5Xm5H6DrZGkik9Pcin4rdKsG4APyRo25p5xKiVVv/Lhq+
         2NNo6yZxQR4akCkisBtIAp2JjTTMId+KsXRH1NH8r6yqgiuIcNFsSf8obHBKNyffYsWH
         UsQA==
X-Forwarded-Encrypted: i=1; AJvYcCWhub2vQB4wARFq864lVspBl5bBJvSTANH4dw5ECnfKhoZDTAX5ni+ycMe+K1pzem3cjgL1Q2yvyFqsjXpYL10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuszRDvIRI6Ekp6S2q86apVgt8draDYiYJVVgcet/oCMknZLq
	mmLsLzaaoBQp9Fnh0PpxbiC+wJbGShU4et9aeyPZ5VVSJYXqKu/yNSeuiLBOdbJr8ryK6g4CUyZ
	YQVM4jXd8gP77fOtFABizYII0CoIer17JUgLr+2pMtofzuNwwY2JodKYWAh2at0+/yH70dg==
X-Gm-Gg: ASbGncsoANwDZTEGZ3enG9gFz0XBsanWKVlJLoMev1iM8O6iot06554r4WhdvXlzdjh
	YdyMXDbpuEQjcKQESsT4ExfP+/SZvHMz5mcG0fPGQGBwjWiiOq2eJ7nHpAopNFl5dcwzrSWNuyw
	uFsXUrW0oAqKvpF/2nLLMuPvRDiZ8h6RzUZMwkT+XF+8Lziw1yzDF03ZE9NyIPNjw759RSdkYqy
	oI4WvtOcQGdEVdksm4pWibeqqKI/NkEjJOunLjKAkWAjWj/rscqW+Vyg7qaB38nc4YiG9CBesXZ
	0NV6IoRb874e4p//UVNrvcET8iAOg6K3NnxjraijbUO1L2aIb/roosg/s3ccZZNnrbF3+1iP8Gv
	GpP9azRr7Qm5rN0EVHqwbS5fe
X-Received: by 2002:a05:6000:1789:b0:3dc:2136:7523 with SMTP id ffacd0b85a97d-3dc2136754amr1475809f8f.0.1756882979524;
        Wed, 03 Sep 2025 00:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJPnLNL5I9w+xcg7OB1s/KttczlD4Bt2mn9lDViDhx6EVKHlJPHrKwqtJR3u79EyXcvnt/VA==
X-Received: by 2002:a05:6000:1789:b0:3dc:2136:7523 with SMTP id ffacd0b85a97d-3dc2136754amr1475777f8f.0.1756882979050;
        Wed, 03 Sep 2025 00:02:59 -0700 (PDT)
Received: from localhost (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d701622b92sm11105604f8f.58.2025.09.03.00.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:02:58 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 2/2] selftests/mm: split_huge_page_test: cleanups for split_pte_mapped_thp test
Date: Wed,  3 Sep 2025 09:02:53 +0200
Message-ID: <20250903070253.34556-3-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903070253.34556-1-david@redhat.com>
References: <20250903070253.34556-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
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


