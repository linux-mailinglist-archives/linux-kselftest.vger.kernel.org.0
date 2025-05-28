Return-Path: <linux-kselftest+bounces-33927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F05AC670B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 12:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557F44E1F9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3D32797B5;
	Wed, 28 May 2025 10:35:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158B0275115;
	Wed, 28 May 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428505; cv=none; b=T8LVr2hbW9SJF3EGC42znzu/LI/0osNyNGZv+AwyLxoYlJkvtebgJO6oKkoN+9FWrQMdmNI3kb7+Jw/AjYiC+GH5ICMOWGMs3Nau4pPwDOMQJf9rENxddY/1QRedw4ZQm4kFUU+dUDDm2mcdnLnoRlSLjGJddRFouTNK9nQhzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428505; c=relaxed/simple;
	bh=NtuCmb2qX+u9TmUxgQhAMvqeHDbod2xF6zPhiRL7/+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrWnmZFt4AKiXsmbu0073OznZlH3/B7r8kn5AMz4CQfufWwp4jWF5KIp9xLcFP3SKh7EWL7ASfuRrHvqlcC/ndt1kCwnreiYZs9s7mh7VWGnSgNzy2UXHVryHK+j5cTdU1StMZViwfnpeX4QD2xpuZcGZEBBSCSujh7du3TIOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08B89150C;
	Wed, 28 May 2025 03:34:46 -0700 (PDT)
Received: from [10.57.94.142] (unknown [10.57.94.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF7383F673;
	Wed, 28 May 2025 03:35:00 -0700 (PDT)
Message-ID: <232960c2-81db-47ca-a337-38c4bce5f997@arm.com>
Date: Wed, 28 May 2025 11:34:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Xu <peterx@redhat.com>, Dev Jain
 <dev.jain@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <20250509153033.952746-1-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250509153033.952746-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,


On 09/05/2025 16:30, David Hildenbrand wrote:
> Let's test some basic functionality using /dev/mem. These tests will
> implicitly cover some PAT (Page Attribute Handling) handling on x86.
> 
> These tests will only run when /dev/mem access to the first two pages
> in physical address space is possible and allowed; otherwise, the tests
> are skipped.

We are seeing really horrible RAS errors with this test when run on arm64 tx2
machine. Based solely on reviewing the code, I think the problem is that tx2
doesn't have anything at phys address 0, so test_read_access() is trying to put
trasactions out to a bad address on the bus.

tx2 /proc/iomem:

$ sudo cat /proc/iomem
30000000-37ffffff : PCI ECAM
38000000-3fffffff : PCI ECAM
40000000-5fffffff : PCI Bus 0000:00
...

Whereas my x86 box has some reserved memory:

$ sudo cat /proc/iomem
00000000-00000fff : Reserved
00001000-0003dfff : System RAM
...

I think perhaps the only safe way to handle this is to parse /proc/iomem for a
region of "System RAM" that is at least 2 pages then use that for your read
tests. This would also solve the hypothetical issue of reading something that
has read size effects.

I also spotted a few nits while reading the code...

> 
> On current x86-64 with PAT inside a VM, all tests pass:
> 
> 	TAP version 13
> 	1..6
> 	# Starting 6 tests from 1 test cases.
> 	#  RUN           pfnmap.madvise_disallowed ...
> 	#            OK  pfnmap.madvise_disallowed
> 	ok 1 pfnmap.madvise_disallowed
> 	#  RUN           pfnmap.munmap_split ...
> 	#            OK  pfnmap.munmap_split
> 	ok 2 pfnmap.munmap_split
> 	#  RUN           pfnmap.mremap_fixed ...
> 	#            OK  pfnmap.mremap_fixed
> 	ok 3 pfnmap.mremap_fixed
> 	#  RUN           pfnmap.mremap_shrink ...
> 	#            OK  pfnmap.mremap_shrink
> 	ok 4 pfnmap.mremap_shrink
> 	#  RUN           pfnmap.mremap_expand ...
> 	#            OK  pfnmap.mremap_expand
> 	ok 5 pfnmap.mremap_expand
> 	#  RUN           pfnmap.fork ...
> 	#            OK  pfnmap.fork
> 	ok 6 pfnmap.fork
> 	# PASSED: 6 / 6 tests passed.
> 	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
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
> Cc: Dev Jain <dev.jain@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Hopefully I didn't miss any review feedback.
> 
> v1 -> v2:
> * Rewrite using kselftest_harness, which simplifies a lot of things
> * Add to .gitignore and run_vmtests.sh
> * Register signal handler on demand
> * Use volatile trick to force a read (not factoring out FORCE_READ just yet)
> * Drop mprotect() test case
> * Add some more comments why we test certain things
> * Use NULL for mmap() first parameter instead of 0
> * Smaller fixes
> 
> ---
>  tools/testing/selftests/mm/.gitignore     |   1 +
>  tools/testing/selftests/mm/Makefile       |   1 +
>  tools/testing/selftests/mm/pfnmap.c       | 196 ++++++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh |   4 +
>  4 files changed, 202 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/pfnmap.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 91db34941a143..824266982aa36 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -20,6 +20,7 @@ mremap_test
>  on-fault-limit
>  transhuge-stress
>  pagemap_ioctl
> +pfnmap
>  *.tmp*
>  protection_keys
>  protection_keys_32
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index ad4d6043a60f0..ae6f994d3add7 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -84,6 +84,7 @@ TEST_GEN_FILES += mremap_test
>  TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
> +TEST_GEN_FILES += pfnmap
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
> new file mode 100644
> index 0000000000000..8a9d19b6020c7
> --- /dev/null
> +++ b/tools/testing/selftests/mm/pfnmap.c
> @@ -0,0 +1,196 @@
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
> +#include "../kselftest_harness.h"
> +#include "vm_util.h"
> +
> +static sigjmp_buf sigjmp_buf_env;
> +
> +static void signal_handler(int sig)
> +{
> +	siglongjmp(sigjmp_buf_env, -EFAULT);
> +}
> +
> +static int test_read_access(char *addr, size_t size, size_t pagesize)
> +{
> +	size_t offs;
> +	int ret;
> +
> +	if (signal(SIGSEGV, signal_handler) == SIG_ERR)
> +		return -EINVAL;
> +
> +	ret = sigsetjmp(sigjmp_buf_env, 1);
> +	if (!ret) {
> +		for (offs = 0; offs < size; offs += pagesize)
> +			/* Force a read that the compiler cannot optimize out. */
> +			*((volatile char *)(addr + offs));
> +	}
> +	if (signal(SIGSEGV, signal_handler) == SIG_ERR)

I think you mean:
	if (signal(SIGSEGV, SIG_DFL) == SIG_ERR)

Otherwise your signal_handler will remain installed, right?

> +		return -EINVAL;
> +
> +	return ret;
> +}
> +
> +FIXTURE(pfnmap)
> +{
> +	size_t pagesize;
> +	int dev_mem_fd;
> +	char *addr1;
> +	size_t size1;
> +	char *addr2;
> +	size_t size2;
> +};
> +
> +FIXTURE_SETUP(pfnmap)
> +{
> +	self->pagesize = getpagesize();
> +
> +	self->dev_mem_fd = open("/dev/mem", O_RDONLY);
> +	if (self->dev_mem_fd < 0)
> +		SKIP(return, "Cannot open '/dev/mem'\n");
> +
> +	/* We'll require the first two pages throughout our tests ... */
> +	self->size1 = self->pagesize * 2;
> +	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
> +			   self->dev_mem_fd, 0);
> +	if (self->addr1 == MAP_FAILED)
> +		SKIP(return, "Cannot mmap '/dev/mem'\n");
> +
> +	/* ... and want to be able to read from them. */
> +	if (test_read_access(self->addr1, self->size1, self->pagesize))
> +		SKIP(return, "Cannot read-access mmap'ed '/dev/mem'\n");
> +
> +	self->size2 = 0;
> +	self->addr2 = MAP_FAILED;

Do you need to init all the params in FIXTURE(pfnmap) to their "safe" values
before any possible early returns? We don't want FIXTURE_TEARDOWN(pfnmap)
getting confused.

Thanks,
Ryan

> +}
> +
> +FIXTURE_TEARDOWN(pfnmap)
> +{
> +	if (self->addr2 != MAP_FAILED)
> +		munmap(self->addr2, self->size2);
> +	if (self->addr1 != MAP_FAILED)
> +		munmap(self->addr1, self->size1);
> +	if (self->dev_mem_fd >= 0)
> +		close(self->dev_mem_fd);
> +}
> +
> +TEST_F(pfnmap, madvise_disallowed)
> +{
> +	int advices[] = {
> +		MADV_DONTNEED,
> +		MADV_DONTNEED_LOCKED,
> +		MADV_FREE,
> +		MADV_WIPEONFORK,
> +		MADV_COLD,
> +		MADV_PAGEOUT,
> +		MADV_POPULATE_READ,
> +		MADV_POPULATE_WRITE,
> +	};
> +	int i;
> +
> +	/* All these advices must be rejected. */
> +	for (i = 0; i < ARRAY_SIZE(advices); i++) {
> +		EXPECT_LT(madvise(self->addr1, self->pagesize, advices[i]), 0);
> +		EXPECT_EQ(errno, EINVAL);
> +	}
> +}
> +
> +TEST_F(pfnmap, munmap_split)
> +{
> +	/*
> +	 * Unmap the first page. This munmap() call is not really expected to
> +	 * fail, but we might be able to trigger other internal issues.
> +	 */
> +	ASSERT_EQ(munmap(self->addr1, self->pagesize), 0);
> +
> +	/*
> +	 * Remap the first page while the second page is still mapped. This
> +	 * makes sure that any PAT tracking on x86 will allow for mmap()'ing
> +	 * a page again while some parts of the first mmap() are still
> +	 * around.
> +	 */
> +	self->size2 = self->pagesize;
> +	self->addr2 = mmap(NULL, self->pagesize, PROT_READ, MAP_SHARED,
> +			   self->dev_mem_fd, 0);
> +	ASSERT_NE(self->addr2, MAP_FAILED);
> +}
> +
> +TEST_F(pfnmap, mremap_fixed)
> +{
> +	char *ret;
> +
> +	/* Reserve a destination area. */
> +	self->size2 = self->size1;
> +	self->addr2 = mmap(NULL, self->size2, PROT_READ, MAP_ANON | MAP_PRIVATE,
> +			   -1, 0);
> +	ASSERT_NE(self->addr2, MAP_FAILED);
> +
> +	/* mremap() over our destination. */
> +	ret = mremap(self->addr1, self->size1, self->size2,
> +		     MREMAP_FIXED | MREMAP_MAYMOVE, self->addr2);
> +	ASSERT_NE(ret, MAP_FAILED);
> +}
> +
> +TEST_F(pfnmap, mremap_shrink)
> +{
> +	char *ret;
> +
> +	/* Shrinking is expected to work. */
> +	ret = mremap(self->addr1, self->size1, self->size1 - self->pagesize, 0);
> +	ASSERT_NE(ret, MAP_FAILED);
> +}
> +
> +TEST_F(pfnmap, mremap_expand)
> +{
> +	/*
> +	 * Growing is not expected to work, and getting it right would
> +	 * be challenging. So this test primarily serves as an early warning
> +	 * that something that probably should never work suddenly works.
> +	 */
> +	self->size2 = self->size1 + self->pagesize;
> +	self->addr2 = mremap(self->addr1, self->size1, self->size2, MREMAP_MAYMOVE);
> +	ASSERT_EQ(self->addr2, MAP_FAILED);
> +}
> +
> +TEST_F(pfnmap, fork)
> +{
> +	pid_t pid;
> +	int ret;
> +
> +	/* fork() a child and test if the child can access the pages. */
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (!pid) {
> +		EXPECT_EQ(test_read_access(self->addr1, self->size1,
> +					   self->pagesize), 0);
> +		exit(0);
> +	}
> +
> +	wait(&ret);
> +	if (WIFEXITED(ret))
> +		ret = WEXITSTATUS(ret);
> +	else
> +		ret = -EINVAL;
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 188b125bf1f6b..dddd1dd8af145 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -63,6 +63,8 @@ separated by spaces:
>  	test soft dirty page bit semantics
>  - pagemap
>  	test pagemap_scan IOCTL
> +- pfnmap
> +	tests for VM_PFNMAP handling
>  - cow
>  	test copy-on-write semantics
>  - thp
> @@ -472,6 +474,8 @@ fi
>  
>  CATEGORY="pagemap" run_test ./pagemap_ioctl
>  
> +CATEGORY="pfnmap" run_test ./pfnmap
> +
>  # COW tests
>  CATEGORY="cow" run_test ./cow
>  


