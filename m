Return-Path: <linux-kselftest+bounces-32728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35859AB09BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 07:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587871BA1F77
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5870F23C8BE;
	Fri,  9 May 2025 05:35:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC31FF5E3;
	Fri,  9 May 2025 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746768955; cv=none; b=MEh7Hoa5sAw2OMlnLLxr/tcOyftYHhjO6APxa6vafuhdKGxEK5nPC6PHCamaHdLtzvkHcKJs2Vhni8Qs630bTQwwKjE+rL3FJvTLhv5hYsSnpGf87sQBt78h5+w9lRbMUmLLtcgfhlp3+bEilpF3VmSRtIgWRXx2eYVQlp0qDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746768955; c=relaxed/simple;
	bh=q8tnmVg/VhXwK3bTsXqED8fAGwEd9hNQOcYH/UvILzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNAzLw7OZUxD6SlOKrNUerznzmSuKduHGkWpEYY5cN9QYdCiUN+9L42gBi515BvcxMp0MEnZVD+UqGRpiF63nGSlhxIhiYQryClJZ6xf1gKgjqv2EncW/KWjH7RrOv1zgnDVgrbkMtn5xBAk1wGu4u/tIutKJefYkhX0qvzl7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A090153B;
	Thu,  8 May 2025 22:35:41 -0700 (PDT)
Received: from [10.162.43.14] (K4MQJ0H1H2.blr.arm.com [10.162.43.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C5773F58B;
	Thu,  8 May 2025 22:35:48 -0700 (PDT)
Message-ID: <ecd0bc7e-8af5-40d6-b118-1604d2851f6b@arm.com>
Date: Fri, 9 May 2025 11:05:45 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250508222041.1647645-1-david@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250508222041.1647645-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/05/25 3:50 am, David Hildenbrand wrote:
> Let's test some basic functionality using /dev/mem. These tests will
> implicitly cover some PAT (Page Attribute Handling) handling on x86.
> 
> These tests will only run when /dev/mem access to the first two pages
> in physical address space is possible and allowed; otherwise, the tests
> are skipped.

Some generic comments:
1. I think you should also update .gitignore?
2. You can use ksft_exit_fail_perror() for wherever you want to print 
strerror(errno).

> 
> On current x86-64 with PAT inside a VM, all tests pass:
> 
> 	TAP version 13
> 	1..19
> 	ok 1 madvise(MADV_DONTNEED) should be disallowed
> 	ok 2 madvise(MADV_DONTNEED_LOCKED) should be disallowed
> 	ok 3 madvise(MADV_FREE) should be disallowed
> 	ok 4 madvise(MADV_WIPEONFORK) should be disallowed
> 	ok 5 madvise(MADV_COLD) should be disallowed
> 	ok 6 madvise(MADV_PAGEOUT) should be disallowed
> 	ok 7 madvise(MADV_POPULATE_READ) should be disallowed
> 	ok 8 madvise(MADV_POPULATE_WRITE) should be disallowed
> 	ok 9 munmap() splitting
> 	ok 10 mmap() after splitting
> 	ok 11 mremap(MREMAP_FIXED)
> 	ok 12 mremap() shrinking
> 	ok 13 mremap() growing should be disallowed
> 	ok 14 mprotect(PROT_NONE)
> 	ok 15 SIGSEGV expected
> 	ok 16 mprotect(PROT_READ)
> 	ok 17 SIGSEGV not expected
> 	ok 18 fork()
> 	ok 19 SIGSEGV in child not expected
> 	# Totals: pass:19 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> However, we are able to trigger:
> 
> [   27.888251] x86/PAT: pfnmap:1790 freeing invalid memtype [mem 0x00000000-0x00000fff]
> 
> There are probably more things worth testing in the future, such as
> MAP_PRIVATE handling. But this set of tests is sufficient to cover most of
> the things we will rework regarding PAT handling.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> On current mm-unstable, the MADV_POPULATE_READ test fails because
> mm-unstable contains a patch [1] that must be dropped.
> 
> [1] https://lore.kernel.org/all/20250507154105.763088-2-p.antoniou@partner.samsung.com/
> 
> ---
>   tools/testing/selftests/mm/Makefile |   1 +
>   tools/testing/selftests/mm/pfnmap.c | 278 ++++++++++++++++++++++++++++
>   2 files changed, 279 insertions(+)
>   create mode 100644 tools/testing/selftests/mm/pfnmap.c
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index ad4d6043a60f0..ae6f994d3add7 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -84,6 +84,7 @@ TEST_GEN_FILES += mremap_test
>   TEST_GEN_FILES += mseal_test
>   TEST_GEN_FILES += on-fault-limit
>   TEST_GEN_FILES += pagemap_ioctl
> +TEST_GEN_FILES += pfnmap
>   TEST_GEN_FILES += thuge-gen
>   TEST_GEN_FILES += transhuge-stress
>   TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
> new file mode 100644
> index 0000000000000..59be2f3221124
> --- /dev/null
> +++ b/tools/testing/selftests/mm/pfnmap.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Basic VM_PFNMAP tests relying on mmap() of '/dev/mem'
> + *
> + * Copyright 2025, Red Hat, Inc.
> + *
> + * Author(s): David Hildenbrand <david@redhat.com>
> + */
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <linux/mman.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest.h"
> +#include "vm_util.h"
> +
> +static size_t pagesize;
> +static int pagemap_fd;
> +static int dev_mem_fd;
> +static sigjmp_buf env;
> +
> +static void signal_handler(int sig)
> +{
> +	if (sig == SIGSEGV)
> +		siglongjmp(env, 1);
> +	siglongjmp(env, 2);
> +}
> +
> +static void sense_support(void)
> +{
> +	char *addr, tmp;
> +	int ret;
> +
> +	dev_mem_fd = open("/dev/mem", O_RDONLY);
> +	if (dev_mem_fd < 0)
> +		ksft_exit_skip("Cannot open '/dev/mem': %s\n", strerror(errno));
> +
> +	/* We'll require the first two pages throughout our tests ... */
> +	addr = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_skip("Cannot mmap '/dev/mem'");
> +
> +	/* ... and want to be able to read from them. */
> +	ret = sigsetjmp(env, 1);
> +	if (!ret) {
> +		tmp = *addr + *(addr + pagesize);
> +		asm volatile("" : "+r" (tmp));
> +	}
> +	if (ret)
> +		ksft_exit_skip("Cannot read-access mmap'ed '/dev/mem'");
> +
> +	munmap(addr, pagesize * 2);
> +}
> +
> +static void test_madvise(void)
> +{
> +#define INIT_ADVICE(nr) { nr, #nr}
> +	const struct {
> +		int nr;
> +		const char *name;
> +	} advices[] = {
> +		INIT_ADVICE(MADV_DONTNEED),
> +		INIT_ADVICE(MADV_DONTNEED_LOCKED),
> +		INIT_ADVICE(MADV_FREE),
> +		INIT_ADVICE(MADV_WIPEONFORK),
> +		INIT_ADVICE(MADV_COLD),
> +		INIT_ADVICE(MADV_PAGEOUT),
> +		INIT_ADVICE(MADV_POPULATE_READ),
> +		INIT_ADVICE(MADV_POPULATE_WRITE),
> +	};
> +	char *addr;
> +	int ret, i;
> +
> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* All these advices must be rejected. */
> +	for (i = 0; i < ARRAY_SIZE(advices); i++) {
> +		ret = madvise(addr, pagesize, advices[i].nr);
> +		ksft_test_result(ret && errno == EINVAL,
> +				 "madvise(%s) should be disallowed\n",
> +				 advices[i].name);
> +	}
> +
> +	munmap(addr, pagesize);
> +}
> +
> +static void test_munmap_splitting(void)
> +{
> +	char *addr1, *addr2;
> +	int ret;
> +
> +	addr1 = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr1 == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* Unmap the first pages. */
> +	ret = munmap(addr1, pagesize);
> +	ksft_test_result(!ret, "munmap() splitting\n");
> +
> +	/* Remap the first page while the second page is still mapped. */
> +	addr2 = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	ksft_test_result(addr2 != MAP_FAILED, "mmap() after splitting\n");
> +
> +	if (addr2 != MAP_FAILED)
> +		munmap(addr2, pagesize);
> +	if (!ret)
> +		munmap(addr1 + pagesize, pagesize);
> +	else
> +		munmap(addr1, pagesize * 2);
> +}
> +
> +static void test_mremap_fixed(void)
> +{
> +	char *addr, *new_addr, *ret;
> +
> +	addr = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* Reserve a destination area. */
> +	new_addr = mmap(0, pagesize * 2, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
> +	if (new_addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* mremap() over our destination. */
> +	ret = mremap(addr, pagesize * 2, pagesize * 2,
> +		     MREMAP_FIXED | MREMAP_MAYMOVE, new_addr);
> +	ksft_test_result(ret == new_addr, "mremap(MREMAP_FIXED)\n");
> +	if (ret != new_addr)
> +		munmap(new_addr, pagesize * 2);
> +	munmap(addr, pagesize * 2);
> +}
> +
> +static void test_mremap_shrinking(void)
> +{
> +	char *addr, *ret;
> +
> +	addr = mmap(0, pagesize * 2, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* Shrinking is expected to work. */
> +	ret = mremap(addr, pagesize * 2, pagesize, 0);
> +	ksft_test_result(ret == addr, "mremap() shrinking\n");
> +	if (ret != addr)
> +		munmap(addr, pagesize * 2);
> +	else
> +		munmap(addr, pagesize);
> +}
> +
> +static void test_mremap_growing(void)
> +{
> +	char *addr, *ret;
> +
> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* Growing is not expected to work. */
> +	ret = mremap(addr, pagesize, pagesize * 2, MREMAP_MAYMOVE);
> +	ksft_test_result(ret == MAP_FAILED,
> +			 "mremap() growing should be disallowed\n");
> +	if (ret == MAP_FAILED)
> +		munmap(addr, pagesize);
> +	else
> +		munmap(ret, pagesize * 2);
> +}
> +
> +static void test_mprotect(void)
> +{
> +	char *addr, tmp;
> +	int ret;
> +
> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* With PROT_NONE, read access must result in SIGSEGV. */
> +	ret = mprotect(addr, pagesize, PROT_NONE);
> +	ksft_test_result(!ret, "mprotect(PROT_NONE)\n");
> +
> +	ret = sigsetjmp(env, 1);
> +	if (!ret) {
> +		tmp = *addr;
> +		asm volatile("" : "+r" (tmp));
> +	}
> +	ksft_test_result(ret == 1, "SIGSEGV expected\n");
> +
> +	/* With PROT_READ, read access must again succeed. */
> +	ret = mprotect(addr, pagesize, PROT_READ);
> +	ksft_test_result(!ret, "mprotect(PROT_READ)\n");
> +
> +	ret = sigsetjmp(env, 1);
> +	if (!ret) {
> +		tmp = *addr;
> +		asm volatile("" : "+r" (tmp));
> +	}
> +	ksft_test_result(!ret, "SIGSEGV not expected\n");
> +
> +	munmap(addr, pagesize);
> +}
> +
> +static void test_fork(void)
> +{
> +	char *addr, tmp;
> +	int ret;
> +
> +	addr = mmap(0, pagesize, PROT_READ, MAP_SHARED, dev_mem_fd, 0);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() failed: %s\n", strerror(errno));
> +
> +	/* fork() a child and test if the child can access the page. */
> +	ret = fork();
> +	if (ret < 0) {
> +		ksft_test_result_fail("fork()\n");
> +		goto out;
> +	} else if (!ret) {
> +		ret = sigsetjmp(env, 1);
> +		if (!ret) {
> +			tmp = *addr;
> +			asm volatile("" : "+r" (tmp));
> +		}
> +		/* Return the result to the parent. */
> +		exit(ret);
> +	}
> +	ksft_test_result_pass("fork()\n");
> +
> +	/* Wait for our child and obtain the result. */
> +	wait(&ret);
> +	if (WIFEXITED(ret))
> +		ret = WEXITSTATUS(ret);
> +	else
> +		ret = -EINVAL;
> +
> +	ksft_test_result(!ret, "SIGSEGV in child not expected\n");
> +out:
> +	munmap(addr, pagesize);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int err;
> +
> +	ksft_print_header();
> +	ksft_set_plan(19);
> +
> +	pagesize = getpagesize();
> +	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> +	if (pagemap_fd < 0)
> +		ksft_exit_fail_msg("opening pagemap failed\n");
> +	if (signal(SIGSEGV, signal_handler) == SIG_ERR)
> +		ksft_exit_fail_msg("signal() failed: %s\n", strerror(errno));
> +
> +	sense_support();
> +	test_madvise();
> +	test_munmap_splitting();
> +	test_mremap_fixed();
> +	test_mremap_shrinking();
> +	test_mremap_growing();
> +	test_mprotect();
> +	test_fork();
> +
> +	err = ksft_get_fail_cnt();
> +	if (err)
> +		ksft_exit_fail_msg("%d out of %d tests failed\n",
> +				   err, ksft_test_num());
> +	ksft_exit_pass();
> +}


