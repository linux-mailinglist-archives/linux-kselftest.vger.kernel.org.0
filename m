Return-Path: <linux-kselftest+bounces-40527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F0B3F814
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E566948250F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E68917555;
	Tue,  2 Sep 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juNKTprH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26E20E011
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800997; cv=none; b=V90bex4RheCSsbEcdHazFmi/owgu8Ne7F+YQWomiBKklVyL6nqbQfTUGXjxX4GzKo77Cc1GVsAk2kPd2CJzeBuj6XylrgLNs5TWgfBgxUsPu8BLfbMvjJx5N16NLJRUZGKsp0GkiPeP3U7Ap8en3yxfzJiJPohZDw6vuZyHzq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800997; c=relaxed/simple;
	bh=74nK+WYMu9DSuP6wFQZOsGO+pH4P9umevHMALDWLWBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJn8a4h7mrI9Z2Nzu4v5gJtJf0CnNiVxdxMveRvttj+ID/d8fojYCnDuoetSJ7vFH9Jv4j8jeePz7ZoqKQcwu/sIVLt12uGkCi4GUqd6hwCO0SQc1R3sl2+BZ0Zlo627IuCLy59jr6O85uYC7x9Ix6M8vKfQMLcgEM4sJ3dEJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juNKTprH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cb9e039d9so10169136a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756800994; x=1757405794; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YlAMMsnZWcbTLtfMrrk541ImHayymBVM5nxJ5ObINw=;
        b=juNKTprHbv14yXF10Cp2f/yAmWd8UTervp/KbcG23Owm09FOROBSCQJQu0ZtOOsLe4
         EDLAa9Tifyl+QA0XEPVunRbc39KGrTbECSUNh8YqQPgnOSztRzYi7lzPtbYUv264dUSK
         i2Y1eeXagS1d8e3irkpGEfEuXQH/mr8Z0Pfm+o7Az825ZmSFdwXuYiTVX+vZQm3rHZbz
         J7sHCe3C9Vvsr/0GYCiJ1voMGr3iUVvRRBEtf4Xlb81QdGKQsDq0U2//sap32X4Z6iJT
         07amSi8cX7v+GAnEIAxX/1mhe3PFMKQlYcRsoGkGftHmhEdnNdF2Udi4tCunGkuNa+Cn
         urWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800994; x=1757405794;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/YlAMMsnZWcbTLtfMrrk541ImHayymBVM5nxJ5ObINw=;
        b=pBJt+6638ToKzqnLEHugkaphqoZ2ApgyPZOR7WOUdj+TwUwiIQiqPTJn4uAzvSBHk3
         onQfERObnlIuFThQN3dPt+pcbxz92FbuzNi6nictSeaawbnQXYrlXWWrKf4QQ9NTSoFr
         FnMKIAgWunT7qOrEfV/Fq+hXDiabHvxXQxRNPTC9BiNRZIm6Ah5jIG6h0Y9QyjaUmA8E
         B46xSER37pc96RJbGE+Y7Dc88SjzBlmoEqytwvCvghPwmB+WGZbtl30/DhQex1RJlO/P
         DSjIb2oZRpI9NP9A6KlZuFClDtt88g7AjEGLUT+UHj88/jRt2aLkCASwd3D3x4WOvRvf
         Im3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYTqRwWqk4yliALAdle1hHCY9RzPKWtLT82eZi1jU7NXoFwHnCbZP7fjhHsNUatVroDSUPaoEgcPg+m+F3Bjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbs75K2nC55/5U0v1IJ6AgoQufmPZvovfigfOZcbwis4jzsY7g
	UwV9rhgMtsuKFG/nrvFcQJ2LLSBPVNqiEgbIpegMrmYXYxTvpVxCZK63
X-Gm-Gg: ASbGnctKM06vUyvW48QVsB6o75zpQJVSHu2a5AVic4/F1KSmLttHO66LUVtT6eUONm8
	pEK3xbLDoAqBmDfBvx5/Ud5CXBc7YlxIJnt/cWnp1YA2EFIvUQvn/e4gvAhBTcGD0CKtbFQrH/h
	57Q64ORgQT3JiVXq0A4vtRZ/Adv4/r4Fo8lXzkdnu8qBk4KfKzVTNS59YBuf45TXhpdGawvCpbx
	vpmOsJAidFqKQoV37AfRo86mVxzMhd8Ao3bOI9Uzan+gmjGk/udu0OsYwlPn85yl7FsZSD+mWVp
	4r4jpCvYrzD+1eSewcO0VUdcKclh+SSCtWDeJKc+Psa+1X5X9siHxO8TJa7r30T/pe2K3757xNZ
	N+Myw0rcZzjzBsZH3XYPRsGoyjJfFN0u+lOCM
X-Google-Smtp-Source: AGHT+IHkJHTyicWy5ZD8fYbhilGQrPCxOJFfdANlc2M9fuhxg9frq+7P0IyS8aiiCPThUcFiGHj8sQ==
X-Received: by 2002:a17:907:d10:b0:afe:cc9a:f58b with SMTP id a640c23a62f3a-b01f20bee98mr1142674166b.58.1756800993126;
        Tue, 02 Sep 2025 01:16:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042b0046ecsm447391966b.71.2025.09.02.01.16.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Sep 2025 01:16:32 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:16:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
Message-ID: <20250902081632.mopnwlt3stpijejj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
 <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Sep 01, 2025 at 09:10:57PM +0200, David Hildenbrand wrote:
[...]
>diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>index 10ae65ea032f6..aa0f0502efa06 100644
>--- a/tools/testing/selftests/mm/split_huge_page_test.c
>+++ b/tools/testing/selftests/mm/split_huge_page_test.c
>@@ -390,67 +390,88 @@ static void split_pmd_thp_to_order(int order)
> static void split_pte_mapped_thp(void)
> {
>-	char *one_page, *pte_mapped, *pte_mapped2;
>-	size_t len = 4 * pmd_pagesize;
>-	uint64_t thp_size;
>+	const size_t nr_thps = 4;
>+	const size_t thp_area_size = nr_thps * pmd_pagesize;
>+	const size_t page_area_size = nr_thps * pagesize;
>+	char *thp_area, *page_area = NULL, *tmp;
> 	size_t i;
>-	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
>+	thp_area = mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PROT_WRITE,
> 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>-	if (one_page == MAP_FAILED)
>-		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>+	if (thp_area == MAP_FAILED) {
>+		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
>+		goto out;
>+	}
>-	madvise(one_page, len, MADV_HUGEPAGE);
>+	madvise(thp_area, thp_area_size, MADV_HUGEPAGE);
>-	for (i = 0; i < len; i++)
>-		one_page[i] = (char)i;
>+	for (i = 0; i < thp_area_size; i++)
>+		thp_area[i] = (char)i;
>-	if (!check_huge_anon(one_page, 4, pmd_pagesize))
>-		ksft_exit_fail_msg("No THP is allocated\n");
>+	if (!check_huge_anon(thp_area, nr_thps, pmd_pagesize)) {
>+		ksft_test_result_skip("Not all THPs allocated\n");

Not sure why we skip here?

>+		goto out;
>+	}
>-	/* remap the first pagesize of first THP */
>-	pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
>-
>-	/* remap the Nth pagesize of Nth THP */
>-	for (i = 1; i < 4; i++) {
>-		pte_mapped2 = mremap(one_page + pmd_pagesize * i + pagesize * i,
>-				     pagesize, pagesize,
>-				     MREMAP_MAYMOVE|MREMAP_FIXED,
>-				     pte_mapped + pagesize * i);
>-		if (pte_mapped2 == MAP_FAILED)
>-			ksft_exit_fail_msg("mremap failed: %s\n", strerror(errno));
>-	}
>-
>-	/* smap does not show THPs after mremap, use kpageflags instead */
>-	thp_size = 0;
>-	for (i = 0; i < pagesize * 4; i++)
>-		if (i % pagesize == 0 &&
>-		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>-			thp_size++;
>-
>-	if (thp_size != 4)
>-		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
>-
>-	/* split all remapped THPs */
>-	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
>-		      (uint64_t)pte_mapped + pagesize * 4, 0);
>-
>-	/* smap does not show THPs after mremap, use kpageflags instead */
>-	thp_size = 0;
>-	for (i = 0; i < pagesize * 4; i++) {
>-		if (pte_mapped[i] != (char)i)
>-			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>+	/*
>+	 * To challenge spitting code, we will mremap page[x] of the
>+	 * thp[x] into a smaller area, and trigger the split from that
>+	 * smaller area. This will end up replacing the PMD mappings in
>+	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
>+	 */
>+	page_area = mmap(NULL, page_area_size, PROT_READ | PROT_WRITE,
>+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>+	if (page_area == MAP_FAILED) {
>+		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
>+		goto out;
>+	}
>-		if (i % pagesize == 0 &&
>-		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
>-			thp_size++;
>+	for (i = 0; i < nr_thps; i++) {
>+		tmp = mremap(thp_area + pmd_pagesize * i + pagesize * i,
>+			     pagesize, pagesize, MREMAP_MAYMOVE|MREMAP_FIXED,
>+			     page_area + pagesize * i);
>+		if (tmp != MAP_FAILED)
>+			continue;
>+		ksft_test_result_fail("mremap failed: %s\n", strerror(errno));
>+		goto out;
>+	}
>+
>+	/*
>+	 * Verify that our THPs were not split yet. Note that
>+	 * check_huge_anon() cannot be used as it checks for PMD mappings.
>+	 */
>+	for (i = 0; i < nr_thps; i++) {
>+		if (is_backed_by_folio(page_area + i * pagesize, pmd_order,
>+				       pagemap_fd, kpageflags_fd))
>+			continue;
>+		ksft_test_result_fail("THP %zu missing after mremap\n", i);
>+		goto out;
> 	}
>-	if (thp_size)
>-		ksft_exit_fail_msg("Still %ld THPs not split\n", thp_size);
>+	/* Split all THPs through the remapped pages. */
>+	write_debugfs(PID_FMT, getpid(), (uint64_t)page_area,
>+		      (uint64_t)page_area + page_area_size, 0);
>+
>+	/* Corruption during mremap or split? */
>+	for (i = 0; i < page_area_size; i++) {
>+		if (page_area[i] == (char)i)
>+			continue;
>+		ksft_test_result_fail("%zu byte corrupted\n", i);
>+		goto out;
>+	}
>+
>+	/* Split failed? */
>+	for (i = 0; i < nr_thps; i++) {
>+		if (is_backed_by_folio(&page_area[i], 0, pagemap_fd, kpageflags_fd))

I guess we want to check (page_area + i * pagesize) here?

>+			continue;
>+		ksft_test_result_fail("THP %zu not split\n", i);
>+	}
> 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
>-	munmap(one_page, len);
>+out:
>+	munmap(thp_area, thp_area_size);
>+	if (page_area)
>+		munmap(page_area, page_area_size);
> }
> static void split_file_backed_thp(int order)
>-- 
>2.50.1
>
>
>-- 
>Cheers
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

