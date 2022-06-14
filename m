Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B354B783
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbiFNRU3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbiFNRU1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 13:20:27 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C72E0BF
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 10:20:25 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v143so12371398oie.13
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hg6Vqov4iXvBWaAWFrjzE3cJyqu2kSLgOmZIB62TeP4=;
        b=ZkUTOL7K1RF/aEE1Lfl/rHZMd5mzmuyLkpzUflHyzVmXEl0/ykuBz0T6xVQIEM/eVN
         s/D90OYveIE+nIbTNu4ml9ME5ulVcDOTtFLHdbYk6gxDJhzCQ86LnuIKbK3IMvRYtkht
         733KAbrSO+4Eg6Xfa+qhVujYC0UKgFD0zMnGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hg6Vqov4iXvBWaAWFrjzE3cJyqu2kSLgOmZIB62TeP4=;
        b=Nw1zfik1p+c+PW3SmTMtT3zPzkPZYRz+cyaLlU6CG1FNsdRdL2f9oFAyiOqtW8ck6z
         EnCFtiNDjnQpp9uhEj1tBK77hWL95G0RC1vDN7SVr4Qznw43z7SaJa+5mRDdMXP6DNf6
         A4DRnoKG8AmffOh8Xo5xtI2c9PTUHVSqu1PXBwVsVKrF9HO/sQzIrYwTD5cexDS3Ftew
         nbnsv4wJUQOQknHx0pEov9z4JJhl4WiK8BVQQne9R8zYDc5V2mgJjDKufmyBC+Bt4rW0
         wyr2xgXvhlNI2CyBthI+P0iTx5pRToH7vZajMCP4ju41N2xSs/HGgipnvZhwdsGDodlu
         41VA==
X-Gm-Message-State: AOAM5316ytabYi5PmptTvl7qhhCLRhMi/t12HD+W9XhY5HHumvkbl1cs
        s9OgHTG+p6iDMTirfoUdWVVHKg==
X-Google-Smtp-Source: ABdhPJz5iNx+05iYtyKjN+1yjrjUV9JdHERfov+sTvxBpWyYWz/4EqWVrZiwlG4doCoQdTxjdoKR8w==
X-Received: by 2002:a05:6808:1512:b0:32e:f1bf:b8f8 with SMTP id u18-20020a056808151200b0032ef1bfb8f8mr2555983oiw.81.1655227224787;
        Tue, 14 Jun 2022 10:20:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h4-20020a056870170400b000f5e33aaa66sm6074177oae.0.2022.06.14.10.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:20:24 -0700 (PDT)
Subject: Re: [PATCH V2] selftests/vm: Add protection_keys tests to run_vmtests
To:     "Shetty, Kalpana" <kalpana.shetty@amd.com>,
        akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220610090704.296-1-kalpana.shetty@amd.com>
 <8e7fca3a-096c-7d6c-e43b-9292995ab970@linuxfoundation.org>
 <e1703fcf-c5e2-70b1-cae2-30330108ad26@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2f157493-02ed-4bc8-6624-b7d077c0d5af@linuxfoundation.org>
Date:   Tue, 14 Jun 2022 11:20:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e1703fcf-c5e2-70b1-cae2-30330108ad26@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/14/22 6:15 AM, Shetty, Kalpana wrote:
> 
> On 6/14/2022 3:14 AM, Shuah Khan wrote:
>> On 6/10/22 3:07 AM, Kalpana Shetty wrote:
>>> Adding "protected_keys" tests to "run_vmtests.sh" would help out to run all VM related tests
>>> from a single shell script.
>>>
>>
>> Makes sense - can you explain why you can't just run
>> protection_keys_32 without checks? 
> 
> Yes; we can run protection_keys_32 without check.
> 
> 
>> Why are you checking for VADDR64? 
> 
> The check is added to ensure if the system is in 64-bit mode before executing 64-bit binary.
> 
> 

Okay. protection_keys_32 will only be built on 32-bit system and.
protection_keys_64 on 64-bit system.

Won't it be better to check if binary exists and run either _32 or
_64 instead of checking for VADDR64?

thanks,
-- Shuah
