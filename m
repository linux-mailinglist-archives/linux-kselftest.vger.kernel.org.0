Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF0A7D117D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377557AbjJTOYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 10:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377523AbjJTOYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 10:24:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8273FD52;
        Fri, 20 Oct 2023 07:24:26 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.188.12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68A416600359;
        Fri, 20 Oct 2023 15:24:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697811864;
        bh=WnxVsQr+uvkEn8xW245M1kpuzVar8Ggd+6D0ZK8A9PM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ExFK5spXFEfxH+JRvl4kgSb4OZbURHs2qlpKUKlx0Z5mpjDgCYYKv+DWapKXh7nJW
         Akt6xuAPyXMa6m9CJjGyF3kskAB/9L2iOqvtpxMY013mh4fl3vpu8600PHGSM7Dgfp
         H3RBplPzcMgHWHSoz08to2Qs2Ywc9hqfxDd75ujDbeukXCmAnOm5pG7uLkJ1jwetFW
         qD01Eof6SRNcGV4KNNXe4Tm0M6w44ArD+CfXY2m9dC0ZZGYN5lVD3FyNFBcw7ff+Su
         vAT+Fn8DK7QF1FztbOsLaARdRwLpKNjE5wK5ENjeQwYgpqFxSloo//qX3GuA9uwC3O
         Bztv8xZBzlptQ==
Message-ID: <3cf29cd5-8346-419f-88f1-3a5c8ddbacad@collabora.com>
Date:   Fri, 20 Oct 2023 19:24:03 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v2 8/8] selftest mm/mseal mprotect/munmap/mremap/mmap
Content-Language: en-US
To:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org
References: <20231017090815.1067790-1-jeffxu@chromium.org>
 <20231017090815.1067790-9-jeffxu@chromium.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231017090815.1067790-9-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/23 2:08 PM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> selftest for sealing mprotect/munmap/mremap/mmap
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  tools/testing/selftests/mm/Makefile     |    1 +
>  tools/testing/selftests/mm/mseal_test.c | 1428 +++++++++++++++++++++++
Please add the new MSEAL config to tools/testing/selftests/mm/config.
Please add the generated object in tools/testing/selftests/mm/.gitignore file.

>  2 files changed, 1429 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/mseal_test.c
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 6a9fc5693145..0c086cecc093 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -59,6 +59,7 @@ TEST_GEN_FILES += mlock2-tests
>  TEST_GEN_FILES += mrelease_test
>  TEST_GEN_FILES += mremap_dontunmap
>  TEST_GEN_FILES += mremap_test
> +TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> new file mode 100644
> index 000000000000..d6ae09729394
> --- /dev/null
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -0,0 +1,1428 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <sys/mman.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +#include <stdbool.h>
> +#include "../kselftest.h"
> +#include <syscall.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <assert.h>
> +
> +#ifndef MM_SEAL_MSEAL
> +#define MM_SEAL_MSEAL 0x1
> +#endif
> +
> +#ifndef MM_SEAL_MPROTECT
> +#define MM_SEAL_MPROTECT 0x2
> +#endif
> +
> +#ifndef MM_SEAL_MUNMAP
> +#define MM_SEAL_MUNMAP 0x4
> +#endif
> +
> +#ifndef MM_SEAL_MMAP
> +#define MM_SEAL_MMAP 0x8
> +#endif
> +
> +#ifndef MM_SEAL_MREMAP
> +#define MM_SEAL_MREMAP 0x10
> +#endif
Please remove these. These macros would be picked up from the kernel
headers automatically.

> +
> +#ifndef DEBUG
> +#define LOG_TEST_ENTER()	{}
> +#else
> +#define LOG_TEST_ENTER()	{ printf("%s\n", __func__); }
> +#endif
> +
> +static int sys_mseal(void *start, size_t len, int types)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(__NR_mseal, start, len, types, 0);
> +	return sret;
> +}
> +
> +int sys_mprotect(void *ptr, size_t size, unsigned long prot)
Why aren't you using the mprotect() wrapper already provided by glibC? Same
question for other syscalls. Maybe you are trying to avoid some glibc magic?

> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(SYS_mprotect, ptr, size, prot);
> +	return sret;
> +}
> +
> +int sys_munmap(void *ptr, size_t size)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(SYS_munmap, ptr, size);
> +	return sret;
> +}
> +
> +static int sys_madvise(void *start, size_t len, int types)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(__NR_madvise, start, len, types);
> +	return sret;
> +}
> +
> +void *addr1 = (void *)0x50000000;
> +void *addr2 = (void *)0x50004000;
> +void *addr3 = (void *)0x50008000;
> +void setup_single_address(int size, void **ptrOut)
> +{
> +	void *ptr;
> +
> +	ptr = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	assert(ptr != (void *)-1);
MAP_FAILED inlace of -1

> +	*ptrOut = ptr;
> +}
> +
> +void setup_single_fixed_address(int size, void **ptrOut)
> +{
> +	void *ptr;
> +
> +	ptr = mmap(addr1, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	assert(ptr == (void *)addr1);
> +
> +	*ptrOut = ptr;
> +}
> +
> +void clean_single_address(void *ptr, int size)
> +{
> +	int ret;
> +
> +	ret = munmap(ptr, size);
> +	assert(!ret);
> +}
> +
> +void seal_mprotect_single_address(void *ptr, int size)
> +{
> +	int ret;
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MPROTECT);
> +	assert(!ret);
> +}
> +
> +static void test_seal_addseals(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	/* adding seal one by one */
> +	ret = sys_mseal(ptr, size, MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MMAP);
> +	assert(!ret);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MREMAP);
> +	assert(!ret);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_addseals_combined(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	/* adding multiple seals */
> +	ret = sys_mseal(ptr, size,
> +			MM_SEAL_MPROTECT | MM_SEAL_MMAP | MM_SEAL_MREMAP |
> +			MM_SEAL_MSEAL);
> +	assert(!ret);
The output should be conformed to the kselftets output format by using
ksft_exit_fail_msg() and ksft_test_result*() macros etc. Please find these
macros in kselftest.h.

> +
> +	/* not adding more seal type, so ok. */
> +	ret = sys_mseal(ptr, size,
> +			MM_SEAL_MMAP | MM_SEAL_MREMAP | MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	/* not adding more seal type, so ok. */
> +	ret = sys_mseal(ptr, size, MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_addseals_reject(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MPROTECT | MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	/* MM_SEAL_MSEAL is set, so not allow new seal type . */
> +	ret = sys_mseal(ptr, size,
> +			MM_SEAL_MPROTECT | MM_SEAL_MMAP | MM_SEAL_MSEAL);
> +	assert(ret < 0);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MMAP);
> +	assert(ret < 0);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MMAP | MM_SEAL_MSEAL);
> +	assert(ret < 0);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_unmapped_start(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// munmap 2 pages from ptr.
Use consistent commenting style in the file.

> +	ret = sys_munmap(ptr, 2 * page_size);
> +	assert(!ret);
> +
> +	// mprotect will fail because 2 pages from ptr are unmapped.
> +	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> +	assert(ret < 0);
> +
> +	// mseal will fail because 2 pages from ptr are unmapped.
> +	ret = sys_mseal(ptr, size, MM_SEAL_MSEAL);
> +	assert(ret < 0);
> +
> +	ret = sys_mseal(ptr + 2 * page_size, 2 * page_size, MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_unmapped_middle(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// munmap 2 pages from ptr + page.
> +	ret = sys_munmap(ptr + page_size, 2 * page_size);
> +	assert(!ret);
> +
> +	// mprotect will fail, since size is 4 pages.
> +	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> +	assert(ret < 0);
> +
> +	// mseal will fail as well.
> +	ret = sys_mseal(ptr, size, MM_SEAL_MSEAL);
> +	assert(ret < 0);
> +
> +	/* we still can add seal to the first page and last page*/
> +	ret = sys_mseal(ptr, page_size, MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	ret = sys_mseal(ptr + 3 * page_size, page_size,
> +			MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_unmapped_end(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// unmap last 2 pages.
> +	ret = sys_munmap(ptr + 2 * page_size, 2 * page_size);
> +	assert(!ret);
> +
> +	//mprotect will fail since last 2 pages are unmapped.
> +	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> +	assert(ret < 0);
> +
> +	//mseal will fail as well.
> +	ret = sys_mseal(ptr, size, MM_SEAL_MSEAL);
> +	assert(ret < 0);
> +
> +	/* The first 2 pages is not sealed, and can add seals */
> +	ret = sys_mseal(ptr, 2 * page_size, MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_multiple_vmas(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// use mprotect to split the vma into 3.
> +	ret = sys_mprotect(ptr + page_size, 2 * page_size,
> +			PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	// mprotect will get applied to all 4 pages - 3 VMAs.
> +	ret = sys_mprotect(ptr, size, PROT_READ);
> +	assert(!ret);
> +
> +	// use mprotect to split the vma into 3.
> +	ret = sys_mprotect(ptr + page_size, 2 * page_size,
> +			PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	// mseal get applied to all 4 pages - 3 VMAs.
> +	ret = sys_mseal(ptr, size, MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	// verify additional seal type will fail after MM_SEAL_MSEAL set.
> +	ret = sys_mseal(ptr, page_size, MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(ret < 0);
> +
> +	ret = sys_mseal(ptr + page_size, 2 * page_size,
> +			MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(ret < 0);
> +
> +	ret = sys_mseal(ptr + 3 * page_size, page_size,
> +			MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(ret < 0);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_split_start(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	/* use mprotect to split at middle */
> +	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	/* seal the first page, this will split the VMA */
> +	ret = sys_mseal(ptr, page_size, MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	/* can't add seal to the first page */
> +	ret = sys_mseal(ptr, page_size, MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(ret < 0);
> +
> +	/* add seal to the remain 3 pages */
> +	ret = sys_mseal(ptr + page_size, 3 * page_size,
> +			MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_split_end(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_fixed_address(size, &ptr);
> +
> +	/* use mprotect to split at middle */
> +	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	/* seal the last page */
> +	ret = sys_mseal(ptr + 3 * page_size, page_size, MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	/* adding seal to the last page is rejected. */
> +	ret = sys_mseal(ptr + 3 * page_size, page_size,
> +			MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(ret < 0);
> +
> +	/* Adding seals to the first 3 pages */
> +	ret = sys_mseal(ptr, 3 * page_size, MM_SEAL_MSEAL | MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_invalid_input(void)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_fixed_address(size, &ptr);
> +
> +	/* invalid flag */
> +	ret = sys_mseal(ptr, size, 0x20);
> +	assert(ret < 0);
> +
> +	ret = sys_mseal(ptr, size, 0x31);
> +	assert(ret < 0);
> +
> +	ret = sys_mseal(ptr, size, 0x3F);
> +	assert(ret < 0);
> +
> +	/* unaligned address */
> +	ret = sys_mseal(ptr + 1, 2 * page_size, MM_SEAL_MSEAL);
> +	assert(ret < 0);
> +
> +	/* length too big */
> +	ret = sys_mseal(ptr, 5 * page_size, MM_SEAL_MSEAL);
> +	assert(ret < 0);
> +
> +	/* start is not in a valid VMA */
> +	ret = sys_mseal(ptr - page_size, 5 * page_size, MM_SEAL_MSEAL);
> +	assert(ret < 0);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_zero_length(void)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	ret = sys_mprotect(ptr, 0, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	/* seal 0 length will be OK, same as mprotect */
> +	ret = sys_mseal(ptr, 0, MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	// verify the 4 pages are not sealed by previous call.
> +	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_twice(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	// apply the same seal will be OK. idempotent.
> +	ret = sys_mseal(ptr, size, MM_SEAL_MPROTECT);
> +	assert(!ret);
> +
> +	ret = sys_mseal(ptr, size,
> +			MM_SEAL_MPROTECT | MM_SEAL_MMAP | MM_SEAL_MREMAP |
> +			MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	ret = sys_mseal(ptr, size,
> +			MM_SEAL_MPROTECT | MM_SEAL_MMAP | MM_SEAL_MREMAP |
> +			MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_MSEAL);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_mprotect(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal)
> +		seal_mprotect_single_address(ptr, size);
> +
> +	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_start_mprotect(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal)
> +		seal_mprotect_single_address(ptr, page_size);
> +
> +	// the first page is sealed.
> +	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	// pages after the first page is not sealed.
> +	ret = sys_mprotect(ptr + page_size, page_size * 3,
> +			PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_end_mprotect(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal)
> +		seal_mprotect_single_address(ptr + page_size, 3 * page_size);
> +
> +	/* first page is not sealed */
> +	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	/* last 3 page are sealed */
> +	ret = sys_mprotect(ptr + page_size, page_size * 3,
> +			PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_mprotect_unalign_len(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal)
> +		seal_mprotect_single_address(ptr, page_size * 2 - 1);
> +
> +	// 2 pages are sealed.
> +	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	ret = sys_mprotect(ptr + page_size * 2, page_size,
> +			PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_mprotect_unalign_len_variant_2(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +	if (seal)
> +		seal_mprotect_single_address(ptr, page_size * 2 + 1);
> +
> +	// 3 pages are sealed.
> +	ret = sys_mprotect(ptr, page_size * 3, PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	ret = sys_mprotect(ptr + page_size * 3, page_size,
> +			PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_mprotect_two_vma(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	/* use mprotect to split */
> +	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	if (seal)
> +		seal_mprotect_single_address(ptr, page_size * 4);
> +
> +	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	ret = sys_mprotect(ptr + page_size * 2, page_size * 2,
> +			PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_mprotect_two_vma_with_split(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// use mprotect to split as two vma.
> +	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	// mseal can apply across 2 vma, also split them.
> +	if (seal)
> +		seal_mprotect_single_address(ptr + page_size, page_size * 2);
> +
> +	// the first page is not sealed.
> +	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	// the second page is sealed.
> +	ret = sys_mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	// the third page is sealed.
> +	ret = sys_mprotect(ptr + 2 * page_size, page_size,
> +			PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	// the fouth page is not sealed.
> +	ret = sys_mprotect(ptr + 3 * page_size, page_size,
> +			PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_mprotect_partial_mprotect(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// seal one page.
> +	if (seal)
> +		seal_mprotect_single_address(ptr, page_size);
> +
> +	// mprotect first 2 page will fail, since the first page are sealed.
> +	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_mprotect_two_vma_with_gap(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// use mprotect to split.
> +	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	// use mprotect to split.
> +	ret = sys_mprotect(ptr + 3 * page_size, page_size,
> +			PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	// use munmap to free two pages in the middle
> +	ret = sys_munmap(ptr + page_size, 2 * page_size);
> +	assert(!ret);
> +
> +	// mprotect will fail, because there is a gap in the address.
> +	// notes, internally mprotect still updated the first page.
> +	ret = sys_mprotect(ptr, 4 * page_size, PROT_READ);
> +	assert(ret < 0);
> +
> +	// mseal will fail as well.
> +	ret = sys_mseal(ptr, 4 * page_size, MM_SEAL_MPROTECT);
> +	assert(ret < 0);
> +
> +	// unlike mprotect, the first page is not sealed.
> +	ret = sys_mprotect(ptr, page_size, PROT_READ);
> +	assert(ret == 0);
> +
> +	// the last page is not sealed.
> +	ret = sys_mprotect(ptr + 3 * page_size, page_size, PROT_READ);
> +	assert(ret == 0);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_mprotect_split(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	//use mprotect to split.
> +	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	//seal all 4 pages.
> +	if (seal) {
> +		ret = sys_mseal(ptr, 4 * page_size, MM_SEAL_MPROTECT);
> +		assert(!ret);
> +	}
> +
> +	//madvice is OK.
> +	ret = sys_madvise(ptr, page_size * 2, MADV_WILLNEED);
> +	assert(!ret);
> +
> +	//mprotect is sealed.
> +	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +
> +	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_mprotect_merge(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// use mprotect to split one page.
> +	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	// seal first two pages.
> +	if (seal) {
> +		ret = sys_mseal(ptr, 2 * page_size, MM_SEAL_MPROTECT);
> +		assert(!ret);
> +	}
> +
> +	ret = sys_madvise(ptr, page_size, MADV_WILLNEED);
> +	assert(!ret);
> +
> +	// 2 pages are sealed.
> +	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	// last 2 pages are not sealed.
> +	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
> +	assert(ret == 0);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +static void test_seal_munmap(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size, MM_SEAL_MUNMAP);
> +		assert(!ret);
> +	}
> +
> +	// 4 pages are sealed.
> +	ret = sys_munmap(ptr, size);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +}
> +
> +/*
> + * allocate 4 pages,
> + * use mprotect to split it as two VMAs
> + * seal the whole range
> + * munmap will fail on both
> + */
> +static void test_seal_munmap_two_vma(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	/* use mprotect to split */
> +	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> +	assert(!ret);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size, MM_SEAL_MUNMAP);
> +		assert(!ret);
> +	}
> +
> +	ret = sys_munmap(ptr, page_size * 2);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +
> +	ret = sys_munmap(ptr + page_size, page_size * 2);
> +	if (seal)
> +		assert(ret < 0);
> +	else
> +		assert(!ret);
> +}
> +
> +/*
> + * allocate a VMA with 4 pages.
> + * munmap the middle 2 pages.
> + * seal the whole 4 pages, will fail.
> + * note: one of the pages are sealed
> + * munmap the first page will be OK.
> + * munmap the last page will be OK.
> + */
> +static void test_seal_munmap_vma_with_gap(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	ret = sys_munmap(ptr + page_size, page_size * 2);
> +	assert(!ret);
> +
> +	if (seal) {
> +		// can't have gap in the middle.
> +		ret = sys_mseal(ptr, size, MM_SEAL_MUNMAP);
> +		assert(ret < 0);
> +	}
> +
> +	ret = sys_munmap(ptr, page_size);
> +	assert(!ret);
> +
> +	ret = sys_munmap(ptr + page_size * 2, page_size);
> +	assert(!ret);
> +
> +	ret = sys_munmap(ptr, size);
> +	assert(!ret);
> +}
> +
> +static void test_munmap_start_freed(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// unmap the first page.
> +	ret = sys_munmap(ptr, page_size);
> +	assert(!ret);
> +
> +	// seal the last 3 pages.
> +	if (seal) {
> +		ret = sys_mseal(ptr + page_size, 3 * page_size, MM_SEAL_MUNMAP);
> +		assert(!ret);
> +	}
> +
> +	// unmap from the first page.
> +	ret = sys_munmap(ptr, size);
> +	if (seal) {
> +		assert(ret < 0);
> +
> +		// use mprotect to verify page is not unmapped.
> +		ret = sys_mprotect(ptr + page_size, 3 * page_size, PROT_READ);
> +		assert(!ret);
> +	} else
> +		// note: this will be OK, even the first page is
> +		// already unmapped.
> +		assert(!ret);
> +}
> +
> +static void test_munmap_end_freed(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +	// unmap last page.
> +	ret = sys_munmap(ptr + page_size * 3, page_size);
> +	assert(!ret);
> +
> +	// seal the first 3 pages.
> +	if (seal) {
> +		ret = sys_mseal(ptr, 3 * page_size, MM_SEAL_MUNMAP);
> +		assert(!ret);
> +	}
> +
> +	// unmap all pages.
> +	ret = sys_munmap(ptr, size);
> +	if (seal) {
> +		assert(ret < 0);
> +
> +		// use mprotect to verify page is not unmapped.
> +		ret = sys_mprotect(ptr, 3 * page_size, PROT_READ);
> +		assert(!ret);
> +	} else
> +		assert(!ret);
> +}
> +
> +static void test_munmap_middle_freed(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +
> +	setup_single_address(size, &ptr);
> +	// unmap 2 pages in the middle.
> +	ret = sys_munmap(ptr + page_size, page_size * 2);
> +	assert(!ret);
> +
> +	// seal the first page.
> +	if (seal) {
> +		ret = sys_mseal(ptr, page_size, MM_SEAL_MUNMAP);
> +		assert(!ret);
> +	}
> +
> +	// munmap all 4 pages.
> +	ret = sys_munmap(ptr, size);
> +	if (seal) {
> +		assert(ret < 0);
> +
> +		// use mprotect to verify page is not unmapped.
> +		ret = sys_mprotect(ptr, page_size, PROT_READ);
> +		assert(!ret);
> +	} else
> +		assert(!ret);
> +}
> +
> +void test_seal_mremap_shrink(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size, MM_SEAL_MREMAP);
> +		assert(!ret);
> +	}
> +
> +	// shrink from 4 pages to 2 pages.
> +	ret2 = mremap(ptr, size, 2 * page_size, 0, 0);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else {
> +		assert(ret2 != MAP_FAILED);
> +		clean_single_address(ret2, 2 * page_size);
> +	}
> +	clean_single_address(ptr, size);
> +}
> +
> +void test_seal_mremap_expand(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(size, &ptr);
> +	// ummap last 2 pages.
> +	ret = sys_munmap(ptr + 2 * page_size, 2 * page_size);
> +	assert(!ret);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, 2 * page_size, MM_SEAL_MREMAP);
> +		assert(!ret);
> +	}
> +
> +	// expand from 2 page to 4 pages.
> +	ret2 = mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else {
> +		assert(ret2 == ptr);
> +		clean_single_address(ret2, 4 * page_size);
> +	}
> +	clean_single_address(ptr, size);
> +}
> +
> +void test_seal_mremap_move(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(size, &ptr);
> +	if (seal) {
> +		ret = sys_mseal(ptr, size, MM_SEAL_MREMAP);
> +		assert(!ret);
> +	}
> +
> +	// move from ptr to fixed address.
> +	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, addr1);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else {
> +		assert(ret2 != MAP_FAILED);
> +		clean_single_address(ret2, size);
> +	}
> +	clean_single_address(ptr, size);
> +}
> +
> +void test_seal_mmap_overwrite_prot(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size, MM_SEAL_MMAP);
> +		assert(!ret);
> +	}
> +
> +	// use mmap to change protection.
> +	ret2 = mmap(ptr, size, PROT_NONE,
> +			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else
> +		assert(ret2 == ptr);
> +
> +	clean_single_address(ptr, size);
> +}
> +
> +void test_seal_mremap_shrink_fixed(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	void *newAddr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(size, &ptr);
> +	setup_single_fixed_address(size, &newAddr);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size, MM_SEAL_MREMAP);
> +		assert(!ret);
> +	}
> +
> +	// mremap to move and shrink to fixed address
> +	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
> +			newAddr);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else
> +		assert(ret2 == newAddr);
> +
> +	clean_single_address(ptr, size);
> +	clean_single_address(newAddr, size);
> +}
> +
> +void test_seal_mremap_expand_fixed(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	void *newAddr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(page_size, &ptr);
> +	setup_single_fixed_address(size, &newAddr);
> +
> +	if (seal) {
> +		ret = sys_mseal(newAddr, size, MM_SEAL_MREMAP);
> +		assert(!ret);
> +	}
> +
> +	// mremap to move and expand to fixed address
> +	ret2 = mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
> +			newAddr);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else
> +		assert(ret2 == newAddr);
> +
> +	clean_single_address(ptr, page_size);
> +	clean_single_address(newAddr, size);
> +}
> +
> +void test_seal_mremap_move_fixed(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	void *newAddr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(size, &ptr);
> +	setup_single_fixed_address(size, &newAddr);
> +
> +	if (seal) {
> +		ret = sys_mseal(newAddr, size, MM_SEAL_MREMAP);
> +		assert(!ret);
> +	}
> +
> +	// mremap to move to fixed address
> +	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else
> +		assert(ret2 == newAddr);
> +
> +	clean_single_address(ptr, page_size);
> +	clean_single_address(newAddr, size);
> +}
> +
> +void test_seal_mremap_move_fixed_zero(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	void *newAddr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size, MM_SEAL_MREMAP);
> +		assert(!ret);
> +	}
> +
> +	/*
> +	 * MREMAP_FIXED can move the mapping to zero address
> +	 */
> +	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
> +			0);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else {
> +		assert(ret2 == 0);
> +		clean_single_address(ret2, 2 * page_size);
> +	}
> +	clean_single_address(ptr, size);
> +}
> +
> +void test_seal_mremap_move_dontunmap(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	void *newAddr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size, MM_SEAL_MREMAP);
> +		assert(!ret);
> +	}
> +
> +	// mremap to move, and don't unmap src addr.
> +	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else {
> +		assert(ret2 != MAP_FAILED);
> +		clean_single_address(ret2, size);
> +	}
> +
> +	clean_single_address(ptr, page_size);
> +}
> +
> +void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
> +{
> +	LOG_TEST_ENTER();
> +	void *ptr;
> +	void *newAddr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int ret;
> +	void *ret2;
> +
> +	setup_single_address(size, &ptr);
> +
> +	if (seal) {
> +		ret = sys_mseal(ptr, size, MM_SEAL_MREMAP);
> +		assert(!ret);
> +	}
> +
> +	/*
> +	 * The 0xdeaddead should not have effect on dest addr
> +	 * when MREMAP_DONTUNMAP is set.
> +	 */
> +	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
> +			0xdeaddead);
> +	if (seal) {
> +		assert(ret2 == MAP_FAILED);
> +		assert(errno == EACCES);
> +	} else {
> +		assert(ret2 != MAP_FAILED);
> +		assert((long)ret2 != 0xdeaddead);
> +		clean_single_address(ret2, size);
> +	}
> +
> +	clean_single_address(ptr, page_size);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	test_seal_invalid_input();
> +	test_seal_addseals();
> +	test_seal_addseals_combined();
> +	test_seal_addseals_reject();
> +	test_seal_unmapped_start();
> +	test_seal_unmapped_middle();
> +	test_seal_unmapped_end();
> +	test_seal_multiple_vmas();
> +	test_seal_split_start();
> +	test_seal_split_end();
> +
> +	test_seal_zero_length();
> +	test_seal_twice();
> +
> +	test_seal_mprotect(false);
> +	test_seal_mprotect(true);
> +
> +	test_seal_start_mprotect(false);
> +	test_seal_start_mprotect(true);
> +
> +	test_seal_end_mprotect(false);
> +	test_seal_end_mprotect(true);
> +
> +	test_seal_mprotect_unalign_len(false);
> +	test_seal_mprotect_unalign_len(true);
> +
> +	test_seal_mprotect_unalign_len_variant_2(false);
> +	test_seal_mprotect_unalign_len_variant_2(true);
> +
> +	test_seal_mprotect_two_vma(false);
> +	test_seal_mprotect_two_vma(true);
> +
> +	test_seal_mprotect_two_vma_with_split(false);
> +	test_seal_mprotect_two_vma_with_split(true);
> +
> +	test_seal_mprotect_partial_mprotect(false);
> +	test_seal_mprotect_partial_mprotect(true);
> +
> +	test_seal_mprotect_two_vma_with_gap(false);
> +	test_seal_mprotect_two_vma_with_gap(true);
> +
> +	test_seal_mprotect_merge(false);
> +	test_seal_mprotect_merge(true);
> +
> +	test_seal_mprotect_split(false);
> +	test_seal_mprotect_split(true);
> +
> +	test_seal_munmap(false);
> +	test_seal_munmap(true);
> +	test_seal_munmap_two_vma(false);
> +	test_seal_munmap_two_vma(true);
> +	test_seal_munmap_vma_with_gap(false);
> +	test_seal_munmap_vma_with_gap(true);
> +
> +	test_munmap_start_freed(false);
> +	test_munmap_start_freed(true);
> +	test_munmap_middle_freed(false);
> +	test_munmap_middle_freed(true);
> +	test_munmap_end_freed(false);
> +	test_munmap_end_freed(true);
> +
> +	test_seal_mremap_shrink(false);
> +	test_seal_mremap_shrink(true);
> +	test_seal_mremap_expand(false);
> +	test_seal_mremap_expand(true);
> +	test_seal_mremap_move(false);
> +	test_seal_mremap_move(true);
> +
> +	test_seal_mremap_shrink_fixed(false);
> +	test_seal_mremap_shrink_fixed(true);
> +	test_seal_mremap_expand_fixed(false);
> +	test_seal_mremap_expand_fixed(true);
> +	test_seal_mremap_move_fixed(false);
> +	test_seal_mremap_move_fixed(true);
> +	test_seal_mremap_move_dontunmap(false);
> +	test_seal_mremap_move_dontunmap(true);
> +	test_seal_mremap_move_fixed_zero(false);
> +	test_seal_mremap_move_fixed_zero(true);
> +	test_seal_mremap_move_dontunmap_anyaddr(false);
> +	test_seal_mremap_move_dontunmap_anyaddr(true);
> +
> +	test_seal_mmap_overwrite_prot(false);
> +	test_seal_mmap_overwrite_prot(true);
> +
> +	printf("OK\n");
> +	return 0;
> +}

-- 
BR,
Muhammad Usama Anjum
