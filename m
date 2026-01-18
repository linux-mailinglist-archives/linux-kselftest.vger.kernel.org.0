Return-Path: <linux-kselftest+bounces-49251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192FD39332
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 08:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9153008E9D
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A93238166;
	Sun, 18 Jan 2026 07:55:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381E50096A;
	Sun, 18 Jan 2026 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768722936; cv=none; b=VesB3XmRQhu2mKdHU3vok0hv4WSRiJ4szRtIrfC+mXP/WFcPcIwW7sb03gTsbszqIFKwsTKRUjk03OxiiUs00uR34ELOFO2vvpJWL62fx1obFeeFvmBc/tEuy1nPEgxRSAOy/nDrlb/fF8Pn9u6GARi8eDKy19MjSAIkwyUELvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768722936; c=relaxed/simple;
	bh=vW/4NFX+kEBiqUl8QQ6BkrmmWFm8yBPd1ZvTj1bH89k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lG7zqtYXUfkqlLklzCZQV20LBovs41YxEsBd0NZLBuOLMptgaBCosSSv6/10YIOMqByVn0ck7cAZPgUg3icwGA6LbGk8bOR4vjdPz7mWIwsVnKuwdfQFKn9BtRLcgkemJhP8fZT/wUTSTc4Gz9w81q44BgUPrYSIo7avZkwRfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C639E1517;
	Sat, 17 Jan 2026 23:55:25 -0800 (PST)
Received: from [10.164.10.251] (unknown [10.164.10.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D068E3F694;
	Sat, 17 Jan 2026 23:55:28 -0800 (PST)
Message-ID: <5957ae48-87b8-4981-a6f7-8113141e7b6b@arm.com>
Date: Sun, 18 Jan 2026 13:25:25 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 16/01/26 6:50 pm, Lorenzo Stoakes wrote:
> This self test is asserting internal implementation details and is highly
> vulnerable to internal kernel changes as a result.
>
> It is currently failing locally from at least v6.17, and it seems that it
> may have been failing for longer in many configurations/hardware as it
> skips if e.g. CONFIG_ANON_VMA_NAME is not specified.

True, the test gets skipped for me since the mark_range function was added.

>
> With these skips and the fact that run_vmtests.sh won't run the tests in
> certain configurations it is likely we have simply missed this test being
> broken in CI for a long while.
>
> I have tried multiple versions of these tests and am unable to find a
> working bisect as previous versions of the test fail also.

Does the test fail for you even for commit 13e860961fd4 ("selftests/mm: virtual_address_range: Switch to ksft_exit_fail_msg").
I have never observed failure at this.


>
> The tests are essentially mmap()'ing a series of mappings with no hint and
> asserting what the get_unmapped_area*() functions will come up with, with
> seemingly few checks for what other mappings may already be in place.
>
> It then appears to be mmap()'ing with a hint, and making a series of
> similar assertions about the internal implementation details of the hinting
> logic.

The revelation of internal detail starts at 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()").
All that does is to check whether mmap failure actually means exhaustion. This can reveal bugs in maple tree,
if it cannot find a 1G chunk in it, even when the gap is present. This is an internal detail which is not
expected to change - no one reports any breakage (AFAIK, please correct if I am wrong) until after 10 months, at
commit a005145b9c96 ("selftests/mm: virtual_address_range: mmap() without PROT_WRITE"), that too not at the
gap assertion code - the breakage happens at the while (start_addr + hop < end_addr) chunk of code. In retrospect I should
not have added this chunk - the purpose was to check whether the VMAs being advertised in procfs are actually usable, testing
something which, in case breaks, is extremely easy to figure out and fix, without putting this functionality in the test. And, I
had no knowledge at the time that this will cause pagetable allocation and will touch physical memory. So commits
b2a79f62133a and 3bd6137220bb could have simply been avoided by removing the bit of code I mentioned.

>
> Commit 0ef3783d7558 ("selftests/mm: add support to test 4PB VA on PPC64"),
> commit 3bd6137220bb ("selftests/mm: virtual_address_range: avoid reading
> from VM_IO mappings"), and especially commit a005145b9c96 ("selftests/mm:
> virtual_address_range: mmap() without PROT_WRITE") are good examples of the
> whack-a-mole nature of maintaining this test.
>
> The last commit there being particularly pertinent as it was accounting for
> an internal implementation detail change that really should have no bearing
> on self-tests, that is commit e93d2521b27f ("x86/vdso: Split virtual clock
> pages into dedicated mapping").
>
> The purpose of the mm self-tests are to assert attributes about the API
> exposed to users, and to ensure that expectations are met.
>
> This test is emphatically not doing this, rather making a series of
> assumptions about internal implementation details and asserting them.
>
> It therefore, sadly, seems that the best course is to remove this test
> altogether.

The objective of the test is to exhaust VA space and find out bugs in mmap(). It has
been useful in discovering a bug at [1].

[1] https://lore.kernel.org/all/20240123171420.3970220-1-ryan.roberts@arm.com/

>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/selftests/mm/.gitignore         |   1 -
>  tools/testing/selftests/mm/Makefile           |   3 -
>  tools/testing/selftests/mm/run_vmtests.sh     |  12 -
>  .../selftests/mm/virtual_address_range.c      | 260 ------------------
>  4 files changed, 276 deletions(-)
>  delete mode 100644 tools/testing/selftests/mm/virtual_address_range.c
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index c2a8586e51a1..702e5723c35d 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -32,7 +32,6 @@ uffd-unit-tests
>  uffd-wp-mremap
>  mlock-intersect-test
>  mlock-random-test
> -virtual_address_range
>  gup_test
>  va_128TBswitch
>  map_fixed_noreplace
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index de4afc34e3b1..2fdb05e5a56a 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -136,9 +136,6 @@ endif
>  
>  ifneq (,$(filter $(ARCH),arm64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
>  TEST_GEN_FILES += va_high_addr_switch
> -ifneq ($(ARCH),riscv64)
> -TEST_GEN_FILES += virtual_address_range
> -endif
>  TEST_GEN_FILES += write_to_hugetlbfs
>  endif
>  
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 2dadbfc6e535..452875db532c 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -399,18 +399,6 @@ CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
>  fi
>  
>  if [ $VADDR64 -ne 0 ]; then
> -
> -	# set overcommit_policy as OVERCOMMIT_ALWAYS so that kernel
> -	# allows high virtual address allocation requests independent
> -	# of platform's physical memory.
> -
> -	if [ -x ./virtual_address_range ]; then
> -		prev_policy=$(cat /proc/sys/vm/overcommit_memory)
> -		echo 1 > /proc/sys/vm/overcommit_memory
> -		CATEGORY="hugevm" run_test ./virtual_address_range
> -		echo $prev_policy > /proc/sys/vm/overcommit_memory
> -	fi
> -
>  	# va high address boundary switch test
>  	CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
>  fi # VADDR64
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> deleted file mode 100644
> index 4f0923825ed7..000000000000
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ /dev/null
> @@ -1,260 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright 2017, Anshuman Khandual, IBM Corp.
> - *
> - * Works on architectures which support 128TB virtual
> - * address range and beyond.
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <sys/prctl.h>
> -#include <sys/mman.h>
> -#include <sys/time.h>
> -#include <fcntl.h>
> -
> -#include "vm_util.h"
> -#include "kselftest.h"
> -
> -/*
> - * Maximum address range mapped with a single mmap()
> - * call is little bit more than 1GB. Hence 1GB is
> - * chosen as the single chunk size for address space
> - * mapping.
> - */
> -
> -#define SZ_1GB	(1024 * 1024 * 1024UL)
> -#define SZ_1TB	(1024 * 1024 * 1024 * 1024UL)
> -
> -#define MAP_CHUNK_SIZE	SZ_1GB
> -
> -/*
> - * Address space till 128TB is mapped without any hint
> - * and is enabled by default. Address space beyond 128TB
> - * till 512TB is obtained by passing hint address as the
> - * first argument into mmap() system call.
> - *
> - * The process heap address space is divided into two
> - * different areas one below 128TB and one above 128TB
> - * till it reaches 512TB. One with size 128TB and the
> - * other being 384TB.
> - *
> - * On Arm64 the address space is 256TB and support for
> - * high mappings up to 4PB virtual address space has
> - * been added.
> - *
> - * On PowerPC64, the address space up to 128TB can be
> - * mapped without a hint. Addresses beyond 128TB, up to
> - * 4PB, can be mapped with a hint.
> - *
> - */
> -
> -#define NR_CHUNKS_128TB   ((128 * SZ_1TB) / MAP_CHUNK_SIZE) /* Number of chunks for 128TB */
> -#define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
> -#define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
> -#define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
> -#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
> -
> -#define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
> -#define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
> -
> -#ifdef __aarch64__
> -#define HIGH_ADDR_MARK  ADDR_MARK_256TB
> -#define HIGH_ADDR_SHIFT 49
> -#define NR_CHUNKS_LOW   NR_CHUNKS_256TB
> -#define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
> -#elif defined(__PPC64__)
> -#define HIGH_ADDR_MARK  ADDR_MARK_128TB
> -#define HIGH_ADDR_SHIFT 48
> -#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
> -#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
> -#else
> -#define HIGH_ADDR_MARK  ADDR_MARK_128TB
> -#define HIGH_ADDR_SHIFT 48
> -#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
> -#define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
> -#endif
> -
> -static char *hint_addr(void)
> -{
> -	int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
> -
> -	return (char *) (1UL << bits);
> -}
> -
> -static void validate_addr(char *ptr, int high_addr)
> -{
> -	unsigned long addr = (unsigned long) ptr;
> -
> -	if (high_addr) {
> -		if (addr < HIGH_ADDR_MARK)
> -			ksft_exit_fail_msg("Bad address %lx\n", addr);
> -		return;
> -	}
> -
> -	if (addr > HIGH_ADDR_MARK)
> -		ksft_exit_fail_msg("Bad address %lx\n", addr);
> -}
> -
> -static void mark_range(char *ptr, size_t size)
> -{
> -	if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, size, "virtual_address_range") == -1) {
> -		if (errno == EINVAL) {
> -			/* Depends on CONFIG_ANON_VMA_NAME */
> -			ksft_test_result_skip("prctl(PR_SET_VMA_ANON_NAME) not supported\n");
> -			ksft_finished();
> -		} else {
> -			ksft_exit_fail_perror("prctl(PR_SET_VMA_ANON_NAME) failed\n");
> -		}
> -	}
> -}
> -
> -static int is_marked_vma(const char *vma_name)
> -{
> -	return vma_name && !strcmp(vma_name, "[anon:virtual_address_range]\n");
> -}
> -
> -static int validate_lower_address_hint(void)
> -{
> -	char *ptr;
> -
> -	ptr = mmap((void *) (1UL << 45), MAP_CHUNK_SIZE, PROT_READ |
> -		   PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -
> -	if (ptr == MAP_FAILED)
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static int validate_complete_va_space(void)
> -{
> -	unsigned long start_addr, end_addr, prev_end_addr;
> -	char line[400];
> -	char prot[6];
> -	FILE *file;
> -	int fd;
> -
> -	fd = open("va_dump", O_CREAT | O_WRONLY, 0600);
> -	unlink("va_dump");
> -	if (fd < 0) {
> -		ksft_test_result_skip("cannot create or open dump file\n");
> -		ksft_finished();
> -	}
> -
> -	file = fopen("/proc/self/maps", "r");
> -	if (file == NULL)
> -		ksft_exit_fail_msg("cannot open /proc/self/maps\n");
> -
> -	prev_end_addr = 0;
> -	while (fgets(line, sizeof(line), file)) {
> -		const char *vma_name = NULL;
> -		int vma_name_start = 0;
> -		unsigned long hop;
> -
> -		if (sscanf(line, "%lx-%lx %4s %*s %*s %*s %n",
> -			   &start_addr, &end_addr, prot, &vma_name_start) != 3)
> -			ksft_exit_fail_msg("cannot parse /proc/self/maps\n");
> -
> -		if (vma_name_start)
> -			vma_name = line + vma_name_start;
> -
> -		/* end of userspace mappings; ignore vsyscall mapping */
> -		if (start_addr & (1UL << 63))
> -			return 0;
> -
> -		/* /proc/self/maps must have gaps less than MAP_CHUNK_SIZE */
> -		if (start_addr - prev_end_addr >= MAP_CHUNK_SIZE)
> -			return 1;
> -
> -		prev_end_addr = end_addr;
> -
> -		if (prot[0] != 'r')
> -			continue;
> -
> -		if (check_vmflag_io((void *)start_addr))
> -			continue;
> -
> -		/*
> -		 * Confirm whether MAP_CHUNK_SIZE chunk can be found or not.
> -		 * If write succeeds, no need to check MAP_CHUNK_SIZE - 1
> -		 * addresses after that. If the address was not held by this
> -		 * process, write would fail with errno set to EFAULT.
> -		 * Anyways, if write returns anything apart from 1, exit the
> -		 * program since that would mean a bug in /proc/self/maps.
> -		 */
> -		hop = 0;
> -		while (start_addr + hop < end_addr) {
> -			if (write(fd, (void *)(start_addr + hop), 1) != 1)
> -				return 1;
> -			lseek(fd, 0, SEEK_SET);
> -
> -			if (is_marked_vma(vma_name))
> -				munmap((char *)(start_addr + hop), MAP_CHUNK_SIZE);
> -
> -			hop += MAP_CHUNK_SIZE;
> -		}
> -	}
> -	return 0;
> -}
> -
> -int main(int argc, char *argv[])
> -{
> -	char *ptr[NR_CHUNKS_LOW];
> -	char **hptr;
> -	char *hint;
> -	unsigned long i, lchunks, hchunks;
> -
> -	ksft_print_header();
> -	ksft_set_plan(1);
> -
> -	for (i = 0; i < NR_CHUNKS_LOW; i++) {
> -		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ,
> -			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -
> -		if (ptr[i] == MAP_FAILED) {
> -			if (validate_lower_address_hint())
> -				ksft_exit_fail_msg("mmap unexpectedly succeeded with hint\n");
> -			break;
> -		}
> -
> -		mark_range(ptr[i], MAP_CHUNK_SIZE);
> -		validate_addr(ptr[i], 0);
> -	}
> -	lchunks = i;
> -	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
> -	if (hptr == NULL) {
> -		ksft_test_result_skip("Memory constraint not fulfilled\n");
> -		ksft_finished();
> -	}
> -
> -	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
> -		hint = hint_addr();
> -		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
> -			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -
> -		if (hptr[i] == MAP_FAILED)
> -			break;
> -
> -		mark_range(hptr[i], MAP_CHUNK_SIZE);
> -		validate_addr(hptr[i], 1);
> -	}
> -	hchunks = i;
> -	if (validate_complete_va_space()) {
> -		ksft_test_result_fail("BUG in mmap() or /proc/self/maps\n");
> -		ksft_finished();
> -	}
> -
> -	for (i = 0; i < lchunks; i++)
> -		munmap(ptr[i], MAP_CHUNK_SIZE);
> -
> -	for (i = 0; i < hchunks; i++)
> -		munmap(hptr[i], MAP_CHUNK_SIZE);
> -
> -	free(hptr);
> -
> -	ksft_test_result_pass("Test\n");
> -	ksft_finished();
> -}

