Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D07DF247
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 13:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346859AbjKBMYz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbjKBMYy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 08:24:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DEAF136;
        Thu,  2 Nov 2023 05:24:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64CA42F4;
        Thu,  2 Nov 2023 05:25:32 -0700 (PDT)
Received: from [10.1.33.173] (XHFQ2J9959.cambridge.arm.com [10.1.33.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D7C33F67D;
        Thu,  2 Nov 2023 05:24:48 -0700 (PDT)
Message-ID: <662df57e-47f1-4c15-9b84-f2f2d587fc5c@arm.com>
Date:   Thu, 2 Nov 2023 12:24:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/mm: Add a new test for madv and hugetlb
Content-Language: en-GB
To:     Breno Leitao <leitao@debian.org>, mike.kravetz@oracle.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, riel@surriel.com,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20231005163922.87568-1-leitao@debian.org>
 <20231005163922.87568-3-leitao@debian.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231005163922.87568-3-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Breno,


On 05/10/2023 17:39, Breno Leitao wrote:
> Create a selftest that exercises the race between page faults and
> madvise(MADV_DONTNEED) in the same huge page. Do it by running two
> threads that touches the huge page and madvise(MADV_DONTNEED) at the same
> time.
> 
> In case of a SIGBUS coming at pagefault, the test should fail, since we
> hit the bug.
> 
> The test doesn't have a signal handler, and if it fails, it fails like
> the following
> 
>   ----------------------------------
>   running ./hugetlb_fault_after_madv
>   ----------------------------------
>   ./run_vmtests.sh: line 186: 595563 Bus error    (core dumped) "$@"
>   [FAIL]
> 
> This selftest goes together with the fix of the bug[1] itself.
> 
> [1] https://lore.kernel.org/all/20231001005659.2185316-1-riel@surriel.com/#r
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/mm/Makefile           |  1 +
>  .../selftests/mm/hugetlb_fault_after_madv.c   | 73 +++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh     |  4 +
>  3 files changed, 78 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 6a9fc5693145..e71ec9910c62 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -68,6 +68,7 @@ TEST_GEN_FILES += split_huge_page_test
>  TEST_GEN_FILES += ksm_tests
>  TEST_GEN_FILES += ksm_functional_tests
>  TEST_GEN_FILES += mdwe_test
> +TEST_GEN_FILES += hugetlb_fault_after_madv
>  
>  ifneq ($(ARCH),arm64)
>  TEST_GEN_PROGS += soft-dirty
> diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> new file mode 100644
> index 000000000000..73b81c632366
> --- /dev/null
> +++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <pthread.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "vm_util.h"
> +#include "../kselftest.h"
> +
> +#define MMAP_SIZE (1 << 21)
> +#define INLOOP_ITER 100
> +
> +char *huge_ptr;
> +
> +/* Touch the memory while it is being madvised() */
> +void *touch(void *unused)
> +{
> +	char *ptr = (char *)huge_ptr;
> +
> +	for (int i = 0; i < INLOOP_ITER; i++)
> +		ptr[0] = '.';
> +
> +	return NULL;
> +}
> +
> +void *madv(void *unused)
> +{
> +	usleep(rand() % 10);
> +
> +	for (int i = 0; i < INLOOP_ITER; i++)
> +		madvise(huge_ptr, MMAP_SIZE, MADV_DONTNEED);
> +
> +	return NULL;
> +}
> +
> +int main(void)
> +{
> +	unsigned long free_hugepages;
> +	pthread_t thread1, thread2;
> +	/*
> +	 * On kernel 6.4, we are able to reproduce the problem with ~1000
> +	 * interactions
> +	 */
> +	int max = 10000;
> +
> +	srand(getpid());
> +
> +	free_hugepages = get_free_hugepages();
> +	if (free_hugepages != 1) {
> +		ksft_exit_skip("This test needs one and only one page to execute. Got %lu\n",
> +			       free_hugepages);
> +	}
> +
> +	while (max--) {
> +		huge_ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
> +				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +				-1, 0);
> +
> +		if ((unsigned long)huge_ptr == -1)
> +			ksft_exit_skip("Failed to allocated huge page\n");
> +
> +		pthread_create(&thread1, NULL, madv, NULL);
> +		pthread_create(&thread2, NULL, touch, NULL);
> +
> +		pthread_join(thread1, NULL);
> +		pthread_join(thread2, NULL);
> +		munmap(huge_ptr, MMAP_SIZE);
> +	}
> +
> +	return KSFT_PASS;
> +}
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 3e2bc818d566..9f53f7318a38 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -221,6 +221,10 @@ CATEGORY="hugetlb" run_test ./hugepage-mremap
>  CATEGORY="hugetlb" run_test ./hugepage-vmemmap
>  CATEGORY="hugetlb" run_test ./hugetlb-madvise
>  
> +# For this test, we need one and just one huge page
> +echo 1 > /proc/sys/vm/nr_hugepages

I've noticed that this change breaks some of the uffd-stress tests further down
the file, because you have freed previously reserved hugepages that the test
requires to run. I notice that the patch is already in mm-stable, so perhaps its
possible to submit a patch that does a save and restore?

Although I'm not sure if that might be tricky because the previous reservation
is per-size and per-node (our CI does this on the kernel command line), and I
suspect if you want just 1 huge page in the entire system you won't be able to
get back to the previous state by just restoring this value?

These are the failing tests for reference:

# ------------------------------------
# running ./uffd-stress hugetlb 128 32
# ------------------------------------
# nr_pages: 64, nr_pages_per_cpu: 8
# ERROR: context init failed (errno=12, @uffd-stress.c:254)
# [FAIL]
# --------------------------------------------
# running ./uffd-stress hugetlb-private 128 32
# --------------------------------------------
# nr_pages: 64, nr_pages_per_cpu: 8
# ERROR: context init failed (errno=12, @uffd-stress.c:254)
# [FAIL]

Thanks,
Ryan



> +CATEGORY="hugetlb" run_test ./hugetlb_fault_after_madv
> +
>  if test_selected "hugetlb"; then
>  	echo "NOTE: These hugetlb tests provide minimal coverage.  Use"
>  	echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"

