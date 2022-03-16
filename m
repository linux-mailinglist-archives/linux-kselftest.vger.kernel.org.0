Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB424DACF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 09:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347256AbiCPI5P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 04:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242512AbiCPI5O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 04:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39E232C13C
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Mar 2022 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647420958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOXL/dlYJ9Y7q9KmoEp9L9wBQeuY/rwi8nHu81o4BOc=;
        b=Zjv+GKkD8TLQ5L/+ylqi/uX42nbdw2sUnxFBTaSL8L/We9CAzqttDt8SRvP4qXMI9JjZJh
        LfbPgLEsh8R6ceM4RmTisfY8/9B7winDw5/FBKuq4LCaq2R5cO4tLQQGQQTbgByxxZMXx/
        97YPcjhcwsbWuDSacO0fxDWkgOJH4NI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-xmHY5P0uM7eFxz8STBnRkQ-1; Wed, 16 Mar 2022 04:55:56 -0400
X-MC-Unique: xmHY5P0uM7eFxz8STBnRkQ-1
Received: by mail-wr1-f69.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so314067wrh.14
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Mar 2022 01:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=mOXL/dlYJ9Y7q9KmoEp9L9wBQeuY/rwi8nHu81o4BOc=;
        b=L36dj4oPAo5XQbzSul/Fc6uo6ZJYFdSH13zshQyXkASXaCofDEobEJrKZrO5lpbwib
         xwR3hIcYV2hXCXG+91d44crADms8B2J5SIgIf0lMygAMUSwAtZ/MHKsolFcyNMHGtLaH
         UjrdRdTUz5yHWud7QzdQ1okAFQXgqvyBe89IGBb9cMBaIRt/SLkoWoPGRrkcSVoULFHL
         uhVT3+km71J087aQE+nUySqpPHP0LPi1fp/qLlyDnLCs6lq4pm3Nv+fN64+oI5eTDSt9
         rbqhAjeegbWZpzXDKioFZW04xi5ZBb2cHiruVgs7vZFqWCe5tZkRExNaV7cn6HUyPG86
         frFA==
X-Gm-Message-State: AOAM531vnpe8DKxu5Bh99d6KVnQ20HQ9MN3gf41CE+6s2exz4c+upN1a
        1+vdvZhB1M39H1BZiY83tCAOYBXJqyDv4AFmsPCSY40V9oLbfqboZAWyJbznqICR6/R8wSIQBKN
        t3qxSk1GLqbV4Z1oKFltdLEaq6OrP
X-Received: by 2002:a05:6000:2c9:b0:1f0:49aa:d347 with SMTP id o9-20020a05600002c900b001f049aad347mr23452343wry.453.1647420955619;
        Wed, 16 Mar 2022 01:55:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyd7sa+0eL137AIqkXqTEIJzbfdMHDmQgaMRZl52+qq2qpQhfpnTOOt6EPW7m4NTjXbmHuow==
X-Received: by 2002:a05:6000:2c9:b0:1f0:49aa:d347 with SMTP id o9-20020a05600002c900b001f049aad347mr23452321wry.453.1647420955257;
        Wed, 16 Mar 2022 01:55:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:f900:aa79:cd25:e0:32d1? (p200300cbc706f900aa79cd2500e032d1.dip0.t-ipconnect.de. [2003:cb:c706:f900:aa79:cd25:e0:32d1])
        by smtp.gmail.com with ESMTPSA id g26-20020a05600c4c9a00b00389a48b68bdsm1078382wmp.10.2022.03.16.01.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 01:55:54 -0700 (PDT)
Message-ID: <b47a93fe-da50-d0d4-be8f-87071bf181f9@redhat.com>
Date:   Wed, 16 Mar 2022 09:55:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20220315085014.1047291-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V4 1/2] selftests: vm: bring common functions to a new
 file
In-Reply-To: <20220315085014.1047291-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15.03.22 09:50, Muhammad Usama Anjum wrote:
> Bring common functions to a new file. These functions can be used in the
> new tests. This helps in code duplication.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/vm/Makefile           |   7 +-
>  tools/testing/selftests/vm/madv_populate.c    |  34 +-----
>  .../selftests/vm/split_huge_page_test.c       |  77 +------------
>  tools/testing/selftests/vm/vm_util.c          | 103 ++++++++++++++++++
>  tools/testing/selftests/vm/vm_util.h          |  15 +++
>  5 files changed, 125 insertions(+), 111 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/vm_util.c
>  create mode 100644 tools/testing/selftests/vm/vm_util.h
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 5e43f072f5b76..4e68edb26d6b6 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -34,7 +34,7 @@ TEST_GEN_FILES += hugepage-mremap
>  TEST_GEN_FILES += hugepage-shm
>  TEST_GEN_FILES += hugepage-vmemmap
>  TEST_GEN_FILES += khugepaged
> -TEST_GEN_FILES += madv_populate
> +TEST_GEN_PROGS = madv_populate
>  TEST_GEN_FILES += map_fixed_noreplace
>  TEST_GEN_FILES += map_hugetlb
>  TEST_GEN_FILES += map_populate
> @@ -47,7 +47,7 @@ TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += userfaultfd
> -TEST_GEN_FILES += split_huge_page_test
> +TEST_GEN_PROGS += split_huge_page_test
>  TEST_GEN_FILES += ksm_tests
>  
>  ifeq ($(MACHINE),x86_64)
> @@ -91,6 +91,9 @@ TEST_FILES := test_vmalloc.sh
>  KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
>  
> +$(OUTPUT)/madv_populate: vm_util.c
> +$(OUTPUT)/split_huge_page_test: vm_util.c
> +


[...]

> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdbool.h>
> +#include <string.h>
> +#include "vm_util.h"
> +
> +uint64_t pagemap_get_entry(int fd, char *start)
> +{
> +	const unsigned long pfn = (unsigned long)start / getpagesize();
> +	uint64_t entry;
> +	int ret;
> +
> +	ret = pread(fd, &entry, sizeof(entry), pfn * sizeof(entry));
> +	if (ret != sizeof(entry))
> +		ksft_exit_fail_msg("reading pagemap failed\n");
> +	return entry;
> +}
> +
> +bool pagemap_is_softdirty(int fd, char *start)
> +{
> +	uint64_t entry = pagemap_get_entry(fd, start);
> +
> +	return ((entry >> DIRTY_BIT_LOCATION) & 1);
> +}

Please leave code you're moving around as untouched as possible to avoid
unrelated bugs that happen by mistake and are hard to review.

> +
> +void clear_softdirty(void)
> +{
> +	int ret;
> +	const char *ctrl = "4";
> +	int fd = open("/proc/self/clear_refs", O_WRONLY);
> +
> +	if (fd < 0)
> +		ksft_exit_fail_msg("opening clear_refs failed\n");
> +	ret = write(fd, ctrl, strlen(ctrl));
> +	close(fd);
> +	if (ret != strlen(ctrl))
> +		ksft_exit_fail_msg("writing clear_refs failed\n");
> +}
> +
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
> +uint64_t read_pmd_pagesize(void)
> +{
> +	int fd;
> +	char buf[20];
> +	ssize_t num_read;
> +
> +	fd = open(PMD_SIZE, O_RDONLY);
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
> +uint64_t check_huge(void *addr)
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
> +		ksft_exit_fail_msg("%s: Pattern is too long\n", __func__);
> +
> +	fp = fopen(SMAP, "r");
> +	if (!fp)
> +		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, SMAP);
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
> +		ksft_exit_fail_msg("Reading smap error\n");
> +
> +err_out:
> +	fclose(fp);
> +	return thp;
> +}
> diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
> new file mode 100644
> index 0000000000000..7522dbb859f0f
> --- /dev/null
> +++ b/tools/testing/selftests/vm/vm_util.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdint.h>
> +#include <fcntl.h>
> +#include "../kselftest.h"
> +
> +#define	PMD_SIZE		"/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"

Ehm no. PMD_SIZE_PATH at best -- just as it used to.

> +#define	SMAP			"/proc/self/smaps"

SMAPS_PATH

> +#define	DIRTY_BIT_LOCATION	55

Please inline that just as it used to. There is no value in a magic
define without any proper namespace.

> +#define	MAX_LINE_LENGTH		512

This used to be 500. Why the change?


Also: weird indentation and these all look like the should go into
vm_util.c. They are not used outside that file.



-- 
Thanks,

David / dhildenb

