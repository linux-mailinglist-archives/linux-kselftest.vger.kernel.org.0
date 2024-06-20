Return-Path: <linux-kselftest+bounces-12308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7074590FFDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 11:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBB7B21B1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF82514F9E5;
	Thu, 20 Jun 2024 09:04:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809D7628;
	Thu, 20 Jun 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874295; cv=none; b=FfeqFwuCfBgcN5I2GuQpksFnsKhUarStt+9VRHHqT+CGuH3lhEk6QBEd2BNFXXrJY5GLlbTl7uaEXoeopIIKbPytMhxIIitvglo/IihJm/elNuCS5zHlfxse9uzxUi2l8uvX+jnasy5CqZ57qG/BlP28e/jpn0gh9qUCraESMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874295; c=relaxed/simple;
	bh=TXMIEnNQYiFNlFAGAyRR7XEFYFmCzRqmalkivjZ7k00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEk5vbyA7qaOPNDyxXbvQjmNOGZm5d620BDhPpntqTuVryJlO9RZPlJVeQ3bLurvam1mSpuxBrUprSLeB6Zc9MAEwk1c6AMrKknqC6LUHBsE3mB+QNsmzwh2+pPhh8W6vsEYworkZy+Y4lqxO4C24KL8Xy88YobtBk12BXrRm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B9EFDA7;
	Thu, 20 Jun 2024 02:05:17 -0700 (PDT)
Received: from [10.57.74.104] (unknown [10.57.74.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B70AC3F6A8;
	Thu, 20 Jun 2024 02:04:50 -0700 (PDT)
Message-ID: <f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
Date: Thu, 20 Jun 2024 10:04:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 shuah@kernel.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, david@redhat.com, hughd@google.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 ying.huang@intel.com, linux-kselftest@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240620002648.75204-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240620002648.75204-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2024 01:26, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Both Ryan and Chris have been utilizing the small test program to aid
> in debugging and identifying issues with swap entry allocation. While
> a real or intricate workload might be more suitable for assessing the
> correctness and effectiveness of the swap allocation policy, a small
> test program presents a simpler means of understanding the problem and
> initially verifying the improvements being made.
> 
> Let's endeavor to integrate it into the self-test suite. Although it
> presently only accommodates 64KB and 4KB, I'm optimistic that we can
> expand its capabilities to support multiple sizes and simulate more
> complex systems in the future as required.

I'll try to summarize the thread with Huang Ying by suggesting this test program
is "neccessary but not sufficient" to exhaustively test the mTHP swap-out path.
I've certainly found it useful and think it would be a valuable addition to the
tree.

That said, I'm not convinced it is a selftest; IMO a selftest should provide a
clear pass/fail result against some criteria and must be able to be run
automatically by (e.g.) a CI system.

For the former, currently the test only fails if some API call unexpectedly
fails. Perhaps we would need to decide on some threshold for acceptable fallback
rate and fail if be go above that? But it's not clear how to determine such an
appropriate threshold.

For the latter, the test should be added to run_vmtests.sh. Then it will be run
automatically as part of invocing the standard kselftest runner and the results
will be reported in the standard TAP format. But this test also requires a very
specific swap and mthp configuration so you would also need to automatically
configure and restore that (either in run_vmtests.sh or in the c file).

Given the probable difficulties with defining clear success criteria, perhaps it
is better to put it in tools/mm?

Thanks,
Ryan


> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++++++++++++++
>  2 files changed, 193 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/thp_swap_allocator_test.c
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index e1aa09ddaa3d..64164ad66835 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -65,6 +65,7 @@ TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += seal_elf
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
> +TEST_GEN_FILES += thp_swap_allocator_test
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.c b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> new file mode 100644
> index 000000000000..4443a906d0f8
> --- /dev/null
> +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * thp_swap_allocator_test
> + *
> + * The purpose of this test program is helping check if THP swpout
> + * can correctly get swap slots to swap out as a whole instead of
> + * being split. It randomly releases swap entries through madvise
> + * DONTNEED and do swapout on two memory areas: a memory area for
> + * 64KB THP and the other area for small folios. The second memory
> + * can be enabled by "-s".
> + * Before running the program, we need to setup a zRAM or similar
> + * swap device by:
> + *  echo lzo > /sys/block/zram0/comp_algorithm
> + *  echo 64M > /sys/block/zram0/disksize
> + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
> + *  mkswap /dev/zram0
> + *  swapon /dev/zram0
> + * The expected result should be 0% anon swpout fallback ratio w/ or
> + * w/o "-s".
> + *
> + * Author(s): Barry Song <v-songbaohua@oppo.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <time.h>
> +
> +#define MEMSIZE_MTHP (60 * 1024 * 1024)
> +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
> +#define ALIGNMENT_MTHP (64 * 1024)
> +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
> +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
> +#define MTHP_FOLIO_SIZE (64 * 1024)
> +
> +#define SWPOUT_PATH \
> +	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
> +#define SWPOUT_FALLBACK_PATH \
> +	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fallback"
> +
> +static void *aligned_alloc_mem(size_t size, size_t alignment)
> +{
> +	void *mem = NULL;
> +
> +	if (posix_memalign(&mem, alignment, size) != 0) {
> +		perror("posix_memalign");
> +		return NULL;
> +	}
> +	return mem;
> +}
> +
> +static void random_madvise_dontneed(void *mem, size_t mem_size,
> +		size_t align_size, size_t total_dontneed_size)
> +{
> +	size_t num_pages = total_dontneed_size / align_size;
> +	size_t i;
> +	size_t offset;
> +	void *addr;
> +
> +	for (i = 0; i < num_pages; ++i) {
> +		offset = (rand() % (mem_size / align_size)) * align_size;
> +		addr = (char *)mem + offset;
> +		if (madvise(addr, align_size, MADV_DONTNEED) != 0)
> +			perror("madvise dontneed");
> +
> +		memset(addr, 0x11, align_size);
> +	}
> +}
> +
> +static unsigned long read_stat(const char *path)
> +{
> +	FILE *file;
> +	unsigned long value;
> +
> +	file = fopen(path, "r");
> +	if (!file) {
> +		perror("fopen");
> +		return 0;
> +	}
> +
> +	if (fscanf(file, "%lu", &value) != 1) {
> +		perror("fscanf");
> +		fclose(file);
> +		return 0;
> +	}
> +
> +	fclose(file);
> +	return value;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int use_small_folio = 0;
> +	int i;
> +	void *mem1 = aligned_alloc_mem(MEMSIZE_MTHP, ALIGNMENT_MTHP);
> +	void *mem2 = NULL;
> +
> +	if (mem1 == NULL) {
> +		fprintf(stderr, "Failed to allocate 60MB memory\n");
> +		return EXIT_FAILURE;
> +	}
> +
> +	if (madvise(mem1, MEMSIZE_MTHP, MADV_HUGEPAGE) != 0) {
> +		perror("madvise hugepage for mem1");
> +		free(mem1);
> +		return EXIT_FAILURE;
> +	}
> +
> +	for (i = 1; i < argc; ++i) {
> +		if (strcmp(argv[i], "-s") == 0)
> +			use_small_folio = 1;
> +	}
> +
> +	if (use_small_folio) {
> +		mem2 = aligned_alloc_mem(MEMSIZE_SMALLFOLIO, ALIGNMENT_MTHP);
> +		if (mem2 == NULL) {
> +			fprintf(stderr, "Failed to allocate 1MB memory\n");
> +			free(mem1);
> +			return EXIT_FAILURE;
> +		}
> +
> +		if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_NOHUGEPAGE) != 0) {
> +			perror("madvise nohugepage for mem2");
> +			free(mem1);
> +			free(mem2);
> +			return EXIT_FAILURE;
> +		}
> +	}
> +
> +	for (i = 0; i < 100; ++i) {
> +		unsigned long initial_swpout;
> +		unsigned long initial_swpout_fallback;
> +		unsigned long final_swpout;
> +		unsigned long final_swpout_fallback;
> +		unsigned long swpout_inc;
> +		unsigned long swpout_fallback_inc;
> +		double fallback_percentage;
> +
> +		initial_swpout = read_stat(SWPOUT_PATH);
> +		initial_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);
> +
> +		random_madvise_dontneed(mem1, MEMSIZE_MTHP, ALIGNMENT_MTHP,
> +				TOTAL_DONTNEED_MTHP);
> +
> +		if (use_small_folio) {
> +			random_madvise_dontneed(mem2, MEMSIZE_SMALLFOLIO,
> +					ALIGNMENT_SMALLFOLIO,
> +					TOTAL_DONTNEED_SMALLFOLIO);
> +		}
> +
> +		if (madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT) != 0) {
> +			perror("madvise pageout for mem1");
> +			free(mem1);
> +			if (mem2 != NULL)
> +				free(mem2);
> +			return EXIT_FAILURE;
> +		}
> +
> +		if (use_small_folio) {
> +			if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOUT) != 0) {
> +				perror("madvise pageout for mem2");
> +				free(mem1);
> +				free(mem2);
> +				return EXIT_FAILURE;
> +			}
> +		}
> +
> +		final_swpout = read_stat(SWPOUT_PATH);
> +		final_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);
> +
> +		swpout_inc = final_swpout - initial_swpout;
> +		swpout_fallback_inc = final_swpout_fallback - initial_swpout_fallback;
> +
> +		fallback_percentage = (double)swpout_fallback_inc /
> +			(swpout_fallback_inc + swpout_inc) * 100;
> +
> +		printf("Iteration %d: swpout inc: %lu, swpout fallback inc: %lu, Fallback percentage: %.2f%%\n",
> +				i + 1, swpout_inc, swpout_fallback_inc, fallback_percentage);
> +	}
> +
> +	free(mem1);
> +	if (mem2 != NULL)
> +		free(mem2);
> +
> +	return EXIT_SUCCESS;
> +}


