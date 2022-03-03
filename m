Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0E4CC8BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiCCWVp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 17:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiCCWVp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 17:21:45 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32926F9
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 14:20:59 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id d62so7438019iog.13
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VBkt6m9LITkn++JGkO1ATzV9oKt4/whQ3jS4HjOvbjY=;
        b=E/qaOd662MgY3tCHS/0oI3+UZv6QenjXIpbFU8+3oufy/C1cLxAww/MMsdrx4fpnRe
         h/52IgeNVh12CA4WCd1qqls6kE0A24yNGsZ9MkJgSP7o9Vk4Pql39Upxla6HfUhb+H3o
         GvG4KNzVhxzsD2om+P82ly6OfbKl53BcMDygI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBkt6m9LITkn++JGkO1ATzV9oKt4/whQ3jS4HjOvbjY=;
        b=hRmOa1YT7oHKZiBmET/+ChPaQbUIpFyL5VMIoM2N1MUcHUuc+iPbEg6LlFRdZivuTG
         0aHjyOKZXMfrHLkENK9hBvaNwqUABe5NBnox1Ty+kKxcsMvAFIqe9HimJG2R1iMaM1OS
         94hLjhz+WTLjvwaVuvwfY4fBNgX0SR/O8eX/p5Og1LCHguj4McLYi/V7HHYHDdHTVmcY
         Hgug8iNdrkeDWKulCzrepdiedMpfZm/wTVe+tRrcs4oEyP9NEvqgozfrD/vB6CoDu6Sc
         hMgC/eWbm7SCDHzBujDUUFZ98G4kQ4KndNimrmxLzLZJ4Chzy+3Os/8B/9Kpq81/XXgN
         pbHA==
X-Gm-Message-State: AOAM5307lLYb3em4MYNsa/oPqmKUIJh/EUO+wvwjHyKKaeZevaTmjIGF
        sf9MeIvKjL/N3qj83NCfjOn3Qw==
X-Google-Smtp-Source: ABdhPJx3VuKiHfWWx8r9qbf1hxEuZ/ORapgZH72gzhQLghnV3ArpSlo+D8U8zVmhdFVTr5D9boDiFA==
X-Received: by 2002:a5d:984f:0:b0:63d:a956:cdbc with SMTP id p15-20020a5d984f000000b0063da956cdbcmr28299695ios.37.1646346058516;
        Thu, 03 Mar 2022 14:20:58 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m1-20020a056e021c2100b002c2ec1c8012sm3799828ilh.53.2022.03.03.14.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 14:20:58 -0800 (PST)
Subject: Re: [PATCH v2] selftests: netfilter: fix a build error on openSUSE
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Geliang Tang <geliang.tang@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Kai Liu <kai.liu@suse.com>, netfilter-devel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <5ee95e93a11a239df8e09d059da25a4eaa5725ba.1646198836.git.geliang.tang@suse.com>
 <8cbf1231-0da5-c8a0-d66b-1488633d9895@linuxfoundation.org>
 <Yh+wulh/nIkFeFmz@salvia>
 <c2318ebe-beaa-64b8-6c6c-ee552cb35e0f@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3618874c-b3bb-8423-0c16-38c52712a36d@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 15:20:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c2318ebe-beaa-64b8-6c6c-ee552cb35e0f@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/22 12:10 PM, Shuah Khan wrote:
> On 3/2/22 11:00 AM, Pablo Neira Ayuso wrote:
>> On Wed, Mar 02, 2022 at 10:11:11AM -0700, Shuah Khan wrote:
>>> On 3/1/22 10:29 PM, Geliang Tang wrote:
>>>> This patch fixed the following build error on openSUSE Leap 15.3:
>>>>
>>>> =======================================================================
>>>>    gcc     nf-queue.c -lmnl -o tools/testing/selftests/netfilter/nf-queue
>>>>    nf-queue.c:13:10: fatal error: libmnl/libmnl.h: No such file or directory
>>>>     #include <libmnl/libmnl.h>
>>>>              ^~~~~~~~~~~~~~~~~
>>>>    compilation terminated.
>>>> =======================================================================
>>>>
>>>> It is because libmnl.h is put in the directory of
>>>> "/usr/include/libmnl/libmnl/" on openSUSE, not "/usr/include/libmnl/":
>>>>
>>>>    > rpm -ql libmnl-devel
>>>>    /usr/include/libmnl
>>>>    /usr/include/libmnl/libmnl
>>>>    /usr/include/libmnl/libmnl/libmnl.h
>>>>    /usr/lib64/libmnl.so
>>>>    /usr/lib64/pkgconfig/libmnl.pc
>>>>
>>>> Suggested-by: Kai Liu <kai.liu@suse.com>
>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>>> ---
>>>> v2:
>>>>    - use pkg-config
>>>> ---
>>>>    tools/testing/selftests/netfilter/Makefile | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
>>>> index e4f845dd942b..8136c1fab7ab 100644
>>>> --- a/tools/testing/selftests/netfilter/Makefile
>>>> +++ b/tools/testing/selftests/netfilter/Makefile
>>>> @@ -8,6 +8,7 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
>>>>        ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
>>>>        conntrack_vrf.sh nft_synproxy.sh
>>>> +CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
>>>>    LDLIBS = -lmnl
>>>>    TEST_GEN_FILES =  nf-queue
>>>>
>>>
>>> Adding Pablo to the thread.
>>>
>>> Pablo,
>>>
>>> This looks good to me. I can take this through linux-kselftest tree.
>>> Let me know either way.
>>>
>>> Or if it is going through netfilter tree:
>>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> If this does not cause any issue when running tests in any other
>> distros, then it is fine with me.
>>
> 
> I tested this on Ubuntu 21.10 and worked for me. I will apply this for
> Linux 5.18-rc1 then.
> 

Applied to linux-kselftest next for Linux 5.18-rc1.

thanks,
-- Shuah
