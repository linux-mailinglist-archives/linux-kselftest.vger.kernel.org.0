Return-Path: <linux-kselftest+bounces-38236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDB8B19E88
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E77178E06
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990DA239E79;
	Mon,  4 Aug 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J39PZCBi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C01C6FF5;
	Mon,  4 Aug 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298706; cv=none; b=WDDI10spvHb2YqdLizoKlMEh7sWD6k21DVZbGZ+7AcCrKItzvH7LOBL3YyqmC4sDD3NqureTU3tZWKHDdA/muu8FzfgQh+ZSzz3idqR1ECYGs6/DR53+xaE4+hJCKRnDY68QlrQkhohM5z64yX+WBPqp+Py15s0vsYtzYUTUQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298706; c=relaxed/simple;
	bh=UF5gVpXP9Ubm1gTeYZJatWudtPvnSI23l2ki/Kcf0R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8sb7JguvmTxlmqvHTYtuVNzF334219uByPu+prrrEbqjJ3OyB+XwpVDgwDiFs/qQ0wl4Q9PU/V9BUC2hm97mHs14beiVh4lWvjiOQDAzNRtR2CO3khfhzaw3rRzSFxsfQ0RcrTxEsn3nCPJVTC8GQ/PtYAVW6h94w4zEvPzZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J39PZCBi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so9178180a12.0;
        Mon, 04 Aug 2025 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754298703; x=1754903503; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pugdPG7uA4O/On86pd0XfQDtWdJcBWVZDEqtuwJC78Q=;
        b=J39PZCBiMR2L+lhMBcwUar9bFXqZuzi+kPv8BV5XCoXRnWelkCSVwF23tMLpINRUtW
         Ba1RJY724vxl6b328ZUH7Sj5HSyNAo0B89xuixeECCk0wkTDWyg/zCZDOhelzsbxzG5G
         +my/NeFmPPsTGtMK8mzI5x/qCjJsxyeKL1go1U0PzfqrUYRvGmn+XuHh5TbfuU+kKfCH
         8EU6bXWa7LWz2uMU7lzlhVTRHOKnKfOcy8CT3YLqxvfJ6kWME1d2O3DHPMMmxQsGYdNH
         KQRCutE2jl0xVsUDUMCFiUaC2St1SEdKDk62vCQbl9VXUd1ZYnIuVdTouYEf4jVcJPiQ
         Eamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298703; x=1754903503;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pugdPG7uA4O/On86pd0XfQDtWdJcBWVZDEqtuwJC78Q=;
        b=l469RNxQuwmPNIrMEJD17muLXjbvfv0hu8m42GrztiUocxpqX7GyJOlPDez1fcJ10S
         tQLffD+wUJLCYnPdCwTYQXMCfENov3hg60viwBN9BF/1FR7m3WQkIMyv6cntDti1LGWB
         OGgrG4DH8b70ZU/S7Z3/iIB6mKnP6teaQxUNnAbprpaVIs+QuaPiIFmTtpLZV1ExGLUs
         G21UZ1BBwv2sM0CJ0NBYkTBbXmenpp4wci7VcsH+yzqw0H24A+FMbo15QLzI0fieRjFG
         uZzCPOXrGEygn49FINrs+cBOuQj6VZ05p0BzB/l962Oe1csxU4WhWxyRdKh9HGA/FbMD
         voSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZxZHTLTSWR7TawFdWFOCMKpvxF8y7JnkGRjMSWmAKtJQn/pCdjylCCLPZADWg68SlTt/AZyG+7A3e8OF9Fzkn@vger.kernel.org, AJvYcCWR+5vWlerD4Vox4ufHuj0Aw49u4MdlRHahAH8mH+k1Tv0+e8FsHCCT2fXN+9/UVNmt68U9qIzbbdPLzFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbvwT5AXtIlziB9YH/f0EPRWtyllRraxSXPwyoShWkUeL3fMS
	QhBIfWo0oa/HJR0HW7x7l4PZ7a48uaTeKstGtij0xJivJuMw8Fk8qIas
X-Gm-Gg: ASbGncsR/2bFfmVRWRj3l3M0PSF2EH+ATsp5yjagN3Fhvbb7e5O0kUhhdKfqx5iswul
	XqMFaqy9stvXlYSaeRAlQbE7TqJoa7M2cHt1FHmmXWWQekLIlroIoqQL4TDrRCZDmSIP/QYBm8M
	M83+on6OI12r/5MuxKYTmoSmWvpSJAd6PfGtoQ75booyEziJHJn6ZQUxAWz9+Xo0ujBfup3Z+s0
	EAbUSX95gmKNS8KgCQWkFDL13LtSIw/7pKLsbJNvvFQqdC6dzPdygHsZrsdSchP06GP3XuTAmZT
	6PAsCZ1gyWyElHLupnjitpvhJad285b750a5t70tXKbIDfI5Ab+iFZFNS+kMPgh4iDRtLa2AqRg
	ps1WCcx9Sn+0NrZWWoslb3nWdowqRd195bp9dcm1xUCk=
X-Google-Smtp-Source: AGHT+IHM3K4OZ+XP8yHHt8iGAEQo+9QHGcIwmPD9Lmbdp7R1ga5jUT96EJoH/t1FQUDctW0UjWXQkw==
X-Received: by 2002:a05:6402:2355:b0:615:3667:f4eb with SMTP id 4fb4d7f45d1cf-615e5dd9a53mr7855785a12.6.1754298702785;
        Mon, 04 Aug 2025 02:11:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911567fsm6396175a12.61.2025.08.04.02.11.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Aug 2025 02:11:42 -0700 (PDT)
Date: Mon, 4 Aug 2025 09:11:41 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v3 3/7] selftest/mm: Fix ksm_funtional_test failures
Message-ID: <20250804091141.ifwryfmgjepwrog4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
 <20250729053403.1071807-4-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729053403.1071807-4-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jul 29, 2025 at 11:03:59AM +0530, Aboorva Devarajan wrote:
>From: Donet Tom <donettom@linux.ibm.com>
>
>This patch fixed 2 issues.
>
>1) After fork() in test_prctl_fork, the child process uses the file
>descriptors from the parent process to read ksm_stat and
>ksm_merging_pages. This results in incorrect values being read (parent
>process ksm_stat and ksm_merging_pages will be read in child), causing
>the test to fail.
>
>This patch calls init_global_file_handles() in the child process to
>ensure that the current process's file descriptors are used to read
>ksm_stat and ksm_merging_pages.
>
>2) All tests currently call ksm_merge to trigger page merging.
>To ensure the system remains in a consistent state for subsequent
>tests, it is better to call ksm_unmerge during the test cleanup phase.
>
>In the test_prctl_fork test, after a fork(), reading ksm_merging_pages
>in the child process returns a non-zero value because a previous test
>performed a merge, and the child's memory state is inherited from the
>parent.
>
>Although the child process calls ksm_unmerge, the ksm_merging_pages
>counter in the parent is reset to zero, while the child's counter
>remains unchanged. This discrepancy causes the test to fail.
>
>To avoid this issue, each test should call ksm_unmerge during cleanup
>to ensure the counter is reset and the system is in a clean state for
>subsequent tests.
>
>execv argument is an array of pointers to null-terminated strings.
>In this patch we also added NULL in the execv argument.
>
>Fixes: 6c47de3be3a0 ("selftest/mm: ksm_functional_tests: extend test case for ksm fork/exec")
>Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>---
> tools/testing/selftests/mm/ksm_functional_tests.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
>index d8bd1911dfc0..996dc6645570 100644
>--- a/tools/testing/selftests/mm/ksm_functional_tests.c
>+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>@@ -46,6 +46,8 @@ static int ksm_use_zero_pages_fd;
> static int pagemap_fd;
> static size_t pagesize;
> 
>+static void init_global_file_handles(void);
>+
> static bool range_maps_duplicates(char *addr, unsigned long size)
> {
> 	unsigned long offs_a, offs_b, pfn_a, pfn_b;
>@@ -274,6 +276,7 @@ static void test_unmerge(void)
> 	ksft_test_result(!range_maps_duplicates(map, size),
> 			 "Pages were unmerged\n");
> unmap:
>+	ksm_unmerge();

In __mmap_and_merge_range(), we call ksm_unmerge(). Why this one not help?

Not very familiar with ksm stuff. Would you mind giving more on how this fix
the failure you see?

> 	munmap(map, size);
> }
> 
>@@ -338,6 +341,7 @@ static void test_unmerge_zero_pages(void)
> 	ksft_test_result(!range_maps_duplicates(map, size),
> 			"KSM zero pages were unmerged\n");
> unmap:
>+	ksm_unmerge();
> 	munmap(map, size);
> }
> 
>@@ -366,6 +370,7 @@ static void test_unmerge_discarded(void)
> 	ksft_test_result(!range_maps_duplicates(map, size),
> 			 "Pages were unmerged\n");
> unmap:
>+	ksm_unmerge();
> 	munmap(map, size);
> }
> 
>@@ -452,6 +457,7 @@ static void test_unmerge_uffd_wp(void)
> close_uffd:
> 	close(uffd);
> unmap:
>+	ksm_unmerge();
> 	munmap(map, size);
> }
> #endif
>@@ -515,6 +521,7 @@ static int test_child_ksm(void)
> 	else if (map == MAP_MERGE_SKIP)
> 		return -3;
> 
>+	ksm_unmerge();
> 	munmap(map, size);
> 	return 0;
> }
>@@ -548,6 +555,7 @@ static void test_prctl_fork(void)
> 
> 	child_pid = fork();
> 	if (!child_pid) {
>+		init_global_file_handles();

Would this leave fd in parent as orphan?

> 		exit(test_child_ksm());
> 	} else if (child_pid < 0) {
> 		ksft_test_result_fail("fork() failed\n");
>@@ -595,7 +603,7 @@ static void test_prctl_fork_exec(void)
> 		return;
> 	} else if (child_pid == 0) {
> 		char *prg_name = "./ksm_functional_tests";
>-		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME };
>+		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME, NULL };
> 
> 		execv(prg_name, argv_for_program);
> 		return;
>@@ -644,6 +652,7 @@ static void test_prctl_unmerge(void)
> 	ksft_test_result(!range_maps_duplicates(map, size),
> 			 "Pages were unmerged\n");
> unmap:
>+	ksm_unmerge();
> 	munmap(map, size);
> }
> 
>@@ -677,6 +686,7 @@ static void test_prot_none(void)
> 	ksft_test_result(!range_maps_duplicates(map, size),
> 			 "Pages were unmerged\n");
> unmap:
>+	ksm_unmerge();
> 	munmap(map, size);
> }
> 
>-- 
>2.47.1
>

-- 
Wei Yang
Help you, Help me

