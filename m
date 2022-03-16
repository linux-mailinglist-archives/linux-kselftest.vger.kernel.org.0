Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BC64DB69F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 17:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357010AbiCPQso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiCPQso (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 12:48:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5AE2DD74;
        Wed, 16 Mar 2022 09:47:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id ABA771F444BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647449245;
        bh=Vt70eCSvc2zqki9hfDzcz6upXnG7HHuoQp1wXP5ezc4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=eTxFJlVOq7IEc/chB3Uc0RmKZ2SkSN0enFVgAdUsuPiFiB+9Ch094CE0i/7g6Pj9f
         mNSJ2JnthPnQqfJ+gKzNvn/zWwHHebMylOedAtQ7lPWawtW9kWfPtHx4B4wyT/ZovU
         0C8pv91Wrwg3YZm5KrLeD7pZBzvqgZ7iaTFkF4cPo+KMQWIwsqLLRXjTLRIV9bc4ps
         LuJM4AqH+O4KU7DMMlfhFLBs8mOqcyHBcuKa+W03GlDVRr9qUVBrwU4iqXcAgy3AeJ
         2uoyW80iKa4J7bLD6ehys30u5vjYtomA+i9HOQYmvIjwEFPLUz6jZQWCkZaJsqLTFB
         VU06/6q7RiUgQ==
Message-ID: <453bf08c-0110-03d9-7346-76a7c2118987@collabora.com>
Date:   Wed, 16 Mar 2022 21:47:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH V4 1/2] selftests: vm: bring common functions to a new
 file
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
References: <20220315085014.1047291-1-usama.anjum@collabora.com>
 <b47a93fe-da50-d0d4-be8f-87071bf181f9@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <b47a93fe-da50-d0d4-be8f-87071bf181f9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

Thank you for the review. I'll correct everything mentioned here in the
next iteration.

+[Gabriel]

On 3/16/22 1:55 PM, David Hildenbrand wrote:
> On 15.03.22 09:50, Muhammad Usama Anjum wrote:
>> Bring common functions to a new file. These functions can be used in the
>> new tests. This helps in code duplication.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/vm/Makefile           |   7 +-
>>  tools/testing/selftests/vm/madv_populate.c    |  34 +-----
>>  .../selftests/vm/split_huge_page_test.c       |  77 +------------
>>  tools/testing/selftests/vm/vm_util.c          | 103 ++++++++++++++++++
>>  tools/testing/selftests/vm/vm_util.h          |  15 +++
>>  5 files changed, 125 insertions(+), 111 deletions(-)
>>  create mode 100644 tools/testing/selftests/vm/vm_util.c
>>  create mode 100644 tools/testing/selftests/vm/vm_util.h
>>
>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
>> index 5e43f072f5b76..4e68edb26d6b6 100644
>> --- a/tools/testing/selftests/vm/Makefile
>> +++ b/tools/testing/selftests/vm/Makefile
>> @@ -34,7 +34,7 @@ TEST_GEN_FILES += hugepage-mremap
>>  TEST_GEN_FILES += hugepage-shm
>>  TEST_GEN_FILES += hugepage-vmemmap
>>  TEST_GEN_FILES += khugepaged
>> -TEST_GEN_FILES += madv_populate
>> +TEST_GEN_PROGS = madv_populate
>>  TEST_GEN_FILES += map_fixed_noreplace
>>  TEST_GEN_FILES += map_hugetlb
>>  TEST_GEN_FILES += map_populate
>> @@ -47,7 +47,7 @@ TEST_GEN_FILES += on-fault-limit
>>  TEST_GEN_FILES += thuge-gen
>>  TEST_GEN_FILES += transhuge-stress
>>  TEST_GEN_FILES += userfaultfd
>> -TEST_GEN_FILES += split_huge_page_test
>> +TEST_GEN_PROGS += split_huge_page_test
>>  TEST_GEN_FILES += ksm_tests
>>  
>>  ifeq ($(MACHINE),x86_64)
>> @@ -91,6 +91,9 @@ TEST_FILES := test_vmalloc.sh
>>  KSFT_KHDR_INSTALL := 1
>>  include ../lib.mk
>>  
>> +$(OUTPUT)/madv_populate: vm_util.c
>> +$(OUTPUT)/split_huge_page_test: vm_util.c
>> +
> 
> 
> [...]
> 
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <stdbool.h>
>> +#include <string.h>
>> +#include "vm_util.h"
>> +
>> +uint64_t pagemap_get_entry(int fd, char *start)
>> +{
>> +	const unsigned long pfn = (unsigned long)start / getpagesize();
>> +	uint64_t entry;
>> +	int ret;
>> +
>> +	ret = pread(fd, &entry, sizeof(entry), pfn * sizeof(entry));
>> +	if (ret != sizeof(entry))
>> +		ksft_exit_fail_msg("reading pagemap failed\n");
>> +	return entry;
>> +}
>> +
>> +bool pagemap_is_softdirty(int fd, char *start)
>> +{
>> +	uint64_t entry = pagemap_get_entry(fd, start);
>> +
>> +	return ((entry >> DIRTY_BIT_LOCATION) & 1);
>> +}
> 
> Please leave code you're moving around as untouched as possible to avoid
> unrelated bugs that happen by mistake and are hard to review.
> 
>> +
>> +void clear_softdirty(void)
>> +{
>> +	int ret;
>> +	const char *ctrl = "4";
>> +	int fd = open("/proc/self/clear_refs", O_WRONLY);
>> +
>> +	if (fd < 0)
>> +		ksft_exit_fail_msg("opening clear_refs failed\n");
>> +	ret = write(fd, ctrl, strlen(ctrl));
>> +	close(fd);
>> +	if (ret != strlen(ctrl))
>> +		ksft_exit_fail_msg("writing clear_refs failed\n");
>> +}
>> +
>> +
>> +static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
>> +{
>> +	while (fgets(buf, MAX_LINE_LENGTH, fp) != NULL) {
>> +		if (!strncmp(buf, pattern, strlen(pattern)))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +uint64_t read_pmd_pagesize(void)
>> +{
>> +	int fd;
>> +	char buf[20];
>> +	ssize_t num_read;
>> +
>> +	fd = open(PMD_SIZE, O_RDONLY);
>> +	if (fd == -1)
>> +		ksft_exit_fail_msg("Open hpage_pmd_size failed\n");
>> +
>> +	num_read = read(fd, buf, 19);
>> +	if (num_read < 1) {
>> +		close(fd);
>> +		ksft_exit_fail_msg("Read hpage_pmd_size failed\n");
>> +	}
>> +	buf[num_read] = '\0';
>> +	close(fd);
>> +
>> +	return strtoul(buf, NULL, 10);
>> +}
>> +
>> +uint64_t check_huge(void *addr)
>> +{
>> +	uint64_t thp = 0;
>> +	int ret;
>> +	FILE *fp;
>> +	char buffer[MAX_LINE_LENGTH];
>> +	char addr_pattern[MAX_LINE_LENGTH];
>> +
>> +	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
>> +		       (unsigned long) addr);
>> +	if (ret >= MAX_LINE_LENGTH)
>> +		ksft_exit_fail_msg("%s: Pattern is too long\n", __func__);
>> +
>> +	fp = fopen(SMAP, "r");
>> +	if (!fp)
>> +		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, SMAP);
>> +
>> +	if (!check_for_pattern(fp, addr_pattern, buffer))
>> +		goto err_out;
>> +
>> +	/*
>> +	 * Fetch the AnonHugePages: in the same block and check the number of
>> +	 * hugepages.
>> +	 */
>> +	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
>> +		goto err_out;
>> +
>> +	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) != 1)
>> +		ksft_exit_fail_msg("Reading smap error\n");
>> +
>> +err_out:
>> +	fclose(fp);
>> +	return thp;
>> +}
>> diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
>> new file mode 100644
>> index 0000000000000..7522dbb859f0f
>> --- /dev/null
>> +++ b/tools/testing/selftests/vm/vm_util.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#include <stdint.h>
>> +#include <fcntl.h>
>> +#include "../kselftest.h"
>> +
>> +#define	PMD_SIZE		"/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
> 
> Ehm no. PMD_SIZE_PATH at best -- just as it used to.
> 
>> +#define	SMAP			"/proc/self/smaps"
> 
> SMAPS_PATH
> 
>> +#define	DIRTY_BIT_LOCATION	55
> 
> Please inline that just as it used to. There is no value in a magic
> define without any proper namespace.
> 
>> +#define	MAX_LINE_LENGTH		512
> 
> This used to be 500. Why the change?
> 
> 
> Also: weird indentation and these all look like the should go into
> vm_util.c. They are not used outside that file.
> 
> 
> 

-- 
Muhammad Usama Anjum
