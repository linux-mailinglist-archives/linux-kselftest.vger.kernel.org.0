Return-Path: <linux-kselftest+bounces-39151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD1B28E78
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 16:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2656D1C83C66
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18EA2C0F9D;
	Sat, 16 Aug 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwNKSU60"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D98462;
	Sat, 16 Aug 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755354693; cv=none; b=WrqjRLSur3rkbDaCFYg+qI8YaLgzpnx34YwRVY2xhl3ojwuiWqXbdm+vMut/RN3pNZOSERjo7/eabfGGNwqxBsQWNmhn1oMU3JgMry27/2vifwx8VJxczMbo8sgUSsPSPhIkbNIWcTk0IPhGuxiPKNBBCuJ6EnoVaCgZKS5Qu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755354693; c=relaxed/simple;
	bh=rTl8jCYiZiPGQRC+XEI6ofajhMKlPHjaTG9pBXNhA9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpTF/4Tgu3dItrYQoHJZpmtMLMtjRnvRbM84jv6Ih34C+qLK/W5Vpy1PxwS9AJKsiYuFiVgs7IsqsLui/nvW4WooiboCNATJkKOOSE80ECpNASKDeFxjS1GfLM7ukZNpM98cWehib9sZ03vg92/TQmnwwHjOfcb++sVZuit7Y2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwNKSU60; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a2befdso407215066b.2;
        Sat, 16 Aug 2025 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755354690; x=1755959490; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhSK0ty+ioZ0FDzNSGurp9JorLqfNJRkank5C8eSUoo=;
        b=dwNKSU60iX7FHfmpIBsoOwEuzAtBDG5dJcRb/rsSBdgEiQdH7kWziIXD6NjF4j9P1L
         XGtOnuXfO9anYR+MaaHxkquxMYTH4tyuHEC488yhGivJi3JZp5mZMogEkR0sNNy1qYk4
         QfPb0mOjNLZibwfJAJhQDgyGB1mf8lW+8A6QYyNQwA8EO97qIkDdw4l0UOsunWB4osEG
         z7inmQPbIbQYxHYuzBvBmmXHohP/CrY8g9bHFE7QfMbL4XIdhpcUaKZkfNHk7jBbbBhl
         a0zz+F7xPl18qkDv038mIhk2gkb7kTQvEBgL8gk2u58bT/Uf4iTA6OmBpccylI4LaTSB
         5Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755354690; x=1755959490;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhSK0ty+ioZ0FDzNSGurp9JorLqfNJRkank5C8eSUoo=;
        b=lqaMUGtuV25mnQHbtLwPA2+mdtTbHogF6u2MBjd33LLpz6JqnLD7Pe6hLAV3kKcvm1
         fSslhN6TEXn6MM5ykxyuBlGZMtkvrY+fqkgQnvpA/e0UcvNdImEUuHEDWVEXv/Hl7sTn
         u2PzFpsFU7eTry1aVBnlRJMIjebpgzbhqde3MoVPeWfB9jhjFmiAxfbJzrubR11TZo/F
         10f6g7pG5Wm4l/FHxHZhppez0y97HlYYjzGAURN+wQhjUq8EwkvmK1l8xB0epMX4dQUe
         gkrkrNNcZRvbqg9D7neHbF1551gxU5n2wy8n7MzrgIlS7tmm2+wNUOxlmZ7q8rfyN75s
         q9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUmUxZyO9B5oBe1SKjdMTaJNdIIRGL0NBBetRYCkgN6/fbY8aBKkXij0aeTUm+4oJyPtZ0aq5p+EOduCOM=@vger.kernel.org, AJvYcCWaIu8GKokxpVQC8D2rZ3U8XwbbIajAO6/3Q3jArujH6ImZMfljUZFJF5SWBrdYcWio7LI/492i46Q0HKCt/86s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LI4eStcTwrEz8JZ4pmLWf4gi7WsNjf2ivNaEYShLj376YH3k
	0yjDK+16tuPK31hRjW9N1FgDnMqGXTYWVpsIncawbMfq3qNo/Mv8zNi7
X-Gm-Gg: ASbGncsLGFerRb+qgcjj8Ux8YL4yGcflNEgFgMFaOkP9EDvggDPJxlURgmSWNASh7Ua
	+V3YGTpiTO2r08Zauonl68arQYZ+T2wXRWoZveMFNZLmWQCwUV/YMhj4zUuP3+urRAc3wWypODk
	t0LrIi1vHFWPJLBdshNXF+f0QpHm6tFIYY23h2oCG3iyaHcVgp1J+WXas4hnBF+GzJ9eBfFpgBm
	GoXfCBAC1Z1K6eGjwItJ5iKLBDqpHnTWFlHeqNTLCN3vusNrxJ2fl24dLYKYz612z2w7xVyPQ7N
	pIa1a5eAMMOw2UglT9b5Zv/TdEhhShvpxv/DYXYST8uB5dYH2LeAmtKzYuPutQiBcqBtw7HF5dV
	mGcRb4JZxyYjkvnxWZZME/btc2OZRwlrS
X-Google-Smtp-Source: AGHT+IE+hnbZgqLEo1vrSz2gfgfdwaN8B2FfhiHGFXOhrjksUt6d8A4An/LGiPxpjL+ETuSim/flxA==
X-Received: by 2002:a17:906:c103:b0:ae9:a1f1:2b7d with SMTP id a640c23a62f3a-afceacd0d01mr285486166b.17.1755354690189;
        Sat, 16 Aug 2025 07:31:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01168csm382021766b.91.2025.08.16.07.31.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Aug 2025 07:31:29 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:31:29 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v4 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
Message-ID: <20250816143129.u2rdwpwvfhsdptvx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
 <20250816040113.760010-5-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816040113.760010-5-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 16, 2025 at 09:31:10AM +0530, Aboorva Devarajan wrote:
>From: Donet Tom <donettom@linux.ibm.com>
>
>The split_huge_page_test fails on systems with a 64KB base page size.
>This is because the order of a 2MB huge page is different:
>
>On 64KB systems, the order is 5.
>
>On 4KB systems, it's 9.
>
>The test currently assumes a maximum huge page order of 9, which is only
>valid for 4KB base page systems. On systems with 64KB pages, attempting
>to split huge pages beyond their actual order (5) causes the test to fail.
>
>In this patch, we calculate the huge page order based on the system's base
>page size. With this change, the tests now run successfully on both 64KB
>and 4KB page size systems.
>
>Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for splitting THP tests")
>Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Reviewed-by: Dev Jain <dev.jain@arm.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

Nit below:

>---
> tools/testing/selftests/mm/cow.c              |  5 -----
> .../selftests/mm/split_huge_page_test.c       | 22 ++++++++++++-------
> tools/testing/selftests/mm/uffd-wp-mremap.c   |  5 -----
> tools/testing/selftests/mm/vm_util.h          |  5 +++++
> 4 files changed, 19 insertions(+), 18 deletions(-)
>
>diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>index 90ee5779662f..e742d9313798 100644
>--- a/tools/testing/selftests/mm/cow.c
>+++ b/tools/testing/selftests/mm/cow.c
>@@ -41,11 +41,6 @@ static size_t hugetlbsizes[10];
> static int gup_fd;
> static bool has_huge_zeropage;
> 
>-static int sz2ord(size_t size)
>-{
>-	return __builtin_ctzll(size / pagesize);
>-}
>-
> static int detect_thp_sizes(size_t sizes[], int max)
> {
> 	int count = 0;
>diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>index eadbeb820d71..7cbeaebc9d71 100644
>--- a/tools/testing/selftests/mm/split_huge_page_test.c
>+++ b/tools/testing/selftests/mm/split_huge_page_test.c
>@@ -523,6 +523,9 @@ int main(int argc, char **argv)
> 	const char *fs_loc;
> 	bool created_tmp;
> 	int offset;
>+	unsigned int max_order;
>+	unsigned int nr_pages;
>+	unsigned int tests;
> 
> 	ksft_print_header();
> 
>@@ -534,35 +537,38 @@ int main(int argc, char **argv)
> 	if (argc > 1)
> 		optional_xfs_path = argv[1];
> 
>-	ksft_set_plan(1+8+1+9+9+8*4+2);
>-
> 	pagesize = getpagesize();
> 	pageshift = ffs(pagesize) - 1;
> 	pmd_pagesize = read_pmd_pagesize();
> 	if (!pmd_pagesize)
> 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
> 
>+	nr_pages = pmd_pagesize / pagesize;
>+	max_order =  sz2ord(pmd_pagesize);
                    ^
		    extra space here

>+	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
>+	ksft_set_plan(tests);
>+
> 	fd_size = 2 * pmd_pagesize;
> 
> 	split_pmd_zero_pages();
> 

-- 
Wei Yang
Help you, Help me

