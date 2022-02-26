Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493C54C52B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 01:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiBZAgQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 19:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiBZAgP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 19:36:15 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C73184B78
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 16:35:42 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v5so5602609ilm.9
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 16:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJ+m4tX6Yk7/lEAxWMyNHmunn/51cFADo2dy4pCchSU=;
        b=SC+79IGHFQd7ZcRRwYHkyA3fmPwXFfL/RGcwmgOYM2lS1l3L9UKhX9vWFrWCFyoFIB
         WqHA9CggxEbmKR8a3RnMC5+wkvPXaEEzeJgNv1wxfqc0y2QXujiVK0wLB6jk/ws+MlBg
         Kzbw1g6VeIru8FWic3os/EXccppsnIvWxkP7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJ+m4tX6Yk7/lEAxWMyNHmunn/51cFADo2dy4pCchSU=;
        b=ixoKgJEJtNTalV9BFv32B1LBcFwqA0GuntkTfTHj/aFDs0F0X7NvHtmofHcc8rzgi7
         x9P5DeUhPGAXrCRLXliSO+NYTVCzx0+GN+0D5Ijs8mIfTopx763jID4HYnp/cIYedueR
         53PadD+knJ3fnzSk3MMkPjLEjkFah4hQWi54GsZmA9NltXjbba1Wi9zeD0XYzave3V6i
         ZYC5K62siLfbBLpqDqQ8OCEc96/IUUJ6Fjd5P5Te++7by8dLJVGqVso+gqo+tbHBlu91
         Wbn1yKBikHfTfLUxfz2m+h6/lQDC2sofn7pI2vUzD5ceo6LUhQWC3yfsWee703VZYjRz
         Sv4w==
X-Gm-Message-State: AOAM530cxIejcc+TJZylwWn4zONRmnGDfZgEkk1q0VoliYc6V8pwBsR1
        xL0ZFftIqhfIuGZBDhudH0lKqw==
X-Google-Smtp-Source: ABdhPJw7CawhavPx2deGXh0nvprWXYD3i7XtDu1IlUhG8GWwE/QvGjeMsw+D+vykzt5qsyNYeH6Skg==
X-Received: by 2002:a05:6e02:1ba5:b0:2c2:b1a8:efcf with SMTP id n5-20020a056e021ba500b002c2b1a8efcfmr3812911ili.20.1645835741593;
        Fri, 25 Feb 2022 16:35:41 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w19-20020a056602035300b006390eea5d28sm2429057iou.42.2022.02.25.16.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 16:35:40 -0800 (PST)
Subject: Re: [PATCH V3] selftests: vm: Add test for Soft-Dirty PTE bit
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        Will Deacon <will@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220224212335.3045905-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <edf398a7-b1a1-c7c9-5128-f37cfc3a5c95@linuxfoundation.org>
Date:   Fri, 25 Feb 2022 17:35:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220224212335.3045905-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/24/22 2:23 PM, Muhammad Usama Anjum wrote:
> This introduces three tests:
> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
> check if the SD bit flipped.
> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
> 3) Check soft-dirty on huge pages
> 
> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
> same issue that he fixed, and this test would have caught it.
> 
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in V3:
> Move test to selftests/vm
> Use kselftest macros
> Minor updates to make code more maintainable
> Add configurations in config file
> 
> Tests of soft dirty bit in this patch and in
> selftest/vm/madv_populate.c are non-overlapping.
> 
> V2 of this patch:
> https://lore.kernel.org/lkml/20210603151518.2437813-1-krisman@collabora.com/
> ---
>   tools/testing/selftests/vm/.gitignore   |   1 +
>   tools/testing/selftests/vm/Makefile     |   1 +
>   tools/testing/selftests/vm/config       |   2 +
>   tools/testing/selftests/vm/soft-dirty.c | 238 ++++++++++++++++++++++++
>   4 files changed, 242 insertions(+)
>   create mode 100644 tools/testing/selftests/vm/soft-dirty.c
> 
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index d7507f3c7c76..3cb4fa771ec2 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -29,5 +29,6 @@ write_to_hugetlbfs
>   hmm-tests
>   memfd_secret
>   local_config.*
> +soft-dirty
>   split_huge_page_test
>   ksm_tests
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 5e43f072f5b7..de9b13d018c3 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -47,6 +47,7 @@ TEST_GEN_FILES += on-fault-limit
>   TEST_GEN_FILES += thuge-gen
>   TEST_GEN_FILES += transhuge-stress
>   TEST_GEN_FILES += userfaultfd
> +TEST_GEN_FILES += soft-dirty
>   TEST_GEN_FILES += split_huge_page_test
>   TEST_GEN_FILES += ksm_tests
>   
> diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm/config
> index 60e82da0de85..be087c4bc396 100644
> --- a/tools/testing/selftests/vm/config
> +++ b/tools/testing/selftests/vm/config
> @@ -4,3 +4,5 @@ CONFIG_TEST_VMALLOC=m
>   CONFIG_DEVICE_PRIVATE=y
>   CONFIG_TEST_HMM=m
>   CONFIG_GUP_TEST=y
> +CONFIG_TRANSPARENT_HUGEPAGE=y
> +CONFIG_MEM_SOFT_DIRTY=y
> diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
> new file mode 100644
> index 000000000000..f56c215e0ece
> --- /dev/null
> +++ b/tools/testing/selftests/vm/soft-dirty.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <malloc.h>
> +#include <sys/mman.h>
> +#include "../kselftest.h"
> +
> +#define PAGEMAP_PATH		"/proc/self/pagemap"

Why is this names PATH - it is the file name right?

> +#define CLEAR_REFS_PATH		"/proc/self/clear_refs"

Same here  - why is this named _PATH?

Let's line these defines up - makes it easier to read

> +#define SMAP_PATH		"/proc/self/smaps"

Same here - why is this named _PATH?

> +#define PMD_SIZE_PATH		"/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"

Same  here  - why is this named _PATH?

> +#define MAX_LINE_LENGTH		512
> +#define TEST_ITERATIONS		10000
> +#define PAGE_NUM_TO_TEST	2
> +
> +int clear_refs;
> +int pagemap;
> +

Get rid of these globals and pass these in - please find name
that clearly indicates them as fds

> +int pagesize;
> +int mmap_size;	/* Size of test region */

Get rid of these globals and pass these in - please find name
that clearly indicates

> +
> +static void clear_all_refs(void)
> +{
> +	const char *ctrl = "4";
> +
> +	if (write(clear_refs, ctrl, strlen(ctrl)) != strlen(ctrl))
> +		ksft_exit_fail_msg("%s: failed to clear references\n", __func__);
> +}
> +
> +static void touch_page(char *map, int n)
> +{
> +	map[(pagesize * n) + 1]++;
> +}
> +
> +static int check_page(char *start, int page_num, int clear)
> +{
> +	unsigned long pfn = (unsigned long)start / pagesize;
> +	uint64_t entry;
> +	int ret;
> +
> +	ret = pread(pagemap, &entry, sizeof(entry), (pfn + page_num) * sizeof(entry));
> +	if (ret != sizeof(entry))
> +		ksft_exit_fail_msg("reading pagemap failed\n");
> +	if (clear)
> +		clear_all_refs();
> +
> +	return ((entry >> 55) & 1);

Add a define for 55 insead of hardcoding with a meaningful name
that describes what this value is.

> +}
> +
> +static void test_simple(void)
> +{
> +	int i;
> +	char *map;
> +
> +	map = aligned_alloc(pagesize, mmap_size);
> +	if (!map)
> +		ksft_exit_fail_msg("mmap failed\n");
> +
> +	clear_all_refs();

If clear_all_refs() fails and exits, when does map get freed?

> +
> +	for (i = 0 ; i < TEST_ITERATIONS; i++) {
> +		if (check_page(map, PAGE_NUM_TO_TEST, 1) == 1) {
> +			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
> +			break;
> +		}
> +
> +		touch_page(map, 2);
> +
> +		if (check_page(map, PAGE_NUM_TO_TEST, 1) == 0) {
> +			ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
> +			break;
> +		}
> +
> +	}
> +	free(map);
> +
> +	ksft_test_result(i == TEST_ITERATIONS, "Test %s\n", __func__);
> +}
> +
> +static void test_vma_reuse(void)
> +{
> +	char *map, *map2;
> +
> +	map = (char *) 0x900000000000;
> +	map = mmap(map, mmap_size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
> +	if (map == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap failed");
> +
> +	clear_all_refs();
> +	touch_page(map, PAGE_NUM_TO_TEST);
> +
> +	munmap(map, mmap_size);
> +	map2 = mmap(map, mmap_size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
> +	if (map2 == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap failed");
> +
> +	ksft_test_result(map == map2, "Test %s reused memory location\n", __func__);
> +
> +	ksft_test_result(check_page(map, PAGE_NUM_TO_TEST, 1) != 0,
> +			 "Test %s dirty bit of previous page\n", __func__);
> +
> +	munmap(map2, mmap_size);
> +}
> +
> +/*
> + * read_pmd_pagesize(), check_for_pattern() and check_huge() adapted
> + * from 'tools/testing/selftest/vm/split_huge_page_test.c'

Don't use the full path here - just use the file name

> + */
> +static uint64_t read_pmd_pagesize(void)
> +{
> +	int fd;
> +	char buf[20];
> +	ssize_t num_read;
> +
> +	fd = open(PMD_SIZE_PATH, O_RDONLY);
> +	if (fd == -1)
> +		ksft_exit_fail_msg("Open hpage_pmd_size failed\n");
> +
> +	num_read = read(fd, buf, 19);
> +	if (num_read < 1) {
> +		close(fd);
> +		ksft_exit_fail_msg("Read hpage_pmd_size failed\n");
> +	}
> +	buf[num_read] = '\0';
> +	close(fd);
> +
> +	return strtoul(buf, NULL, 10);
> +}
> +
> +static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
> +{
> +	while (fgets(buf, MAX_LINE_LENGTH, fp) != NULL) {
> +		if (!strncmp(buf, pattern, strlen(pattern)))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static uint64_t check_huge(void *addr)
> +{
> +	uint64_t thp = 0;
> +	int ret;
> +	FILE *fp;
> +	char buffer[MAX_LINE_LENGTH];
> +	char addr_pattern[MAX_LINE_LENGTH];
> +
> +	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
> +		       (unsigned long) addr);
> +	if (ret >= MAX_LINE_LENGTH)
> +		ksft_print_msg("%s: Pattern is too long\n", __func__);

Okay. Pattern is too log - does the test continue?

> +
> +	fp = fopen(SMAP_PATH, "r");
> +	if (!fp)
> +		ksft_print_msg("%s: Failed to open file %s\n", __func__, SMAP_PATH);

Same commnet about root user


> +
> +	if (!check_for_pattern(fp, addr_pattern, buffer))
> +		goto err_out;
> +
> +	/*
> +	 * Fetch the AnonHugePages: in the same block and check the number of
> +	 * hugepages.
> +	 */
> +	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
> +		goto err_out;
> +
> +	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) != 1)
> +		ksft_print_msg("Reading smap error\n");
> +
> +err_out:
> +	fclose(fp);
> +
> +	return thp;
> +}
> +
> +static void test_hugepage(void)
> +{
> +	char *map;
> +	int i, ret;
> +	size_t hpage_len = read_pmd_pagesize();
> +
> +	map = memalign(hpage_len, hpage_len);
> +	if (!map)
> +		ksft_exit_fail_msg("memalign failed\n");
> +
> +	ret = madvise(map, hpage_len, MADV_HUGEPAGE);
> +	if (ret)
> +		ksft_exit_fail_msg("madvise failed %d\n", ret);
> +
> +	for (i = 0; i < hpage_len; i++)
> +		map[i] = (char)i;
> +
> +	ksft_test_result(check_huge(map), "Test %s huge page allocation\n", __func__);
> +
> +	clear_all_refs();
> +	for (i = 0 ; i < TEST_ITERATIONS ; i++) {
> +		if (check_page(map, PAGE_NUM_TO_TEST, 1) == 1) {
> +			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
> +			break;
> +		}
> +
> +		touch_page(map, PAGE_NUM_TO_TEST);
> +
> +		if (check_page(map, PAGE_NUM_TO_TEST, 1) == 0) {
> +			ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
> +			break;
> +		}
> +	}
> +
> +	ksft_test_result(i == TEST_ITERATIONS, "Test %s dirty bit\n", __func__);
> +
> +	munmap(map, mmap_size);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	ksft_print_header();
> +	ksft_set_plan(5);
> +
> +	pagemap = open(PAGEMAP_PATH, O_RDONLY);
> +	if (pagemap < 0)
> +		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_PATH);

Can non-root user open this file? If not, when non-root user fails to
open, it is a skip not fail

> +
> +	clear_refs = open(CLEAR_REFS_PATH, O_WRONLY);
> +	if (clear_refs < 0)
> +		ksft_exit_fail_msg("Failed to open %s\n", CLEAR_REFS_PATH);

Same comment as above here

Also why would you want to define clear_refs as global? Why not define it
here - make it clear that it is fd

> +
> +	pagesize = getpagesize();

Why is pagesize global?

> +	mmap_size = 10 * pagesize;

Same here?

> +
> +	test_simple();
> +	test_vma_reuse();
> +	test_hugepage();

What happens when these tests fail?

> +
> +	return ksft_exit_pass();
> +}
> 

Where do CLEAR_REFS_PATH etc. get closed. Please take a look
at the error paths carefully. I would like to see the output for
this test. Please include it in the change log.

thanks,
-- Shuah
