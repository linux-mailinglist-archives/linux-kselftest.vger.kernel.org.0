Return-Path: <linux-kselftest+bounces-38912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17EFB255BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 23:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE75172208C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 21:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36E3009E0;
	Wed, 13 Aug 2025 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7wa5hKn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915703009D1;
	Wed, 13 Aug 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121277; cv=none; b=r3Vubi+ASwtH2QPSaEvUo62f5Y8j4JtQS8Bwn/z97/IBZgjMNrXyi11pwCbf/JeAPHJsZjIwrBkm+naFSFTfsvECnA3ETANyrNF/bnGUQwF9RMHVCJxLbUdnvMj3P/Nl1piqDEC6k8LABsuG9q7G7t93jnPoaulu63ClIcN5bhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121277; c=relaxed/simple;
	bh=+beRL9pekUCgXaNNPhQ6lnwnrHCXUVj5tTp5O8otNWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOOVdZGmQygiUACCicgKDpirdPnJ7StQkp5YGm09trPtHoU+J6N05lKdiy+zTbv8tySY+4s6Yjkh7KwXBmj+E2FHyRX/uNxmrcewQNrkvQrchmDT3JQIoAAFyktXpmEDRX1heYNLl750YmQ5Ex2GFWIQfkliOYPnOEu0DJQq1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7wa5hKn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7a2befdso47470066b.2;
        Wed, 13 Aug 2025 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755121273; x=1755726073; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw6h3XbW9SZjmv3VMhGxMmuRXeauHMpSfMMYghs+t1M=;
        b=b7wa5hKnmTxUKmRh7C0XWbfmxywEMq0zqr1t4Zk5V09wyN0wUi6wabJZJ0HbHlml6w
         GnjEwID4GgN5WMSYwDqKPjZtpp8V4fZDnHYeLR5czIKIchPCfSk+C9fsE7nzC7hqTgy1
         IuComqYhJOarf86CzSiszE4Km17Ccr+NlTjzZcVI3J9NhLGfWTbP6GZiRAjNM584EZzN
         zd3re6nCX+8BbZ059DRE52IGRvbatVYS/JXP8y6NpdYy6uWDmci5HTUkdlZvsYebFBQg
         yE4dq5fg4CjqOytlFc1DYz2GUzlA6Ia0s5Wf0eqKb5bNEiUXVUrxKNXanb5OxF0rQJkY
         XdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121273; x=1755726073;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xw6h3XbW9SZjmv3VMhGxMmuRXeauHMpSfMMYghs+t1M=;
        b=F0hmyo6RvLVkfWLJT8YJKsZST57RLGv0Ku3N6atxrMewkNxddfJ5nzehBPzTpfuXl/
         HEZu97bVVuZlnRdqZ29hR+SvCOpeY0JQbIt18c/4ZwPr7gZnqvrfP745TNlfFMA0nlzG
         btjetbu0w44m11vleNQ8ttao4nADx+sxI52EAbm3BtsmaDuXiqqrSNDqBo2+FWZ2habM
         iBYyQ8yOV7LNMhj0ADeUpAKLzF7DA5gIt1FeH8zhqvkOaVWTpsjUSR4AAgKZuJkg/mP1
         rGc40LHZLGCs+PhbEc/xG5onf8I9rx/rNND3c+YXYNbJWedOsRv5AwXgkk0TqJB8LNW+
         0LGw==
X-Forwarded-Encrypted: i=1; AJvYcCWwswxebR51PvMbgetLLQXIKQpUn29Ly889HhpbqhglERWLC2Mw22OS/O8uRVrcOwLiG8crIMid3EwlP2k=@vger.kernel.org, AJvYcCX+ixBoM3M/dZem7WPHOMS4MgKxii03J5GfLrT/K5iVv+INKrPqiBD3yO6upzxArgpPI2zZuR+kYTpgVPH2c3R9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eFEEiE4Ed6HdWgrZP99HRzHtNxizL6GI/PMYPrUKvjGPAyjc
	r0QiQEMlQqGi3uptGukz2QZy5qQW8ZTf+H7pzOZ6gieUMEcZ+LhVvUrM
X-Gm-Gg: ASbGnctJtHOvdbpWOuimwwh0vLxyVwbfqQGilc7pwzSNjmWfNDnGrgN0o1r3Tf4GsDn
	2z//zCF+UQthUMOMTzzhBQb5n7Lq2LDi7GjmLlwZB1w3PMvWVJ+331yngYyYD4hO12sj+HNznX1
	Qgifj/yTPdirBP7vNNpyEOwp+4HPfQwraAWIdcgXkN0vXIxTRLhcsPL+CJYmgNA29IxRUsKGWPP
	kITV5Si4vi/KbX0dzjJQgRddLwnwSk0aHCMocMB6mv4NGb3QEQOuLBEqL5A5RTS/gJLE/yMZjv7
	X1nJfiiySjFB2IMI4z/bX5F8a5nUgCesiUT8PlRb1s5JU1tyH60sW9iR2Mir5xQaI8pih0n+lAo
	Hu/Qj/jrt8IlF4Ul5UHX61Q==
X-Google-Smtp-Source: AGHT+IGEVnxz9gbuq2Cd6iX98Y9+6sIOZ0bQIY85rrbIp58Ufb1dYCYBY4a3jiTNaFQchFh0O+qVCA==
X-Received: by 2002:a17:906:c152:b0:af9:610e:343e with SMTP id a640c23a62f3a-afcb93988f4mr55549066b.11.1755121273407;
        Wed, 13 Aug 2025 14:41:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076409sm2480136966b.12.2025.08.13.14.41.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Aug 2025 14:41:13 -0700 (PDT)
Date: Wed, 13 Aug 2025 21:41:12 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
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
Subject: Re: [PATCH v3 3/4] selftests/mm: reimplement is_backed_by_thp() with
 more precise check
Message-ID: <20250813214112.tarr5rbamtc6cmie@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250812155512.926011-1-ziy@nvidia.com>
 <20250812155512.926011-4-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812155512.926011-4-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 12, 2025 at 11:55:11AM -0400, Zi Yan wrote:
>and rename it to is_backed_by_folio().
>
>is_backed_by_folio() checks if the given vaddr is backed a folio with
>a given order. It does so by:
>1. getting the pfn of the vaddr;
>2. checking kpageflags of the pfn;
>
>if order is greater than 0:
>3. checking kpageflags of the head pfn;
>4. checking kpageflags of all tail pfns.
>
>pmd_order is added to split_huge_page_test.c and replaces max_order.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>---
> .../selftests/mm/split_huge_page_test.c       | 67 +++++++++++++------
> tools/testing/selftests/mm/vm_util.c          |  2 +-
> tools/testing/selftests/mm/vm_util.h          |  1 +
> 3 files changed, 48 insertions(+), 22 deletions(-)
>
>diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>index 63ac82f0b9e0..3aaf783f339f 100644
>--- a/tools/testing/selftests/mm/split_huge_page_test.c
>+++ b/tools/testing/selftests/mm/split_huge_page_test.c
>@@ -25,6 +25,7 @@
> uint64_t pagesize;
> unsigned int pageshift;
> uint64_t pmd_pagesize;
>+unsigned int pmd_order;
> 
> #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
> #define SMAP_PATH "/proc/self/smaps"
>@@ -36,23 +37,48 @@ uint64_t pmd_pagesize;
> 
> #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
> 
>-int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
>+int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kpageflags_fd)
> {
>-	uint64_t paddr;
>-	uint64_t page_flags;
>+	unsigned long pfn_head;
>+	uint64_t pfn_flags;
>+	unsigned long pfn;
>+	unsigned long i;
> 
>-	if (pagemap_file) {
>-		pread(pagemap_file, &paddr, sizeof(paddr),
>-			((long)vaddr >> pageshift) * sizeof(paddr));
>+	if (!pagemap_fd || !kpageflags_fd)
>+		return 0;

The same in patch 2.

> 
>-		if (kpageflags_file) {
>-			pread(kpageflags_file, &page_flags, sizeof(page_flags),
>-				PAGEMAP_PFN(paddr) * sizeof(page_flags));
>+	pfn = pagemap_get_pfn(pagemap_fd, vaddr);
> 
>-			return !!(page_flags & KPF_THP);
>-		}
>+	if (pfn == -1UL)
>+		return 0;
>+
>+	if (get_pfn_flags(pfn, kpageflags_fd, &pfn_flags))
>+		return 0;
>+
>+	if (!order) {
>+		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
>+			return 0;
>+		return 1;
> 	}
>-	return 0;
>+
>+	if (!(pfn_flags & KPF_THP))
>+		return 0;
>+
>+	pfn_head = pfn & ~((1 << order) - 1);
>+
>+	if (get_pfn_flags(pfn_head, kpageflags_fd, &pfn_flags))
>+		return 0;
>+
>+	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
>+		return 0;
>+
>+	for (i = 1; i < (1UL << order) - 1; i++) {

Do we miss the last tail?

>+		if (get_pfn_flags(pfn_head + i, kpageflags_fd, &pfn_flags))
>+			return 0;
>+		if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)))
>+			return 0;
>+	}

If this folio is larger than order, would it still return 1?

>+	return 1;
> }
> 
> static void write_file(const char *path, const char *buf, size_t buflen)
>@@ -233,7 +259,7 @@ void split_pte_mapped_thp(void)
> 	thp_size = 0;
> 	for (i = 0; i < pagesize * 4; i++)
> 		if (i % pagesize == 0 &&
>-		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
>+		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
> 			thp_size++;
> 
> 	if (thp_size != 4)
>@@ -250,7 +276,7 @@ void split_pte_mapped_thp(void)
> 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
> 
> 		if (i % pagesize == 0 &&
>-		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
>+		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
> 			thp_size++;
> 	}
> 
>@@ -522,7 +548,6 @@ int main(int argc, char **argv)
> 	const char *fs_loc;
> 	bool created_tmp;
> 	int offset;
>-	unsigned int max_order;
> 	unsigned int nr_pages;
> 	unsigned int tests;
> 
>@@ -543,28 +568,28 @@ int main(int argc, char **argv)
> 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
> 
> 	nr_pages = pmd_pagesize / pagesize;
>-	max_order = GET_ORDER(nr_pages);
>-	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
>+	pmd_order = GET_ORDER(nr_pages);
>+	tests = 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - 1) * 4 + 2;
> 	ksft_set_plan(tests);
> 
> 	fd_size = 2 * pmd_pagesize;
> 
> 	split_pmd_zero_pages();
> 
>-	for (i = 0; i < max_order; i++)
>+	for (i = 0; i < pmd_order; i++)
> 		if (i != 1)
> 			split_pmd_thp_to_order(i);
> 
> 	split_pte_mapped_thp();
>-	for (i = 0; i < max_order; i++)
>+	for (i = 0; i < pmd_order; i++)
> 		split_file_backed_thp(i);
> 
> 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
> 			&fs_loc);
>-	for (i = max_order - 1; i >= 0; i--)
>+	for (i = pmd_order - 1; i >= 0; i--)
> 		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
> 
>-	for (i = 0; i < max_order; i++)
>+	for (i = 0; i < pmd_order; i++)
> 		for (offset = 0;
> 		     offset < nr_pages;
> 		     offset += MAX(nr_pages / 4, 1 << i))
>diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
>index 4d952d1bc96d..193ba1a1a3cc 100644
>--- a/tools/testing/selftests/mm/vm_util.c
>+++ b/tools/testing/selftests/mm/vm_util.c
>@@ -338,7 +338,7 @@ int detect_hugetlb_page_sizes(size_t sizes[], int max)
> 	return count;
> }
> 
>-static int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags)
>+int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags)
> {
> 	size_t count;
> 
>diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
>index 02e3f1e7065b..148b792cff0f 100644
>--- a/tools/testing/selftests/mm/vm_util.h
>+++ b/tools/testing/selftests/mm/vm_util.h
>@@ -92,6 +92,7 @@ unsigned long default_huge_page_size(void);
> int detect_hugetlb_page_sizes(size_t sizes[], int max);
> int check_folio_orders(char *vaddr_start, size_t len, int pagemap_file,
> 			int kpageflags_file, int orders[], int nr_orders);
>+int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags);
> 
> int uffd_register(int uffd, void *addr, uint64_t len,
> 		  bool miss, bool wp, bool minor);
>-- 
>2.47.2

-- 
Wei Yang
Help you, Help me

