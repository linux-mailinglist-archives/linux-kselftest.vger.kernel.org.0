Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15B54EDA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 00:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378348AbiFPWyd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 18:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiFPWyb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 18:54:31 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B062206
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 15:54:28 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u9so3508713oiv.12
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7wV78KF4dgnUbQxk8pc94OHUoJRSZfwr41EF876rjV4=;
        b=DNbvDqObxLMXa/rES4xAoWU4Civ7qJLfBw5zxQx08WrRR7NVxi8Yzg408cwdWX+QH5
         9dI2+M35fzecclwkWTTDSaRchm8T7VNkAQYYlab/R3Ecj5LgVXjZIXOOQQQIRqcx596j
         GtHWaX+RqlOcJcM5E4yqqQoF94qQLPi5aOnxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7wV78KF4dgnUbQxk8pc94OHUoJRSZfwr41EF876rjV4=;
        b=A1rU9Ecls/UOFL2AwrDabJXAghjoauDFpDPFayV9q56ib58/5y5FQ4QGhjHR4nVpuD
         R7vgkOntMSCEMHmnlfL/8rTPRiTtsqajpmLO0DrjfvcUaIPfOYNNVIcNNLSDOXRLZUjG
         D0l9SXQ+PcifzhU0wyubRAiISLi3+DXohmpqYJ1PhRN+wvZbAfy8U8hxhi/S7Z+F9x0I
         bBpvR7eVovA3sxXZSVUwKDzUNb+f4w1/UZfuP+mpEwAat+tH93P9uaQ8BHA/gTDQWmTg
         D3KGUdx83KdKcmyRx8IyntPakj/lZZECIGJtAW3EJU8i+hYYxnBW2aDjlnpMocJrWOfZ
         Py3Q==
X-Gm-Message-State: AOAM530+Jz09WsQptidh9fejRujnCgoyJG5YeBjbuhxXpWp18vioXSsu
        jc7EsNuVsI/wmLqIyY9W3CoFGw==
X-Google-Smtp-Source: ABdhPJzLEct5qbxT7S+CBrXpkdvX1y1NWqaQyDVrCZHbJaUGj+dQ0MODTBXf676ihx2engLwfu0p9w==
X-Received: by 2002:a05:6808:2117:b0:32e:f441:8cbe with SMTP id r23-20020a056808211700b0032ef4418cbemr8919388oiw.167.1655420068100;
        Thu, 16 Jun 2022 15:54:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u19-20020a056870951300b000f309d52933sm1501573oal.47.2022.06.16.15.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:54:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] selftests/x86/amx: Fix the test to avoid failure when
 AMX is unavailable
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220401221014.13556-1-chang.seok.bae@intel.com>
 <20220401221014.13556-3-chang.seok.bae@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aaab50d2-592c-69e4-58a6-0a0926669de3@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 16:54:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220401221014.13556-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/1/22 4:10 PM, Chang S. Bae wrote:
> When a CPU does not have AMX, the test fails. But this is wrong as it
> should be runnable regardless. Skip the test instead.
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Fixes: 6a3e0651b4a ("selftests/x86/amx: Add test cases for AMX state management")
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   tools/testing/selftests/x86/amx.c | 42 +++++++++++++++++++++++--------
>   1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
> index 3615ef4a48bb..14abb6072a7d 100644
> --- a/tools/testing/selftests/x86/amx.c
> +++ b/tools/testing/selftests/x86/amx.c
> @@ -106,6 +106,12 @@ static void clearhandler(int sig)
>   
>   #define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
>   #define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
> +
> +static struct {
> +	unsigned xsave:   1;
> +	unsigned osxsave: 1;
> +} cpuinfo;
> +

Why is this needed? Also naming this cpuinfo is confuing.

>   static inline void check_cpuid_xsave(void)
>   {
>   	uint32_t eax, ebx, ecx, edx;
> @@ -118,10 +124,8 @@ static inline void check_cpuid_xsave(void)
>   	eax = 1;
>   	ecx = 0;
>   	cpuid(&eax, &ebx, &ecx, &edx);
> -	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
> -		fatal_error("cpuid: no CPU xsave support");
> -	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
> -		fatal_error("cpuid: no OS xsave support");
> +	cpuinfo.xsave = !!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK);
> +	cpuinfo.osxsave = !!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK);

Why add this complexity. Why not just Skip here?

>   }
>   
>   static uint32_t xbuf_size;
> @@ -161,14 +165,31 @@ static void check_cpuid_xtiledata(void)
>   	 * eax: XTILEDATA state component size
>   	 * ebx: XTILEDATA state component offset in user buffer
>   	 */
> -	if (!eax || !ebx)
> -		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
> -				eax, ebx);
> -
>   	xtiledata.size	      = eax;
>   	xtiledata.xbuf_offset = ebx;
>   }
>   
> +static bool amx_available(void)
> +{
> +	check_cpuid_xsave();
> +	if (!cpuinfo.xsave) {
> +		printf("[SKIP]\tcpuid: no CPU xsave support\n");
> +		return false;
> +	} else if (!cpuinfo.osxsave) {
> +		printf("[SKIP]\tcpuid: no OS xsave support\n");
> +		return false;
> +	}
> +
> +	check_cpuid_xtiledata();
> +	if (!xtiledata.size || !xtiledata.xbuf_offset) {
> +		printf("[SKIP]\txstate cpuid: no tile data (size/offset: %d/%d)\n",
> +		       xtiledata.size, xtiledata.xbuf_offset);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +

I am not seeing any value in adding this layer of abstraction.
Keep it simple and do the handling in main()

>   /* The helpers for managing XSAVE buffer and tile states: */
>   
>   struct xsave_buffer *alloc_xbuf(void)
> @@ -826,9 +847,8 @@ static void test_context_switch(void)
>   
>   int main(void)
>   {
> -	/* Check hardware availability at first */
> -	check_cpuid_xsave();
> -	check_cpuid_xtiledata();
> +	if (!amx_available())
> +		return 0;

This should KSFT_SKIP for this to be reported as a skip. Returning 0
will be reported as a Pass.

>   
>   	init_stashed_xsave();
>   	sethandler(SIGILL, handle_noperm, 0);
> 

thanks,
-- Shuah
