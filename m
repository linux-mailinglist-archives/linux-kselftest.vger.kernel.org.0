Return-Path: <linux-kselftest+bounces-40497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71497B3EE55
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EA61B206CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 19:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B962EF653;
	Mon,  1 Sep 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwUzO34s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821925B662
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753864; cv=none; b=bTis8dNKy53WrO84ABNogPp2Na3KdGJp7SC3FBY+sHPLGVxUhZXcyph0JpM6KiHrPbElf9/3jbKbUJFpHTgEaH4TTmvdyzJ691Pk7as2CAGNRS1DpVmcElPr1XDJWQwf4rfNF5HuarhqI/KdQG48KDXhReLZLN8Fj2VSTBofMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753864; c=relaxed/simple;
	bh=6rqXGSXTGSmDSXVELVO84hfxpBetGzPbodr3s+8QaRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5emusz/48WQN5jHDj3EWM9EcWm7NyEA4CGWg/ODiU3UfsnANvk0meSTmZuEyiAdpfjHGKlvCtBWWOmmvivGgwlyh99/VRQuNkZ/aFDUL/fO3oVIL9LZ5v69VMgh42w+SUCCs36DitEIIpB2FcEmxo+G8uC6A6G4fxp6XlN8S2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwUzO34s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756753861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hktqsh8gO9xWQ1D/D1POyV5vXOSvg9V1CEzpXXPFoGE=;
	b=cwUzO34sFt5OYnjnOGcVHRHaTQWqQ5sMUdvj6Mv0ZnWK91n07UgC/4bA51qkJcaBpZDbB0
	dFVFPvWbNjIDO7uA9/gIaMqzDVqNKoUCE/hDKH96MaBg2ggZZjk0OsM0Pvp+dqZMLUaHYv
	5Kb8Ovs1QZ4icVXkBTtodkAC/yHK/2M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-PglhewOzPpy6MuK3fi56EQ-1; Mon, 01 Sep 2025 15:11:00 -0400
X-MC-Unique: PglhewOzPpy6MuK3fi56EQ-1
X-Mimecast-MFC-AGG-ID: PglhewOzPpy6MuK3fi56EQ_1756753859
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b7d497abbso27356495e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 12:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756753859; x=1757358659;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hktqsh8gO9xWQ1D/D1POyV5vXOSvg9V1CEzpXXPFoGE=;
        b=mh3yHj89A2H6JWUTan2440ARdQKXdF8Sy4/FgboGvHVZXQm0TD1HyzsilwH9JVc4cL
         /Wu8ZQR0nDZqjsXhP+k3lwcSJNfgI8cRsrMdAqr6GYyzyj8HZzWFwrsOOUBToQ0QNRRe
         /6AVdC6lbXQkKYLSU9LdQQ6WBCfvb1P2XBMGLFCi+Ev53RdSDHo55t+7RTtbpyZXsign
         Ub54gOst82JvcibpF03boueoy7RPCbMlr6YJOEge9vW+DBSZC5n+Mu+8FfET8EpzVeqC
         hz5Qkd+XKSFDQqT7Kw9ekKPsF/cLg1XNP8xOGT1eFnsL+oVSHJ8oKnETETgeZa8Xd/MU
         O/uA==
X-Forwarded-Encrypted: i=1; AJvYcCXpPpNRQI4prTqHYBRO74gNv62eF4pPTUDBMRCzAnMqfku+0fyLwcVqIfLrf794igPEYqexWlN+yTFJORa9H4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNyON+09KFo90sr+9XNPcUmU7zsQac3OY9xLYUG6IiRVA3tCn
	ZKLBjkytFAarXLlTRongSE4e5qV4WDsBC22rR4LPocmioA/uJIuKpQthawsuUe1Xstus3161Vit
	GbX/3JHMrlwhW8JJR9u0XyMIxNCAvid2UCERG0A1WmhBOw7AUeee+EulBPGjIgf8sSOd2rg==
X-Gm-Gg: ASbGncuqyfUhJGHI9/nQ3rH+XkcXL7tTHsPJRH+HCJ13XkpvdkGnU2grdJqBVI9UUFm
	Ul8BrqNupBeGa58y/m5bOzxq4Oxxj3it0tuphBfeHHXFj2LZJNhu4v10OCrRCgEdtHV09Mgpats
	7V02jVyikmjjucfIPKu+4HBr1dsAqG4m7goL06UKtqta/8mw+QA1UCnRVtJTJV5KjNJPkSi6llO
	YiR8aJrDCf4WUKJCB9+HzQuDRRvj6PQA/5EmlRegXW7DTkWP4AsfGhbzjaN0xfv+Kc2mJYRepvd
	mgWJW21O//CD6/1PYw8j8UDLo67DMn1h8Ojay50y5A4QBJaP2DyWF1sChsPL1JZcxQrb1xizjph
	3QzW4F17B+1TkVVEIyB5ogGT8IuhDkumObyTjew5A1mcD989gDKoVfJ1t1A1uA3Ep/z0=
X-Received: by 2002:a05:600c:1ca1:b0:45b:8d8d:58b5 with SMTP id 5b1f17b1804b1-45b8d8d5b0cmr32972075e9.15.1756753859050;
        Mon, 01 Sep 2025 12:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCzYEDhPCaqzntJlqhh6uR24AEmbZv4V5Y8kMkmlsfFlAm2Kd7XcuWxxlMJtCGtQkVfBvkBg==
X-Received: by 2002:a05:600c:1ca1:b0:45b:8d8d:58b5 with SMTP id 5b1f17b1804b1-45b8d8d5b0cmr32971935e9.15.1756753858607;
        Mon, 01 Sep 2025 12:10:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b814da51esm146543865e9.8.2025.09.01.12.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 12:10:58 -0700 (PDT)
Message-ID: <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
Date: Mon, 1 Sep 2025 21:10:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>> (a) Will this actually do anything? Also, maybe it does now, but can't the kernel just optimize that out in the future?
>>>
>>> It remaps each subpage of 4 PMD THPs into a contiguous 2MB vaddr range and
>>> perform split on that range.
>>
>> I'm afraid I am missing the "why".
>>
>> I would have thought that a "split_pte_mapped_thp" test would want to pte-map THPs
>> to the see if they can be split.
>>
>> Why is the mremap required? IOW, what exactly is the test trying to test that
>> exceeds "split_pte_mapped_thp" ?
> 
> IMHO, it is an interesting test case for splitting a THP when only a subpage
> is mapped into a vaddr range and in a contiguous vaddr each page comes from
> different THPs.

Right. Slightly similar to just MAV_DONTNEED'ing the other PTEs and trying to
split the bigger range.

Of course, if you involve more mremap, the RMAP logic of installing migration
ptes will get stressed more.

So yes, there are various ways on how to stress the RMAP walk when splitting.

> The mprotect test case you are mentioning would still have all
> subpages mapped by contiguous vaddrs.

Right, it would not stress RMAP as much.

> 
> But if you think both are just testing PTE-mapped THPs, feel free to replace the
> existing one with the mprotect test case. In addition, is_backed_by_folio()
> can be reverted back to its prior version, since it no longer needs to handle
> the case where subpages from different THPs can be mapped into a vaddr range.

Oh, the is_backed_by_folio() change is actually really valuable.


I think I was confused by the implementation that works on a single virtual address
range with multiple different variables, questioning why we mremap at all.

I tried cleaning up that test myself and ended up with the following (it
escalated a bit). If that looks cleaner to you as well, I can submit that as a
patch.

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 10ae65ea032f6..aa0f0502efa06 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -390,67 +390,88 @@ static void split_pmd_thp_to_order(int order)
  
  static void split_pte_mapped_thp(void)
  {
-	char *one_page, *pte_mapped, *pte_mapped2;
-	size_t len = 4 * pmd_pagesize;
-	uint64_t thp_size;
+	const size_t nr_thps = 4;
+	const size_t thp_area_size = nr_thps * pmd_pagesize;
+	const size_t page_area_size = nr_thps * pagesize;
+	char *thp_area, *page_area = NULL, *tmp;
  	size_t i;
  
-	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
+	thp_area = mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PROT_WRITE,
  			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (one_page == MAP_FAILED)
-		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
+	if (thp_area == MAP_FAILED) {
+		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
+		goto out;
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
+	 * To challenge spitting code, we will mremap page[x] of the
+	 * thp[x] into a smaller area, and trigger the split from that
+	 * smaller area. This will end up replacing the PMD mappings in
+	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
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
+		if (is_backed_by_folio(&page_area[i], 0, pagemap_fd, kpageflags_fd))
+			continue;
+		ksft_test_result_fail("THP %zu not split\n", i);
+	}
  
  	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
-	munmap(one_page, len);
+out:
+	munmap(thp_area, thp_area_size);
+	if (page_area)
+		munmap(page_area, page_area_size);
  }
  
  static void split_file_backed_thp(int order)
-- 
2.50.1


-- 
Cheers

David / dhildenb


