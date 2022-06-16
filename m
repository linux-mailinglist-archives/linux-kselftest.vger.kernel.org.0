Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE27354EA60
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 21:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378446AbiFPTxd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 15:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378441AbiFPTx2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 15:53:28 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF06F3F337
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 12:53:27 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h187so3081289oif.4
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EfwlzFckWlUMOMsTP0CL3PI+ky24pigsEudIsOwrRdI=;
        b=XoPuikzI8T2Enhg9yfnoUEsHSfpocokh8nllyr1EvKnLHKHH4KdJvmE92GdcBXQTqL
         SIqH+LyXNQuPeYMKv2+GgRBjzAY/Wo2nXdujrfOBqa18SykwVVb8o7J2SD1N1Zyulv6U
         U7cG9kZdpphOzt4EmU15Cpd2aKe9vUoP7oJTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EfwlzFckWlUMOMsTP0CL3PI+ky24pigsEudIsOwrRdI=;
        b=Mkw7ev5kXvDaYHHskIGPphrLgDjv49wzxGdzVZ6w1mOGz39jDAv68Z09q8L05Pj58I
         ybtCjSjLbyp4XpLLaS80JbnLZEleEK9zGyCOXDJm1F3jYys+r+FvfUMNz00zB7S/eFaM
         RohblNwAgoVCTwljnyhXpX6qAL7UXK0pi5QwFbnhxiDgQG5SQ2HlmivpU5wHkgvCz7Vd
         0j+YDH2qgYBL8Sfrhr/w7jG3ZTdfe/zU35RXJn74sOUy4zgutfJkm/1wX4lS8mm+zIkH
         FaJUxCvW2ZNRnRiCQQhKo+bBA52d6XtsYP08fa7azwc+fUf51ofCwdB/IbtELzwx/C2l
         36dA==
X-Gm-Message-State: AOAM530peyc83wse1n7Cape4Zk+M5uj8qCbgC0dwqRlJxio0EL7NPu6f
        1tGbuFX3U9T7FfpJIZXaqNC/xQ==
X-Google-Smtp-Source: ABdhPJwweF1/2fqbcaZAz1sg2n/7BwBVsvtY3F6NXRJHPRCtaFg6+jab8NKhG/y5uP1KYQQ0ZVdO0w==
X-Received: by 2002:a05:6808:2003:b0:32e:f319:456f with SMTP id q3-20020a056808200300b0032ef319456fmr8647466oiw.226.1655409207075;
        Thu, 16 Jun 2022 12:53:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z4-20020a056870738400b000f317901b29sm1374116oam.4.2022.06.16.12.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 12:53:26 -0700 (PDT)
Subject: Re: [PATCH V2] selftests/vm: Add protection_keys tests to run_vmtests
To:     "Shetty, Kalpana" <kalpana.shetty@amd.com>,
        akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220610090704.296-1-kalpana.shetty@amd.com>
 <8e7fca3a-096c-7d6c-e43b-9292995ab970@linuxfoundation.org>
 <e1703fcf-c5e2-70b1-cae2-30330108ad26@amd.com>
 <2f157493-02ed-4bc8-6624-b7d077c0d5af@linuxfoundation.org>
 <442c7cb4-7ec5-bf34-b9d6-ce9480b4b491@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b63d3373-0a42-afdc-1f03-875301e9b6c8@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 13:53:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <442c7cb4-7ec5-bf34-b9d6-ce9480b4b491@amd.com>
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

On 6/15/22 6:04 AM, Shetty, Kalpana wrote:
> 
> On 6/14/2022 10:50 PM, Shuah Khan wrote:
>> On 6/14/22 6:15 AM, Shetty, Kalpana wrote:
>>>
>>> On 6/14/2022 3:14 AM, Shuah Khan wrote:
>>>> On 6/10/22 3:07 AM, Kalpana Shetty wrote:
>>>>> Adding "protected_keys" tests to "run_vmtests.sh" would help out to run all VM related tests
>>>>> from a single shell script.
>>>>>
>>>>
>>>> Makes sense - can you explain why you can't just run
>>>> protection_keys_32 without checks? 
>>>
>>> Yes; we can run protection_keys_32 without check.
>>>
>>>
>>>> Why are you checking for VADDR64? 
>>>
>>> The check is added to ensure if the system is in 64-bit mode before executing 64-bit binary.
>>>
>>>
>>
>> Okay. protection_keys_32 will only be built on 32-bit system and.
>> protection_keys_64 on 64-bit system.
> 
> On 64-bit system, we get both 32-bit and 64-bit binary.
> 
> 
>>
>> Won't it be better to check if binary exists and run either _32 or
>> _64 instead of checking for VADDR64?
> 
> makes sense;
> 
> In this case on 64-bit platform we would run both _32 and _64 and this should be fine.
> 
> 

Okay - send v3 with the change.

thanks,
-- Shuah
