Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA61C3DAE5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 23:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhG2VdS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 17:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhG2VdR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 17:33:17 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD4C0613C1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 14:33:13 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso7347601ota.4
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lEEjIGqrAwlEg9/A9DVqKnjXFatmS0cjdnFYVuoLl9M=;
        b=gyyKjARJRz6MHG75vLKxR8cad5Jeik/93GGjVzlZ9ehR/CY/aL2OGtiRyzNzlF4oxb
         EMhubwnxwNUtbNXxneJ+rWwGNTsDoQMOHSrfaYt1oU1Iw71oDgcGd0hwiEOa9luZoCHU
         TX0l13UtEyeUDKcpRtW+P3KdDMsv3+1VlPKqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lEEjIGqrAwlEg9/A9DVqKnjXFatmS0cjdnFYVuoLl9M=;
        b=gmqw6ZgmIr6wvxKEB3wEBo4m+gRUpzY6PJhefw2sx3i0vOKPdIIfHs+oetks2xgu57
         cpdVAurJfkC5wQ/0IYO9p5vaoAubSMHbAH0p8cov9SjsGjTjtb/qomNFugoohzHcelE9
         ffayR1huRnsd33rYeNwpb+UrjgUDhNEjAFnhbUFDgpqwcn0mhv4FsDOcZTi/OZBlM8KV
         3Lb/FNldiiy3YKb9TDPKxa5vDZtUWa8gyNfyXI+LToFnkR9VueiPQTAb4+6AmzaDEvp4
         htHMWhjxPHnaukNFluIbsp/mWIxvUBpPILrDBhEn7lh5MrAjVUakDmjptxYaWI0lRJwC
         PmcQ==
X-Gm-Message-State: AOAM533xdzYWg7LIj8nho1PMlfV05rszXe90Y2lsx2bazmDwKgN7UCXD
        0XfD6FYr5m9yGqKVab7sOqzHbg==
X-Google-Smtp-Source: ABdhPJzBUM0IApBM+MkILEdvwPyCZcRo9L0nVBzCJxQPUqNgKNNWwikItA8OR7pvRhvSyCEopKiTLg==
X-Received: by 2002:a9d:2625:: with SMTP id a34mr4766424otb.77.1627594392289;
        Thu, 29 Jul 2021 14:33:12 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p4sm671399ooa.35.2021.07.29.14.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 14:33:11 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/sgx: Fix Q1 and Q2 calculation in
 sigstruct.c
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210705050922.63710-1-jarkko@kernel.org>
 <be6227d1-728a-c658-f962-380c28afc926@linuxfoundation.org>
 <20210727031227.tx2gqx2qg3mg4522@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c5491afc-2a7e-cb36-2a24-6dfa6b08b31a@linuxfoundation.org>
Date:   Thu, 29 Jul 2021 15:33:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210727031227.tx2gqx2qg3mg4522@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/26/21 9:12 PM, Jarkko Sakkinen wrote:
> On Fri, Jul 23, 2021 at 01:53:06PM -0600, Shuah Khan wrote:
>> On 7/4/21 11:09 PM, Jarkko Sakkinen wrote:
>>> From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>
>>> Q1 and Q2 are numbers with *maximum* length of 384 bytes. If the calculated
>>> length of Q1 and Q2 is less than 384 bytes, things will go wrong.
>>>
>>> E.g. if Q2 is 383 bytes, then
>>>
>>> 1. The bytes of q2 are copied to sigstruct->q2 in calc_q1q2().
>>> 2. The entire sigstruct->q2 is reversed, which results it being
>>>      256 * Q2, given that the last byte of sigstruct->q2 is added
>>>      to before the bytes given by calc_q1q2().
>>>
>>> Either change in key or measurement can trigger the bug. E.g. an unmeasured
>>> heap could cause a devastating change in Q1 or Q2.
>>>
>>> Reverse exactly the bytes of Q1 and Q2 in calc_q1q2() before returning to
>>> the caller.
>>>
>>> Fixes: dedde2634570 ("selftests/sgx: Trigger the reclaimer in the selftests")
>>> Link: https://lore.kernel.org/linux-sgx/20210301051836.30738-1-tianjia.zhang@linux.alibaba.com/
>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>> The original patch did a bad job explaining the code change but it
>>> turned out making sense. I wrote a new description.
>>>
>>> v2:
>>> - Added a fixes tag.
>>>    tools/testing/selftests/sgx/sigstruct.c | 41 +++++++++++++------------
>>>    1 file changed, 21 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
>>> index dee7a3d6c5a5..92bbc5a15c39 100644
>>> --- a/tools/testing/selftests/sgx/sigstruct.c
>>> +++ b/tools/testing/selftests/sgx/sigstruct.c
>>> @@ -55,10 +55,27 @@ static bool alloc_q1q2_ctx(const uint8_t *s, const uint8_t *m,
>>>    	return true;
>>>    }
>>> +static void reverse_bytes(void *data, int length)
>>> +{
>>> +	int i = 0;
>>> +	int j = length - 1;
>>> +	uint8_t temp;
>>> +	uint8_t *ptr = data;
>>> +
>>> +	while (i < j) {
>>> +		temp = ptr[i];
>>> +		ptr[i] = ptr[j];
>>> +		ptr[j] = temp;
>>> +		i++;
>>> +		j--;
>>> +	}
>>> +}
>>
>> I was just about apply this one and noticed this reverse_bytes().
>> Aren't there byteswap functions you could call instead of writing
>> your own?
> 
> Sorry for latency, just came from two week leave.
> 
> glibc does provide bswap for 16, 32, 64 bit numbers but nothing better.
>   
> I have no idea if libssl has such function. Since the test code already
> uses this function, and it works, and it's not a newly added function in
> this patch, I would consider keeping it.
>   

I will queue this up since it is fixing an important problem.
Let's look into if this can be replaced with a lib call when
you do cleanups perhaps for the next release.

thanks,
-- Shuah
