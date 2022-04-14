Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748D4501DA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 23:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiDNVuP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiDNVuO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 17:50:14 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E195485
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 14:47:49 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id t4so3916967ilo.12
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uODln0vhOum+2TmooGakPEQyd171bQ+mLLWEZrWqTtc=;
        b=EvbgG93teZuoQFogrfgcb/t3dQ0nNizMxjjAe1NOWX+E1MXm+QCLg+Y96hefcOTRMa
         aLJjZIuP7eGzJR5Zfng32friME4aRgo68ROrj0xDMgz+M4FxZwW5lZDaSYRXCPEFfm37
         NOquHBfk4dDuS3EGt45XVo6CWaNJW5kubJkhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uODln0vhOum+2TmooGakPEQyd171bQ+mLLWEZrWqTtc=;
        b=RsKmGE/Kh7lgjQuZo8DYNEb4NmY6Mb0lx2fyotW7kqcrFmANuziBSUBv4OowROZuC7
         +FgFTgqDdVynZEz5TFtbrTD5mWRLtS4R/2ZNhd4qBrTCclWt50GjxZpX3gW17NT5cC4M
         WHNPlx+B12EaMevknLA4FxAJnnvFlvpkuM4qUe83y9AeZ0uJ8t0evgo2sy8zlYDjJKcy
         GWuS3qtM1slRMzoVqtwmt+tIgyWhCkfKLT2aaZAPLdo3AAO4nGET2A1ttdyqV5Q3Cs5M
         gQkofFUJ6CX/ZUsE2mxiQjbQNhkxnCrWWUGgkaERr04tKhTSTLci3dXAZB8haUUyvcPi
         7zvA==
X-Gm-Message-State: AOAM533OEvFS82WeXCqxJ2CEpUOX6gJBWT41CGDKNOuNwTGKWkb41TEW
        RU0NusuYsiKYaZcARrRdDG4H2g==
X-Google-Smtp-Source: ABdhPJwm1f0gSHMWMogFULROo6XpNNk3n4FrlkZHWlqC8j2dQyRz19Hrh73SmO6aqUyxxJLBWVoSNg==
X-Received: by 2002:a92:640d:0:b0:2ca:ad76:3e88 with SMTP id y13-20020a92640d000000b002caad763e88mr1746974ilb.84.1649972868142;
        Thu, 14 Apr 2022 14:47:48 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d195-20020a6bb4cc000000b0064fceb8033dsm1318892iof.7.2022.04.14.14.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 14:47:47 -0700 (PDT)
Subject: Re: [PATCH 2/4] selftest/vm: verify remap destination address in
 mremap_test
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
 <20220414171529.62058-3-sidhartha.kumar@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e6cc5cf6-b6bc-2eca-255d-5dd247253255@linuxfoundation.org>
Date:   Thu, 14 Apr 2022 15:47:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220414171529.62058-3-sidhartha.kumar@oracle.com>
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
> Because mremap does not have a NOREPLACE flag,
> it can destroy existing mappings. This can
> cause a segfault if regions such as text are
> destroyed.

Please explain the reason for segfault.

Add a blank line here. Makes it easier to read.

Verify the requested mremap destination
> address does not overlap any existing mappings
> by using mmap's FIXED_NOREPLACE flag and checking

Spell this out fully - MAP_FIXED_NOREPLACE
> for the EEXIST error code. Keep incrementing the
> destination address until a valid mapping is found
> or max address is reached.
> 

Essentially mremap() doesn't check for overlaps and removes
or overwrites existing mappings? The way you are fixing it
is by verifying by calling mremap() with MAP_FIXED_NOREPLACE
flag and check for EEXIST.

What happens when max address is reached?

Same comment on # of chars per line in commit log. Also

> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>   tools/testing/selftests/vm/mremap_test.c | 36 ++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
> index 58600fee4b81..98e9cff34aa7 100644
> --- a/tools/testing/selftests/vm/mremap_test.c
> +++ b/tools/testing/selftests/vm/mremap_test.c
> @@ -10,6 +10,7 @@
>   #include <string.h>
>   #include <sys/mman.h>
>   #include <time.h>
> +#include <limits.h>
>   
>   #include "../kselftest.h"
>   
> @@ -65,6 +66,34 @@ enum {
>   	.expect_failure = should_fail				\
>   }
>   
> +/*
> + * Returns 0 if the requested remap region overlaps with an
> + * existing mapping (e.g text, stack) else returns 1.
> + */
> +static int remap_region_valid(void *addr, unsigned long long size)

This returns bool 0 (false) 1 (true)

Please name the routine - is_remap_region_valid() and change it to
return bool.

> +{
> +	void *remap_addr = NULL;
> +	int ret = 1;
> +
> +	if ((unsigned long long) addr > ULLONG_MAX - size) {
> +		ksft_print_msg("Can't find a valid region to remap to\n");

Change it to "Couldn't" - also this message doesn't look right. We hav't
looked for valid region yet and it just exceeds the limits?


> +		exit(KSFT_SKIP);> +	}
> +
> +	/* Use MAP_FIXED_NOREPLACE flag to ensure region is not mapped */
> +	remap_addr = mmap(addr, size, PROT_READ | PROT_WRITE,
> +			MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
> +			-1, 0);

Alignment should match open parenthesis here and in other places. Makes it
easier to read the code.

> +	if (remap_addr == MAP_FAILED) {
> +		if (errno == EEXIST)
> +			ret = 0;
> +	} else {
> +		munmap(remap_addr, size);
> +	}
> +
> +	return ret;
> +}
> +
>   /* Returns mmap_min_addr sysctl */
>   static unsigned long long get_mmap_min_addr(void)
>   {
> @@ -180,6 +209,13 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
>   	if (!((unsigned long long) addr & c.dest_alignment))
>   		addr = (void *) ((unsigned long long) addr | c.dest_alignment);
>   
> +	/* Don't destroy existing mappings unless expected to overlap */
> +	while (!remap_region_valid(addr, c.region_size)) {
> +		if (c.overlapping)
> +			break;
> +		addr += c.src_alignment;
> +	}
> +
>   	clock_gettime(CLOCK_MONOTONIC, &t_start);
>   	dest_addr = mremap(src_addr, c.region_size, c.region_size,
>   			MREMAP_MAYMOVE|MREMAP_FIXED, (char *) addr);
> 

thanks,
-- Shuah
