Return-Path: <linux-kselftest+bounces-11338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B08FFC31
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 08:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4895F1C203A6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 06:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779E14F9CC;
	Fri,  7 Jun 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zssYCzMg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97914EC75;
	Fri,  7 Jun 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741395; cv=none; b=Vo3Uk4k1hM+30aAvRaPGBMPD4Map48lcyntNvjJGAzzSeeSRuHjl51uWVXH7/IVTbGidSYdpAMyeKA6iix9de4j2UhCWn+6jYguwHsXOhwbhcYwo+Me4VsZxgIEXh7h9MBZMNwWwXe9c+AOhz0OMfJ/x/Yw7UkT+jgabW1op9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741395; c=relaxed/simple;
	bh=e2/8FFik4VTYyTTf7c/nXYCFl6qwMjnndsppTg6LJ7E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VkKgjxFze+qb4U0Cbs2Nu8U5Eq/FEEGOYY8oSMmMBwhc1Ypr5XB7lKjV9Mw4TInYN2Pgi0AGuPaooDEvfez7qmGSxe8fzsOiKskrJXhCdxgNZCaXpsawC/iqs8Q25ajGu6TFTIFVIr8RXLIUx/HypB7aw6gRgDN8bj2jKaYHq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zssYCzMg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717741391;
	bh=e2/8FFik4VTYyTTf7c/nXYCFl6qwMjnndsppTg6LJ7E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=zssYCzMg8cUZIbxN5Hk1doFPXNhnXXuLnyj4LV3PsHSaekKBP8nnqUsqpd7YquZ8t
	 Vyb/87TR6JPRBaC1Yv/nIZhmo5RHMIWgf41l0TjA6QjeecEbL0EGP43C+Yw2b9WB+a
	 4gugNBJmGPTfM4rfO7JR83VWori0Qe4Rqa+a/x3T1HJEMChRVRLVxQkIXIuG1/EJbM
	 BL7rTZ/D6Fk5eulMnjRx0d/gQ73XJpBwft7TZ1pByjyBkrWPq096CXN1/KblcbnHt0
	 9NNKYYNFPzv1YHQThyLVeM+wRlP4Ad4PNiFpRSxqZSXmeX57CuBhskNPFTCxNGeJqE
	 cY02QuV2101iw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 384303780EC6;
	Fri,  7 Jun 2024 06:23:06 +0000 (UTC)
Message-ID: <5ce292b6-179c-48e0-9079-ea07defbe178@collabora.com>
Date: Fri, 7 Jun 2024 11:23:42 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ritesh Harjani <ritesh.list@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>, David Hildenbrand
 <david@redhat.com>, p.raghav@samsung.com
Subject: Re: [PATCH v3] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Tony Battersby <tonyb@cybernetics.com>
References: <20240607055046.138650-1-donettom@linux.ibm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240607055046.138650-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 10:50 AM, Donet Tom wrote:
> Commit 1b151e2435fc ("block: Remove special-casing of compound
> pages") caused a change in behaviour when releasing the pages
> if the buffer does not start at the beginning of the page. This
> was because the calculation of the number of pages to release
> was incorrect.
> This was fixed by commit 38b43539d64b ("block: Fix page refcounts
> for unaligned buffers in __bio_release_pages()").
> 
> We pin the user buffer during direct I/O writes. If this buffer is a
> hugepage, bio_release_page() will unpin it and decrement all references
> and pin counts at ->bi_end_io. However, if any references to the hugepage
> remain post-I/O, the hugepage will not be freed upon unmap, leading
> to a memory leak.
> 
> This patch verifies that a hugepage, used as a user buffer for DIO
> operations, is correctly freed upon unmapping, regardless of whether
> the offsets are aligned or unaligned w.r.t page boundary.
> 
> Test Result  Fail Scenario (Without the fix)
> --------------------------------------------------------
> []# ./hugetlb_dio
> TAP version 13
> 1..4
> No. Free pages before allocation : 7
> No. Free pages after munmap : 7
> ok 1 : Huge pages freed successfully !
> No. Free pages before allocation : 7
> No. Free pages after munmap : 7
> ok 2 : Huge pages freed successfully !
> No. Free pages before allocation : 7
> No. Free pages after munmap : 7
> ok 3 : Huge pages freed successfully !
> No. Free pages before allocation : 7
> No. Free pages after munmap : 6
> not ok 4 : Huge pages not freed!
> Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> Test Result  PASS Scenario (With the fix)
> ---------------------------------------------------------
> []#./hugetlb_dio
> TAP version 13
> 1..4
> No. Free pages before allocation : 7
> No. Free pages after munmap : 7
> ok 1 : Huge pages freed successfully !
> No. Free pages before allocation : 7
> No. Free pages after munmap : 7
> ok 2 : Huge pages freed successfully !
> No. Free pages before allocation : 7
> No. Free pages after munmap : 7
> ok 3 : Huge pages freed successfully !
> No. Free pages before allocation : 7
> No. Free pages after munmap : 7
> ok 4 : Huge pages freed successfully !
> Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> V3:
> - Fixed the build error when it is compiled with _FORTIFY_SOURCE.
> 
> V2:
> - Addressed all review commets from Muhammad Usama Anjum
> https://lore.kernel.org/all/20240604132801.23377-1-donettom@linux.ibm.com/
> 
> V1:
> https://lore.kernel.org/all/20240523063905.3173-1-donettom@linux.ibm.com/#t
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tools/testing/selftests/mm/Makefile      |   1 +
>  tools/testing/selftests/mm/hugetlb_dio.c | 118 +++++++++++++++++++++++
Missed my feedback on adding the test to vm_test.sh

Other than this, LGTM. Please add following tag after the above change:

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

>  2 files changed, 119 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/hugetlb_dio.c
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 3b49bc3d0a3b..a1748a4c7df1 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -73,6 +73,7 @@ TEST_GEN_FILES += ksm_functional_tests
>  TEST_GEN_FILES += mdwe_test
>  TEST_GEN_FILES += hugetlb_fault_after_madv
>  TEST_GEN_FILES += hugetlb_madv_vs_map
> +TEST_GEN_FILES += hugetlb_dio
>  
>  ifneq ($(ARCH),arm64)
>  TEST_GEN_FILES += soft-dirty
> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
> new file mode 100644
> index 000000000000..986f3b6c7f7b
> --- /dev/null
> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This program tests for hugepage leaks after DIO writes to a file using a
> + * hugepage as the user buffer. During DIO, the user buffer is pinned and
> + * should be properly unpinned upon completion. This patch verifies that the
> + * kernel correctly unpins the buffer at DIO completion for both aligned and
> + * unaligned user buffer offsets (w.r.t page boundary), ensuring the hugepage
> + * is freed upon unmapping.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/stat.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include "vm_util.h"
> +#include "../kselftest.h"
> +
> +void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
> +{
> +	int fd;
> +	char *buffer =  NULL;
> +	char *orig_buffer = NULL;
> +	size_t h_pagesize = 0;
> +	size_t writesize;
> +	int free_hpage_b = 0;
> +	int free_hpage_a = 0;
> +	const int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB;
> +	const int mmap_prot  = PROT_READ | PROT_WRITE;
> +
> +	writesize = end_off - start_off;
> +
> +	/* Get the default huge page size */
> +	h_pagesize = default_huge_page_size();
> +	if (!h_pagesize)
> +		ksft_exit_fail_msg("Unable to determine huge page size\n");
> +
> +	/* Open the file to DIO */
> +	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> +	if (fd < 0)
> +		ksft_exit_fail_perror("Error opening file\n");
> +
> +	/* Get the free huge pages before allocation */
> +	free_hpage_b = get_free_hugepages();
> +	if (free_hpage_b == 0) {
> +		close(fd);
> +		ksft_exit_skip("No free hugepage, exiting!\n");
> +	}
> +
> +	/* Allocate a hugetlb page */
> +	orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0);
> +	if (orig_buffer == MAP_FAILED) {
> +		close(fd);
> +		ksft_exit_fail_perror("Error mapping memory\n");
> +	}
> +	buffer = orig_buffer;
> +	buffer += start_off;
> +
> +	memset(buffer, 'A', writesize);
> +
> +	/* Write the buffer to the file */
> +	if (write(fd, buffer, writesize) != (writesize)) {
> +		munmap(orig_buffer, h_pagesize);
> +		close(fd);
> +		ksft_exit_fail_perror("Error writing to file\n");
> +	}
> +
> +	/* unmap the huge page */
> +	munmap(orig_buffer, h_pagesize);
> +	close(fd);
> +
> +	/* Get the free huge pages after unmap*/
> +	free_hpage_a = get_free_hugepages();
> +
> +	/*
> +	 * If the no. of free hugepages before allocation and after unmap does
> +	 * not match - that means there could still be a page which is pinned.
> +	 */
> +	if (free_hpage_a != free_hpage_b) {
> +		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
> +		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
> +		ksft_test_result_fail(": Huge pages not freed!\n");
> +	} else {
> +		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
> +		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
> +		ksft_test_result_pass(": Huge pages freed successfully !\n");
> +	}
> +}
> +
> +int main(void)
> +{
> +	size_t pagesize = 0;
> +
> +	ksft_print_header();
> +	ksft_set_plan(4);
> +
> +	/* Get base page size */
> +	pagesize  = psize();
> +
> +	/* start and end is aligned to pagesize */
> +	run_dio_using_hugetlb(0, (pagesize * 3));
> +
> +	/* start is aligned but end is not aligned */
> +	run_dio_using_hugetlb(0, (pagesize * 3) - (pagesize / 2));
> +
> +	/* start is unaligned and end is aligned */
> +	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3));
> +
> +	/* both start and end are unaligned */
> +	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3) + (pagesize / 2));
> +
> +	ksft_finished();
> +}
> +

-- 
BR,
Muhammad Usama Anjum

