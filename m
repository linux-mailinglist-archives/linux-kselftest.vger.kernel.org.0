Return-Path: <linux-kselftest+bounces-11289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2CF8FE75F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC7BB25AE7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6E2196432;
	Thu,  6 Jun 2024 13:14:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5B196428;
	Thu,  6 Jun 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679687; cv=none; b=mQcb3FCIMmAqLwJcuEnwvLcJJAIAyMuJjaVh3DDKTD7cnH4E3ZfehahwNzul9vqoYnJ4Hq2m4Dr3L2sC+FV9tzleVfHU8P3pOkHF0W0cGulPZcj50Oni8/NT1xT1Mh3b4vDsvTzHGtL1v4gm9wJQ94331PM8FMft3XoADUG+M2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679687; c=relaxed/simple;
	bh=gp3sNoq6XZoTI5NVdrBYpz34TiddWLflixAGr4p22MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gr4sOaspVmmmzo01Hpz+0CSbsIMvpvE6lN95Aoqe79lkU90Zz1ytNFAhM7xw+xISNg0faUfK6za4fTKkI4MIyHts+uevmKmAtylIvuLCYw2bq79L3gMGwTEAZp/5b0cXV6NnEJK2ViVAeaCZChb1WBW9i48o20QD/mUzwQlqh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vw4YX4BqXz9scC;
	Thu,  6 Jun 2024 15:14:40 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: donettom@linux.ibm.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	ritesh.list@gmail.com,
	rppt@kernel.org,
	shuah@kernel.org,
	songmuchun@bytedance.com,
	tonyb@cybernetics.com,
	willy@infradead.org
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked during __bio_release_pages()
Date: Thu,  6 Jun 2024 13:14:29 +0000
Message-ID: <20240606131436.592793-1-p.raghav@samsung.com>
In-Reply-To: <20240604132801.23377-1-donettom@linux.ibm.com>
References: <20240604132801.23377-1-donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


> +void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
> +{
> +	int fd;
> +	char *buffer =  NULL;
> +	char *orig_buffer = NULL;
> +	size_t h_pagesize = 0;
> +	size_t writesize;
> +	int free_hpage_b = 0;
> +	int free_hpage_a = 0;
> +
> +	writesize = end_off - start_off;
> +
> +	/* Get the default huge page size */
> +	h_pagesize = default_huge_page_size();
> +	if (!h_pagesize)
> +		ksft_exit_fail_msg("Unable to determine huge page size\n");
> +
> +	/* Open the file to DIO */
> +	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT);

I encountered a build error as follows in NixOS:

In file included from /nix/store/fwh4fxd747m0py3ib3s5abamia9nrf90-glibc-2.39-52-dev/include/fcntl.h:342,
                 from hugetlb_dio.c:15:
In function ‘open’,
    inlined from ‘run_dio_using_hugetlb’ at hugetlb_dio.c:41:7:
/nix/store/fwh4fxd747m0py3ib3s5abamia9nrf90-glibc-2.39-52-dev/include/bits/fcntl2.h:50:11: error: call to ‘__open_missing_mode’ declared with attribute error: open with O_CREAT or O_TMPFILE in second argument needs 3 arguments
   50 |           __open_missing_mode ();


I saw a commit that fixed similar issues with open syscall before:
8b65ef5ad486 ("selftests/mm: Fix build with _FORTIFY_SOURCE")

So something like this should fix the issue?

-       fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT);
+       fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);

> +	if (fd < 0)
> +		ksft_exit_fail_msg("Error opening file");
> +


