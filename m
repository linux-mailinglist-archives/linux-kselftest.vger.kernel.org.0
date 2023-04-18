Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37866E5E64
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 12:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjDRKO1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjDRKOZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 06:14:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FD761BA;
        Tue, 18 Apr 2023 03:14:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id iw7-20020a05600c54c700b003f16fce55b5so3686851wmb.0;
        Tue, 18 Apr 2023 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681812862; x=1684404862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/3RvuoENvVjgHRExFiuQ0Bq7U8av4NBMU/9hcNgIOs=;
        b=PEy7rz9DT15QaF2r9PolfhQ+KjfwZgUVBcfsopQdfLEI6FU1r8I+O6E9vj6E485wUx
         wgAUUyL63Q10/fGhADdZDWGJXurWLc6zJPS5dmuPrK2LmYW3smMt6HIV71F75HyPB5Ls
         kG+KLmITvb4mu6HAweNr4SdAPbFyhBwlJEU6vdmXUmfM/pQ1EB9IAC8BDi5+EOjS/f2v
         Z9RhbZ89CEJquOh9IdtMKdQ1uAzyH+amKRGne/AcYsWW6m6386k6RZ/rfb0Mc3c1P4Wz
         Xl/TGN7DmnsnsOHBA44oYSoG+wCsw5VauxSDSt1f63oeIzxfiym7ihSJK3KowKl6ewFh
         pKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812862; x=1684404862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/3RvuoENvVjgHRExFiuQ0Bq7U8av4NBMU/9hcNgIOs=;
        b=W2wqRPDcFU6ezjk8ifizHpr85uP+7aVIE/rRJXiZPcYb6kvKyaO6qkZFx9vS2P01qu
         sC0/PsNrj43Dv+F0OYcVLr6uPPnA2MEPlibh0nRThmz7HJp1NUa6OXoo5NWXvBzQlamD
         ecbeE3px1iVYTOz5rs9DAdS0f0EByf6F4U1o/vYAbfAh/lPQArygmE42ylDtzj10cL38
         rbMTIWEuXWGNytn4sHkUDEQrncaE7E70CJFP7upZJDnARKIsTCnic4Xjl/W5aF5xid7v
         oc42ewyoGOnp9b4JTcd5De3v8KTUxqdXP9uelooNhcs+4gNw7F6jbPBvFyMrUw8NjKY6
         eMgw==
X-Gm-Message-State: AAQBX9dF4C80BWHfXFYQvPWO2CRCJPSsbDY5sX1scrfqiKFRiXX2p5XM
        4zIHFP03b/1ykKJZrYMxgsk=
X-Google-Smtp-Source: AKy350b8WjUK1A7Q+TOJfcGd4IZNOAtcoIMXAMsp7nuBFBdAMPMlIvr9mc7aseZLOg+hjfpT+nYDbQ==
X-Received: by 2002:a7b:cd93:0:b0:3f1:6434:43bf with SMTP id y19-20020a7bcd93000000b003f1643443bfmr8311588wmj.17.1681812861969;
        Tue, 18 Apr 2023 03:14:21 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id fc12-20020a05600c524c00b003f0a0315ce4sm17407725wmb.47.2023.04.18.03.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:14:21 -0700 (PDT)
Message-ID: <530b12f1-b0d2-1183-c9a9-0f5f9d6e178d@gmail.com>
Date:   Tue, 18 Apr 2023 11:14:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] kselftest: vDSO: Fix accumulation of uninitialized ret
 when CLOCK_REALTIME is undefined
Content-Language: en-US
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230417104743.30018-1-colin.i.king@gmail.com>
 <20487c94-7f81-cbf5-7136-c7f266eaf60d@arm.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20487c94-7f81-cbf5-7136-c7f266eaf60d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18/04/2023 11:10, Vincenzo Frascino wrote:
> Hi Colin,
> 
> On 4/17/23 11:47, Colin Ian King wrote:
>> In the unlikely case that CLOCK_REALTIME is not defined, variable ret is
>> not initialized and further accumulation of return values to ret can leave
>> ret in an undefined state. Fix this by initialized ret to zero and changing
>> the assignment of ret to an accumulation for the CLOCK_REALTIME case.
>>
> 
> I was wondering how did you find this.

I used cppcheck --force --enable=all, this examines the #if defined() paths.

> 
> Apart that:
> 
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
>> Fixes: 03f55c7952c9 ("kselftest: Extend vDSO selftest to clock_getres")
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
>> index 15dcee16ff72..38d46a8bf7cb 100644
>> --- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
>> +++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
>> @@ -84,12 +84,12 @@ static inline int vdso_test_clock(unsigned int clock_id)
>>   
>>   int main(int argc, char **argv)
>>   {
>> -	int ret;
>> +	int ret = 0;
>>   
>>   #if _POSIX_TIMERS > 0
>>   
>>   #ifdef CLOCK_REALTIME
>> -	ret = vdso_test_clock(CLOCK_REALTIME);
>> +	ret += vdso_test_clock(CLOCK_REALTIME);
>>   #endif
>>   
>>   #ifdef CLOCK_BOOTTIME
> 

