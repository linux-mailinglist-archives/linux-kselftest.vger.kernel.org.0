Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E11501D54
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbiDNVWa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiDNVWZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 17:22:25 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB4DB2ED
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 14:19:59 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z6so6815379iot.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e+rLO9yrIA70QVfcuVWHoAmNxjU28ixiBe6tshKLaks=;
        b=HHVeyyCE6yNNmXYaR+yGYeXY3wbWPQ3ZSIhXUqLbFfHV1s20fYUFmBbHGm7RSVVI7t
         Uoxbkt/ob8KwZPULjmOa4CY0vj89cHnj8kUxp4tj9Lw2dIQUaRwyNWhmZxX7Cfan8DUi
         W7CI1gUgWSXCKE1nWGUr3Ynd37hBMRWOMoqgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e+rLO9yrIA70QVfcuVWHoAmNxjU28ixiBe6tshKLaks=;
        b=tZq2OmJQh/58BTH6GSQHbuT/dlKmJqxuqLqRhSy3+7z44FQBbevrh9SEj3I15X0xkR
         pGSVJq/1TZZSZoGc24xnZzbHKw9TEck3qDLfTVev0EqDPmHeyIUpQP7V7+iV5RGUzyGA
         /Vf2kmbUAX4Wcxhg5bPeZnSXXKzR1Nhi8k8Qb6MrhYsgLjsyQsmFLs7hyj5WpxNXIA/0
         J33q6K4NWSdEy/4VqPbiaiWSdx8+ujCXQnBH7C5ibLacL6NbJmeBF6BW4PwCKQRb0NFK
         lPB6B8GSaaHEIVq3U92AmNXAp0nTgjtpzIsgHDHXKHfKIQseQ2CPPtsIKoplge2Zb0bd
         q+8g==
X-Gm-Message-State: AOAM530VLbOlDjcqKj2Fq+xpH5VDrEmcnfWrFN54eNbl/NaYObKx+AfF
        v6zW/mrHyjTlUZTj86Kyeblv0g==
X-Google-Smtp-Source: ABdhPJz8NY/0Wdn0NH/7W47IsQg0szREmuV3+njUw7ODwTRO0hO7hzX2IWStc+jSl/iNCvupx8zfHQ==
X-Received: by 2002:a05:6638:2692:b0:326:2e30:e1f0 with SMTP id o18-20020a056638269200b003262e30e1f0mr2116165jat.249.1649971198917;
        Thu, 14 Apr 2022 14:19:58 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y74-20020a6bc84d000000b00645dfdd8a4csm1938821iof.38.2022.04.14.14.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 14:19:58 -0700 (PDT)
Subject: Re: [PATCH 1/4] selftest/vm: verify mmap addr in mremap_test
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
 <20220414171529.62058-2-sidhartha.kumar@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <eb48d665-1a8b-50cb-00d5-95d8b8cf5625@linuxfoundation.org>
Date:   Thu, 14 Apr 2022 15:19:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220414171529.62058-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/22 11:15 AM, Sidhartha Kumar wrote:
> Avoid calling mmap with requested addresses that
> are less than the system's mmap_min_addr. Running
> the test as root returns EACCES when trying to map
> addresses < mmap_min_addr which is not one of the
> error codes for the retry condition. Add a munmap
> call after an alignment check as the mappings are
> retained after the retry and can reach vm.max_map_count.
> 

Please use 75 or 76 chars per line in change logs to make it
easier to read the commit log.

The description is a bit confusing. What happens when mmap tries
to map addresses < mmap_min_addr?

> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>   tools/testing/selftests/vm/mremap_test.c | 41 +++++++++++++++++++++++-
>   1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
> index 0624d1bd71b5..58600fee4b81 100644
> --- a/tools/testing/selftests/vm/mremap_test.c
> +++ b/tools/testing/selftests/vm/mremap_test.c
> @@ -6,6 +6,7 @@
>   
>   #include <errno.h>
>   #include <stdlib.h>
> +#include <stdio.h>
>   #include <string.h>
>   #include <sys/mman.h>
>   #include <time.h>
> @@ -64,6 +65,35 @@ enum {
>   	.expect_failure = should_fail				\
>   }
>   
> +/* Returns mmap_min_addr sysctl */

Change this to "sysctl tunable from procfs"

> +static unsigned long long get_mmap_min_addr(void)
> +{
> +	FILE *fp;
> +	int n_matched;
> +	static unsigned long long addr;
> +
> +	if (addr)
> +		return addr;
> +
> +	fp = fopen("/proc/sys/vm/mmap_min_addr", "r");
> +	if (fp == NULL) {
> +		ksft_print_msg("Failed to open /proc/sys/vm/mmap_min_addr: %s\n",
> +			strerror(errno));
> +		exit(KSFT_SKIP);
> +	}
> +
> +	n_matched = fscanf(fp, "%llu", &addr);
> +	if (n_matched != 1) {
> +		ksft_print_msg("Failed to read /proc/sys/vm/mmap_min_addr: %s\n",
> +			strerror(errno));
> +		fclose(fp);
> +		exit(KSFT_SKIP);
> +	}
> +
> +	fclose(fp);
> +	return addr;
> +}
> +
>   /*
>    * Returns the start address of the mapping on success, else returns
>    * NULL on failure.
> @@ -72,8 +102,15 @@ static void *get_source_mapping(struct config c)
>   {
>   	unsigned long long addr = 0ULL;
>   	void *src_addr = NULL;
> +	unsigned long long mmap_min_addr;
> +
> +	mmap_min_addr = get_mmap_min_addr();
> +
>   retry:
>   	addr += c.src_alignment;
> +	if (addr < mmap_min_addr)
> +		goto retry;

Should this be an error or retry? Can you add why this is a retry
when addr < mmap_min_addr?

> +
>   	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
>   			MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
>   			-1, 0);
> @@ -91,8 +128,10 @@ static void *get_source_mapping(struct config c)
>   	 * alignment in the tests.
>   	 */
>   	if (((unsigned long long) src_addr & (c.src_alignment - 1)) ||
> -			!((unsigned long long) src_addr & c.src_alignment))
> +			!((unsigned long long) src_addr & c.src_alignment)) {
> +		munmap(src_addr, c.region_size);
>   		goto retry;
> +	}
>   
>   	if (!src_addr)
>   		goto error;
> 

thanks,
-- Shuah
