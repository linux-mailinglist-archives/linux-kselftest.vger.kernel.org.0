Return-Path: <linux-kselftest+bounces-40501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A73B3F286
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 04:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43C31A81C74
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 02:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EB222688C;
	Tue,  2 Sep 2025 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqRYrK0q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248D678F2B
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756781479; cv=none; b=G8tnklX3ZqL9uWSOEIZg3VfSY3rQ+kpQjMDy1ESohjnIBMhLFP05UK/0Ny3xvDLH4/Vv+43XH3qEKxS/wSSaTIwn/RI1ibV8BQOQeau7M9DU0NO2VELPmHlHuokJpCWOUJMJcPa/RfibuTjjq7reVGXOmeKBnWe1VZMF8ZzKEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756781479; c=relaxed/simple;
	bh=Lw8rZDaElUdOj0YewXU0GsdB9ThbfAVzpSoqTSRqZGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLQTA0K7UIDyuNOWRtyIJtqzAdyKe0BaGykuOf7md3q9dU9lhMdAa6B1p6kr4/XtG+LlabqSL4Fjdeu1604/FQ0I3hkvDgnooERtLFQU0q1yNVt0Ve7jUzjyg1yKSHBYPCTUPS6QiJpXJWx83q8w+MRy9r2Vm4/WF19E0d8eE1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqRYrK0q; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afedbb49c26so746063666b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 19:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756781473; x=1757386273; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xF0+u3i94vKk1aqXJMSL12WDn4bvFxhGB6UadIJ7Gs=;
        b=JqRYrK0qdNyLN19a9YKu5Gxp0UxC3LgQxDjbQ2DiOqMdwDgyyp4wxgJ3Jx1+MLZUhG
         Xh7VK/Bb4rMpjt7r0tENXsPIIBKfLU7nMV4ye+pG0m0vzjAM+GR6E/WKaWI/BOJPNoFG
         06qVfEZQvb1VtsL+GJ4h/H6kj5vSkz4YJbnY+q0VIava8JFLdFV0WUP6K70ocQKyiDxV
         uBDeW+XZ7fQzIeYYQKn1v/+HRMe/BBCsHm9gXioCwfa4tnNmtylYkCtHFEyi8V+sZjQF
         XJY54wGBrx5Ly5Uam8SxPB5ia/Fue1k8lOqPaHMX1vx75ZMKVmFP5/ARoqEmtTZKC+wu
         ZlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756781473; x=1757386273;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xF0+u3i94vKk1aqXJMSL12WDn4bvFxhGB6UadIJ7Gs=;
        b=i7kOAr0d6ehP8cdUBGHajr/IXutVnz+jF46YcigSEbXTa7T9m83pij0ENNVd3YMhaZ
         7Kzj8MrkaLqHw4oj9bLjdLylCbN45p9QFZrTY0O51zYPJwsgGH7+eshgcdUzqIhNXFqa
         CGwcYcTNu/W9bHAYtjdncCYOYVKnJwAKvKPxdbjlCH0bX7nAgeWpK1j8SzhwyrhJsX7j
         Z/7pfzmAR8EWwWAwnZClaeKgfG+JJ5g9Qcqe1nS6Sn38Q4ncqq8k0bI3x9C0o4o9fyUQ
         dWTmmr5R/ck5K9Jts5yyozlOeVKinWjoVFiIygqWfLzlUZsQViIbpGtpS/KyH2uxiE2F
         GYVg==
X-Forwarded-Encrypted: i=1; AJvYcCUyOVssuYoPS3GdDnUvEcWKsPeT0E1q1ezBCug4HyliRsbL1/u+OJwONSO/zy5STlwCvznGtyfUgwA6qHEH7yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm3gsEWLHKUftKx7FhXEoCnqa/WaILlrLHZTsjQrDkiaCyxlB/
	qPK9Os9q/pQFQ1GB9/f4OkNBTwy840EYTMr7vdIOKsfXsaeT8PM8wgLEnLDjUw==
X-Gm-Gg: ASbGncuAg9VaWLGsshj5bUOjov9YX2XFKABXOm5vXvVR/afFSEjL7Ckevgybd33h4iy
	oWBduInuOCKdcJAgzQzTJKN4Cizurb8fkf8kXvQlgb3Xr0YCoM/dNsrkF16jmeRYzxlPHDV90i9
	YgX0qMx4WMASd1Cuj5BnGFam9bNcMWvN8dvMo5+i/XkhU/iPDp5VR/NG0xshMyTSdFg7xQqAMic
	yUzUy71tky2+bEz7b+oEDnFRDQaMyuqD1C4w7fWoY1vpuK6uuxqNJHIdNfgbZO57ojjFTiZPx6D
	1zukgpBnHD6uH6H8BWAxe6ay9LU5ut8no5VOhnkUW50sZuEuCe1Qof3wlqNwjgACkAlmY6ahb6M
	XfnjShKqcRYJ7UKVhJLtuIUWaTNH9CQbSp+u9
X-Google-Smtp-Source: AGHT+IEAusIojQFmVk/wxq4gx2dnc4kHFdzyWer4P7oKpleMhLaKPh3dc/qYbcIPG4E1duSTDnU2lA==
X-Received: by 2002:a17:907:3c89:b0:b00:aa4d:a394 with SMTP id a640c23a62f3a-b01d8b7f96emr1026323366b.24.1756781473164;
        Mon, 01 Sep 2025 19:51:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0419d76921sm526404166b.15.2025.09.01.19.51.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Sep 2025 19:51:12 -0700 (PDT)
Date: Tue, 2 Sep 2025 02:51:12 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
Message-ID: <20250902025112.d2n3o4imeptppctd@master>
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
>> > > > (a) Will this actually do anything? Also, maybe it does now, but can't the kernel just optimize that out in the future?
>> > > 
>> > > It remaps each subpage of 4 PMD THPs into a contiguous 2MB vaddr range and
>> > > perform split on that range.
>> > 
>> > I'm afraid I am missing the "why".
>> > 
>> > I would have thought that a "split_pte_mapped_thp" test would want to pte-map THPs
>> > to the see if they can be split.
>> > 
>> > Why is the mremap required? IOW, what exactly is the test trying to test that
>> > exceeds "split_pte_mapped_thp" ?
>> 
>> IMHO, it is an interesting test case for splitting a THP when only a subpage
>> is mapped into a vaddr range and in a contiguous vaddr each page comes from
>> different THPs.
>
>Right. Slightly similar to just MAV_DONTNEED'ing the other PTEs and trying to
>split the bigger range.
>
>Of course, if you involve more mremap, the RMAP logic of installing migration
>ptes will get stressed more.
>
>So yes, there are various ways on how to stress the RMAP walk when splitting.
>
>> The mprotect test case you are mentioning would still have all
>> subpages mapped by contiguous vaddrs.
>
>Right, it would not stress RMAP as much.
>
>> 
>> But if you think both are just testing PTE-mapped THPs, feel free to replace the
>> existing one with the mprotect test case. In addition, is_backed_by_folio()
>> can be reverted back to its prior version, since it no longer needs to handle
>> the case where subpages from different THPs can be mapped into a vaddr range.
>
>Oh, the is_backed_by_folio() change is actually really valuable.
>
>
>I think I was confused by the implementation that works on a single virtual address
>range with multiple different variables, questioning why we mremap at all.
>
>I tried cleaning up that test myself and ended up with the following (it
>escalated a bit). If that looks cleaner to you as well, I can submit that as a
>patch.
>
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

Would this create one hole at the beginning of each 2M range and cause
splitting underlining THP?

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

