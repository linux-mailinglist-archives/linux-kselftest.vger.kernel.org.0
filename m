Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39484CC5B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 20:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiCCTLI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 14:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiCCTLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 14:11:08 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7636F195303
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 11:10:21 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f14so7002672ioz.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 11:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g/sFkbVANY6s1VOUMcV1aNrt4vhPUDmBJyNDe6I1g68=;
        b=eGSJxOjmE0cIxMw/fXCT0KGZpbtCKnaB3ZK22ZDwn9JetqtO0qIlWKv5gNiQ4VvQhb
         ecfPJDL2+i2614IQBximAIcYRu2T8jWUZD6y8FJNlo1ERgtYyNcOyAfVE9IfGIXwBICT
         9QEn9Jv+nXY6+G1BdKGZman6Btp1jus5+rpYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g/sFkbVANY6s1VOUMcV1aNrt4vhPUDmBJyNDe6I1g68=;
        b=B3mRLiKJ4RKNmEA0F3pkl+3/TBPRQ8ueHnhgnIha+1eLaU+jv9vfoKPiPeIS3V8+NZ
         bl+6V0G2DFwamYwXtk4/eO9hw3WjtQIPn4IFrNBOc0kSkFWWzPO43v8S5LCD8exQ+H7G
         2TGwIC7YN/oIAik1maJg+n5Yn3f4E42nuiBaUAsiFRDcDHMXekZdcF517DUKwXd5YlEt
         0yceuo+S5sQWi5dHurxLiqk8wxh/syKqsmlCwR40qGJirbEqqc+D4dPdSuzPM45k/4ec
         sgR3TkFjon6Z0F8RVjwzo2TQZ4wE2B02KAVe9CR7eDSvOXiRUQA7qVz55CTkeKlKAEX+
         S5pQ==
X-Gm-Message-State: AOAM530N0wYx/36JUxC6mUahAsJQt+5T1ThJ2MJ6k4ZtVR2UiSdAwAkA
        0y67GirJJcO+6Ty8Y36KHt1BJg==
X-Google-Smtp-Source: ABdhPJw05Uhuane2sSjF/DZ6Wk7V2Zj5SR03jKOcehMNVhhorOnQI8dC5GCpGPoySCXO1uAnVUqIPQ==
X-Received: by 2002:a5d:83c8:0:b0:604:c09b:259c with SMTP id u8-20020a5d83c8000000b00604c09b259cmr28740939ior.106.1646334620771;
        Thu, 03 Mar 2022 11:10:20 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id q190-20020a6b8ec7000000b00638d75f5cd0sm2802277iod.47.2022.03.03.11.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 11:10:20 -0800 (PST)
Subject: Re: [PATCH v2] selftests: netfilter: fix a build error on openSUSE
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Geliang Tang <geliang.tang@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Kai Liu <kai.liu@suse.com>, netfilter-devel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <5ee95e93a11a239df8e09d059da25a4eaa5725ba.1646198836.git.geliang.tang@suse.com>
 <8cbf1231-0da5-c8a0-d66b-1488633d9895@linuxfoundation.org>
 <Yh+wulh/nIkFeFmz@salvia>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c2318ebe-beaa-64b8-6c6c-ee552cb35e0f@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 12:10:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yh+wulh/nIkFeFmz@salvia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/2/22 11:00 AM, Pablo Neira Ayuso wrote:
> On Wed, Mar 02, 2022 at 10:11:11AM -0700, Shuah Khan wrote:
>> On 3/1/22 10:29 PM, Geliang Tang wrote:
>>> This patch fixed the following build error on openSUSE Leap 15.3:
>>>
>>> =======================================================================
>>>    gcc     nf-queue.c -lmnl -o tools/testing/selftests/netfilter/nf-queue
>>>    nf-queue.c:13:10: fatal error: libmnl/libmnl.h: No such file or directory
>>>     #include <libmnl/libmnl.h>
>>>              ^~~~~~~~~~~~~~~~~
>>>    compilation terminated.
>>> =======================================================================
>>>
>>> It is because libmnl.h is put in the directory of
>>> "/usr/include/libmnl/libmnl/" on openSUSE, not "/usr/include/libmnl/":
>>>
>>>    > rpm -ql libmnl-devel
>>>    /usr/include/libmnl
>>>    /usr/include/libmnl/libmnl
>>>    /usr/include/libmnl/libmnl/libmnl.h
>>>    /usr/lib64/libmnl.so
>>>    /usr/lib64/pkgconfig/libmnl.pc
>>>
>>> Suggested-by: Kai Liu <kai.liu@suse.com>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>> v2:
>>>    - use pkg-config
>>> ---
>>>    tools/testing/selftests/netfilter/Makefile | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
>>> index e4f845dd942b..8136c1fab7ab 100644
>>> --- a/tools/testing/selftests/netfilter/Makefile
>>> +++ b/tools/testing/selftests/netfilter/Makefile
>>> @@ -8,6 +8,7 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
>>>    	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
>>>    	conntrack_vrf.sh nft_synproxy.sh
>>> +CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
>>>    LDLIBS = -lmnl
>>>    TEST_GEN_FILES =  nf-queue
>>>
>>
>> Adding Pablo to the thread.
>>
>> Pablo,
>>
>> This looks good to me. I can take this through linux-kselftest tree.
>> Let me know either way.
>>
>> Or if it is going through netfilter tree:
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> If this does not cause any issue when running tests in any other
> distros, then it is fine with me.
> 

I tested this on Ubuntu 21.10 and worked for me. I will apply this for
Linux 5.18-rc1 then.

thanks,
-- Shuah
