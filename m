Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59249EEBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 00:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiA0XSL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 18:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbiA0XSK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 18:18:10 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BCC061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:18:10 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s18so5616738ioa.12
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YU3GBh9IHBE3OMSvodcmRm73jpaW9CEdeSNlQSN34OY=;
        b=OjeUhh7IGn8+mCXgL7lCH/E52D1gX3I4upcfcco/3vTf1hOLJYLhWVfxrTwznwjj1y
         cpn2bl6KAByCU36TyK+qhnRsPv4ZAgfEFM5OeGx63YpC4p+hb1pzSr2ipg9P4LPomsO6
         zIGCZkdwibHnnLVCy+hxTrE8BN2iLomVi62os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YU3GBh9IHBE3OMSvodcmRm73jpaW9CEdeSNlQSN34OY=;
        b=o/nNBMWvqM6AtBZKbgjiif8mbXP4ZUG9Y+QL00MvRggPza0YXZmA0IDMzOujFEqL7M
         aQV2tueuxCooyMdr6AsYxwf7JYCPXa3gjKJXFyTluXqZSUnUUhVRc94NbeypDHxbkjz0
         as8S1L5Sn7TJE2dainaVaCjrT5YI9KZvdLC961dSaveHM+Pb4g5DQHKwL0pAiZaE/DNj
         O2x0bkgAEzGxxl+v1d3T1GJwwwhta/jDibRtBuGS8ZfLnvaTyhhoJwGCBTL0LvrG0QfT
         uYo8E5Wb5V6AJBPTmsWWRgkyMnMNFvdNCozw5Scv+h+aHyFRhRQojuhruCNcBwWW0+HU
         wb7g==
X-Gm-Message-State: AOAM530URLA92jSXCsZL4Y7Ocujngy4B/BGXw2eSVNiyxvlThGCZNxgq
        GufXtpCVY9Fu4/oMO34Aba1rTw==
X-Google-Smtp-Source: ABdhPJw9jYVqKIlD1ctjZE32jsLunfb1mDQpL96xZLCO9/NSd/StZLQZlB3fGs/hadGjgaNhE2+Lfw==
X-Received: by 2002:a6b:dd0c:: with SMTP id f12mr3573856ioc.203.1643325490003;
        Thu, 27 Jan 2022 15:18:10 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id t6sm12948084iov.39.2022.01.27.15.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:18:09 -0800 (PST)
Subject: Re: [PATCH] kselftest: Fix vdso_test_abi return status
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-3-cristian.marussi@arm.com>
 <20220126122608.54061-1-vincenzo.frascino@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5ea69341-73af-e741-7b5d-c161845583c9@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:18:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126122608.54061-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 5:26 AM, Vincenzo Frascino wrote:
> vdso_test_abi contains a batch of tests that verify the validity of the
> vDSO ABI.
> 
> When a vDSO symbol is not found the relevant test is skipped reporting
> KSFT_SKIP. All the tests return values are then added in a single
> variable which is checked to verify failures. This approach can have
> side effects which result in reporting the wrong kselftest exit status.
> 
> Fix vdso_test_abi verifying the return code of each test separately.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   tools/testing/selftests/vDSO/vdso_test_abi.c | 27 +++++++++++---------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
> index 3d603f1394af..3a4efb91b9b2 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_abi.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
> @@ -184,10 +184,12 @@ static inline int vdso_test_clock(clockid_t clock_id)
>   	return ret0;
>   }
>   
> +#define VDSO_TESTS_MAX	9
> +
>   int main(int argc, char **argv)
>   {
>   	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
> -	int ret;
> +	int ret[VDSO_TESTS_MAX] = {0};
>   
>   	if (!sysinfo_ehdr) {
>   		printf("AT_SYSINFO_EHDR is not present!\n");
> @@ -201,44 +203,45 @@ int main(int argc, char **argv)
>   
>   	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
>   
> -	ret = vdso_test_gettimeofday();
> +	ret[0] = vdso_test_gettimeofday();
>   
>   #if _POSIX_TIMERS > 0
>   
>   #ifdef CLOCK_REALTIME
> -	ret += vdso_test_clock(CLOCK_REALTIME);
> +	ret[1] = vdso_test_clock(CLOCK_REALTIME);
>   #endif
>   
>   #ifdef CLOCK_BOOTTIME
> -	ret += vdso_test_clock(CLOCK_BOOTTIME);
> +	ret[2] = vdso_test_clock(CLOCK_BOOTTIME);
>   #endif
>   
>   #ifdef CLOCK_TAI
> -	ret += vdso_test_clock(CLOCK_TAI);
> +	ret[3] = vdso_test_clock(CLOCK_TAI);
>   #endif
>   
>   #ifdef CLOCK_REALTIME_COARSE
> -	ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
> +	ret[4] = vdso_test_clock(CLOCK_REALTIME_COARSE);
>   #endif
>   
>   #ifdef CLOCK_MONOTONIC
> -	ret += vdso_test_clock(CLOCK_MONOTONIC);
> +	ret[5] = vdso_test_clock(CLOCK_MONOTONIC);
>   #endif
>   
>   #ifdef CLOCK_MONOTONIC_RAW
> -	ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
> +	ret[6] = vdso_test_clock(CLOCK_MONOTONIC_RAW);
>   #endif
>   
>   #ifdef CLOCK_MONOTONIC_COARSE
> -	ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
> +	ret[7] = vdso_test_clock(CLOCK_MONOTONIC_COARSE);
>   #endif
>   
>   #endif
>   
> -	ret += vdso_test_time();
> +	ret[8] = vdso_test_time();
>   
> -	if (ret > 0)
> -		return KSFT_FAIL;
> +	for (int i = 0; i < VDSO_TESTS_MAX; i++)
> +		if (ret[i] == KSFT_FAIL)
> +			return KSFT_FAIL;
>   
>   	return KSFT_PASS;
>   }
> 

You can use the ksft_* counts interfaces for this instead of adding
counts here. ksft_test_result_*() can be used to increment the right
result counters and then print counts at the end.

Either if there is a failure in any of the tests it will be fail with
clear indication on which tests failed. vdso_test_clock() test for
example is reporting false positives by overriding the Skip return
with a pass.

thanks,
-- Shuah



