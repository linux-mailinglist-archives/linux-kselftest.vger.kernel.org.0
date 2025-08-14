Return-Path: <linux-kselftest+bounces-38952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD006B260AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 11:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50DE9E2C49
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A32EA466;
	Thu, 14 Aug 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQa0IPhI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A22EA160;
	Thu, 14 Aug 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163011; cv=none; b=K6y9TQ37JRgab+LUsgGG5j37nJBulw24N6AYdYnP0oqCu+ySAIFx+8Ns68Vv/CINGGIkhySJuscLqE6L1SqR9k9H2tQRB0koyD9V1kRD8eQ3BqXQLOA6Stvrwb7D9fh0Mh2vNol7/DNsYrwcn4UachpjH7XWW7heiU1dQ++WBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163011; c=relaxed/simple;
	bh=4hKo60OOYdhk6IKRvFRlLisspZF1UtpsaSscie29dyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=st6KiStzwEMz44mX7cETDYFMILSzA7b1Qzaok7EQ58mmT58T5LIak062AKGEkBrJgJpWg9UzQQOk64KubRj+PEf4T7K9cjmylMM0JTdBpn+J3gv8qHw4IPH7SE6LfklBS825fQh00hbKBSuM0SgksaPtLhk5PgnR6O0En/NKDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQa0IPhI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b656159so1168847a12.1;
        Thu, 14 Aug 2025 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755163008; x=1755767808; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maL8ja7snbyxSg/aB0udz/2XPVl8dYyS2NvjcHhRBsU=;
        b=TQa0IPhIR3TrWxss+tVQgjRfMp2bEk+6jJ08tcTIS4KD/tr4cZe3wnfaH3W1+t/VRH
         ZNfbwNURh2BGbmYFsw+A4Rfr629nDUMuLKPmdDfy5Gban7XbHsv1xuMKseARHPDRe41D
         oALTl7TIDOgqQjQrLlJ83ASaVLOgbKgHJUq5QUUez5zx3AmT6tlD6qdevYmUDBwsD1Dp
         VB037lC3p8CSaLXbIL8cTadmcK3lqpGFAGT+n7X93spCmNXkLLvrOK94fdQxq+evL+oj
         Wc/kUUGDgKaCLEQN76TRV318NFeYJsKjhB4XLVCaOhlfyYsIPooQ0QgASi5YwkwunBte
         53ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163008; x=1755767808;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=maL8ja7snbyxSg/aB0udz/2XPVl8dYyS2NvjcHhRBsU=;
        b=hzxAGYIVlFT0fKX5NvqAJrsAn407zgk/SL2J2Wip7M33UXR2HdR5ebacembPBCE4eW
         k8cttYSVOW3nB/xZGT75X0D99I8Wj1BWXMhj9EocHKakPyuL1SEtz+Sl1baTQwhjxFQR
         oqCHlM6oNM8X5cP9Yx1pAENY9K7NPC3b6QSJ8hchQSsPnnfTtKi4OuO5HIEje5GgNQif
         wuBY6V7TpXAYqU1OQ4eUkAFweV8BAH5v/7gqOg2V1yAxzUBwK3JGXmNlV4zL5ebdJssf
         +mGRVkmaUUUrBnNtVOWRCJu6QYUKMzn/r5ZkPaYV8WZTgy/wVqiB2gkXl6s5+qTObJ6Z
         ae8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcYYXs7y2InoOrl0/lARGkYF2YKdb8J3+Ryl2LogvLv6sptUQA/5DPR3qxfPoM/c5e5W/QB5Y00DWx7VA=@vger.kernel.org, AJvYcCVYmf+oUdPjFW+/WhL/ukfYAG4/iV3Yku8prK+RnYAYRYhC/Njdoi2FuAkm61S7gTBbrtoWqLKNlIUfmr6qHN6S@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvz1h7etcJuqqgY1mM3/9ZzNx8cIAfYS9FHfqaxpGWYv+FP823
	OaKZ7T56JGBcLv3dmQi2e5IUXNeeKEw2vSCexnrH16Ckjrl8PczJmoPw
X-Gm-Gg: ASbGncvgf7xZlDmrsVbSTiMMa0KZk4N45I18fJHy/GCtb+Q49f+31+Tf2xCgJveHkGV
	y2QDJ7QAF0dHG2ImUSWRzTxZ7EkfrFDrj5Zi18pk2uECaRq4itgSj+fNongBEeXwgojPI2tJ87n
	kvSQdQgJsJwjmej+xXHdl+hmoCE1DVBkDTT+Q/kdBFVWJwVXjE1ahqVw+47dnsCsMRPrlxbaa5H
	J3itY0N8javO9UvHoFktt7dub2d/Az+Mje094P9vBGTwQoLpyoU41AAZUzHo6PEd8UAAX6ftvyW
	9Lprwd6xsqrRw6VZIQUUAHCRDFfoZAnVU/LAM2eMrXkkxGMsHEHZHLJSjHltD0Cwovwx4AxQ5Wx
	c8LwNLodYmSrl4eH/R0t0zw==
X-Google-Smtp-Source: AGHT+IE13oXUtnMs/Hs8gStTap5qVhOyy5FFDOfkTObdSMHP/qfsbCsjE7ChNeDnKH/AZiw3TDdy+Q==
X-Received: by 2002:a05:6402:90c:b0:618:2011:cad4 with SMTP id 4fb4d7f45d1cf-6188b92f8camr2177926a12.15.1755163007905;
        Thu, 14 Aug 2025 02:16:47 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f245c1sm23289384a12.22.2025.08.14.02.16.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Aug 2025 02:16:47 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:16:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>, g@master.smtp.subspace.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/4] selftests/mm: check after-split folio orders in
 split_huge_page_test.
Message-ID: <20250814091647.6prozsywma7qlugm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250812155512.926011-1-ziy@nvidia.com>
 <20250812155512.926011-5-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812155512.926011-5-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 12, 2025 at 11:55:12AM -0400, Zi Yan wrote:
>Instead of just checking the existence of PMD folios before and after folio
>split tests, use check_folio_orders() to check after-split folio orders.
>
>The following tests are not changed:
>1. split_pte_mapped_thp: the test already uses kpageflags to check;
>2. split_file_backed_thp: no vaddr available.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>---
> .../selftests/mm/split_huge_page_test.c       | 85 +++++++++++++------
> 1 file changed, 61 insertions(+), 24 deletions(-)
>
>diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>index 3aaf783f339f..1ea2c7f22962 100644
>--- a/tools/testing/selftests/mm/split_huge_page_test.c
>+++ b/tools/testing/selftests/mm/split_huge_page_test.c
>@@ -26,6 +26,7 @@ uint64_t pagesize;
> unsigned int pageshift;
> uint64_t pmd_pagesize;
> unsigned int pmd_order;
>+int *expected_orders;
> 
> #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
> #define SMAP_PATH "/proc/self/smaps"
>@@ -37,6 +38,11 @@ unsigned int pmd_order;
> 
> #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
> 
>+const char *pagemap_proc = "/proc/self/pagemap";
>+const char *kpageflags_proc = "/proc/kpageflags";
>+int pagemap_fd;
>+int kpageflags_fd;
>+
> int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kpageflags_fd)
> {
> 	unsigned long pfn_head;
>@@ -49,18 +55,21 @@ int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kpageflags_fd
> 
> 	pfn = pagemap_get_pfn(pagemap_fd, vaddr);
> 
>+	/* non present page */
> 	if (pfn == -1UL)
> 		return 0;
> 
> 	if (get_pfn_flags(pfn, kpageflags_fd, &pfn_flags))
> 		return 0;
> 
>+	/* check for order-0 pages */
> 	if (!order) {
> 		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
> 			return 0;
> 		return 1;
> 	}
> 
>+	/* non THP folio */
> 	if (!(pfn_flags & KPF_THP))
> 		return 0;
> 
>@@ -69,9 +78,11 @@ int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kpageflags_fd
> 	if (get_pfn_flags(pfn_head, kpageflags_fd, &pfn_flags))
> 		return 0;
> 
>+	/* head PFN has no compound_head flag set */
> 	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
> 		return 0;
> 
>+	/* check all tail PFN flags */
> 	for (i = 1; i < (1UL << order) - 1; i++) {
> 		if (get_pfn_flags(pfn_head + i, kpageflags_fd, &pfn_flags))
> 			return 0;

The comment in is_backed_by_folio() is more proper to be in previous patch?

>@@ -198,6 +209,12 @@ void split_pmd_thp_to_order(int order)
> 		if (one_page[i] != (char)i)
> 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
> 
>+	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
>+	expected_orders[order] = 4 << (pmd_order - order);
>+
>+	if (check_folio_orders(one_page, len, pagemap_fd, kpageflags_fd,
>+			       expected_orders, (pmd_order + 1)))
>+		ksft_exit_fail_msg("Unexpected THP split\n");
> 
> 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
> 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
>@@ -212,22 +229,6 @@ void split_pte_mapped_thp(void)
> 	size_t len = 4 * pmd_pagesize;
> 	uint64_t thp_size;
> 	size_t i;
>-	const char *pagemap_template = "/proc/%d/pagemap";
>-	const char *kpageflags_proc = "/proc/kpageflags";
>-	char pagemap_proc[255];
>-	int pagemap_fd;
>-	int kpageflags_fd;
>-
>-	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0)
>-		ksft_exit_fail_msg("get pagemap proc error: %s\n", strerror(errno));
>-
>-	pagemap_fd = open(pagemap_proc, O_RDONLY);
>-	if (pagemap_fd == -1)
>-		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
>-
>-	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
>-	if (kpageflags_fd == -1)
>-		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
> 
> 	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
> 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>@@ -285,8 +286,6 @@ void split_pte_mapped_thp(void)
> 
> 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
> 	munmap(one_page, len);
>-	close(pagemap_fd);
>-	close(kpageflags_fd);
> }
> 
> void split_file_backed_thp(int order)
>@@ -489,6 +488,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
> 		int order, int offset)
> {
> 	int fd;
>+	char *split_addr;
> 	char *addr;
> 	size_t i;
> 	char testfile[INPUT_MAX];
>@@ -502,14 +502,27 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
> 	err = create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
> 	if (err)
> 		return;
>+
> 	err = 0;
> 
>-	if (offset == -1)
>-		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
>-			      (uint64_t)addr + fd_size, order);
>-	else
>-		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
>-			      (uint64_t)addr + fd_size, order, offset);
>+	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));

I am not familiar with split, you change it to split on each pmd_pagesize from
4 pmd_pagesize. Is there any difference?

>+	if (offset == -1) {
>+		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
>+			write_debugfs(PID_FMT, getpid(), (uint64_t)split_addr,
>+				      (uint64_t)split_addr + pagesize, order);

                                                ^--- here should be vaddr_end

Curious why not (uint64_t)split_addr + pmd_pagesize?

>+
>+		expected_orders[order] = fd_size / (pagesize << order);
>+	} else {
>+		int times = fd_size / pmd_pagesize;
>+
>+		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
>+			write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)split_addr,
>+				      (uint64_t)split_addr + pagesize, order, offset);

As above.

>+
>+		for (i = order + 1; i < pmd_order; i++)
>+			expected_orders[i] = times;
>+		expected_orders[order] = 2 * times;
>+	}
> 
> 	for (i = 0; i < fd_size; i++)
> 		if (*(addr + i) != (char)i) {
>@@ -518,6 +531,13 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
> 			goto out;
> 		}
> 
>+	if (check_folio_orders(addr, fd_size, pagemap_fd, kpageflags_fd,
>+			       expected_orders, (pmd_order + 1))) {
>+		ksft_print_msg("Unexpected THP split\n");
>+		err = 1;
>+		goto out;
>+	}
>+
> 	if (!check_huge_file(addr, 0, pmd_pagesize)) {
> 		ksft_print_msg("Still FilePmdMapped not split\n");
> 		err = EXIT_FAILURE;
>@@ -569,9 +589,22 @@ int main(int argc, char **argv)
> 
> 	nr_pages = pmd_pagesize / pagesize;
> 	pmd_order = GET_ORDER(nr_pages);
>+
>+	expected_orders = (int *)malloc(sizeof(int) * (pmd_order + 1));
>+	if (!expected_orders)
>+		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>+
> 	tests = 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - 1) * 4 + 2;
> 	ksft_set_plan(tests);
> 
>+	pagemap_fd = open(pagemap_proc, O_RDONLY);
>+	if (pagemap_fd == -1)
>+		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
>+
>+	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
>+	if (kpageflags_fd == -1)
>+		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
>+
> 	fd_size = 2 * pmd_pagesize;
> 
> 	split_pmd_zero_pages();
>@@ -596,6 +629,10 @@ int main(int argc, char **argv)
> 			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
> 	cleanup_thp_fs(fs_loc, created_tmp);
> 
>+	close(pagemap_fd);
>+	close(kpageflags_fd);
>+	free(expected_orders);
>+
> 	ksft_finished();
> 
> 	return 0;
>-- 
>2.47.2

-- 
Wei Yang
Help you, Help me

