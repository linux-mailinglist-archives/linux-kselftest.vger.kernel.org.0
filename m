Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877F86AA0A2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 21:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCCUfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 15:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjCCUfP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 15:35:15 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C55D881
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Mar 2023 12:35:13 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id i4so2474262ils.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Mar 2023 12:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677875712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIG2lbV3x/WX9TfJ5m60GjgJzOprT7gRvYSAmb5a31o=;
        b=FJ6sA/TjbHdt21vqiG/xhHJRqG1X3Ljh5C7RueEy8gydHu9b2Jl9lOsiOWbdjiIaf5
         rceMPxoDBWdfvkHh5/Zi9ac+wskE7SL5PgGSxco/M8lFW2YrttbpyE3KhC/I7BNsceXa
         XBSR3g2ufq3iNR30Amjty05e/yfyUuVnFAb30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIG2lbV3x/WX9TfJ5m60GjgJzOprT7gRvYSAmb5a31o=;
        b=vfz4KrKeAgwKGmQdD4E0n+9Vvsmx4/bg4OqO2UeLMYEFMg8Ok/ijbcLuIDH9OLUIow
         Q5wHm/73TBWECzhSuyOm78J2RP0aE6oBMvndIM05aIBbS46qHOh5J6BPqcJHiT4TdNu0
         qcA3r1VusZB/KLdA7PnRC0/+p5tGJ+Lg7iLEKWIzt9YIg2LI6AwmmNlSXTmeCFNbmg4t
         35RPmr9+HXQHr7VdsB4lo256uH7bfqVCHUJb40tptoKCygkt4m3lOH88ogAzdjRAhUSl
         lj4/N+AlIz3Jq2DQE7kcMVKJHtO0UYTvKLNqvhxYVsVBdz1GGyKQuSOgV+l5a9xY7AtG
         WmFA==
X-Gm-Message-State: AO0yUKVoPhl/6Rk01s6SepdmNk6HMcsiUg2pSt09E9sis5PsyNnl8s3K
        0myLkn9qHnmEEXqFVtTsyPfAEw==
X-Google-Smtp-Source: AK7set+2ZPUb82QYuAk/QXD4BGuCC4sZziz3GWsudAilWkd7LUyCFZMZW8PST6dhsPxBvdfaA9ljsg==
X-Received: by 2002:a05:6e02:156d:b0:313:fb1b:2f86 with SMTP id k13-20020a056e02156d00b00313fb1b2f86mr2340332ilu.0.1677875712434;
        Fri, 03 Mar 2023 12:35:12 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e5-20020a02a785000000b003a971c488cesm969583jaj.173.2023.03.03.12.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:35:11 -0800 (PST)
Message-ID: <537d3d3d-9ecc-bdd9-f703-708f6826d1f2@linuxfoundation.org>
Date:   Fri, 3 Mar 2023 13:35:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] selftests/kmod: increase the kmod timeout from 45 to
 165
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.de, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, keescook@chromium.org,
        tweek@google.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230206234344.2433950-1-mcgrof@kernel.org>
 <20230206234344.2433950-2-mcgrof@kernel.org>
 <b094dc23-a96d-93c4-a350-8fb92476f431@linuxfoundation.org>
 <Y/0xx0cedxlRMKpH@bombadil.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y/0xx0cedxlRMKpH@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/27/23 15:42, Luis Chamberlain wrote:
> On Mon, Feb 27, 2023 at 03:32:50PM -0700, Shuah Khan wrote:
>> On 2/6/23 16:43, Luis Chamberlain wrote:
>>> The default sefltests timeout is 45 seconds. If you run the kmod
>>> selftests on your own with say:
>>>
>>> ./tools/testings/selftests/kmod.sh
>>>
>>> Then the default timeout won't be in effect.
>>>
>>> I've never ran kmod selftests using the generic make wrapper
>>> (./tools/testing/selftests/run_kselftest.sh -s) util now
>>> that I have support for it on kdevops [0]. And with that the
>>> test is limitted to the default timeout which we quickly run
>>> into. Bump this up to what I see is required on 8GiB / 8 vcpu
>>> libvirt q35 guest as can be easily created now with kdevops.
>>>
>>> To run selftests with kdevops:
>>>
>>> make menuconfig # enable dedicated selftests and kmod test
>>> make
>>> make bringup
>>> make linux
>>> make selftests-kmod
>>>
>>> This ends up taking about 280 seconds now, give or take add
>>> 50 seconds more more and we end up with 350. Document the
>>> rationale.
>>>
>>> [0] https://github.com/linux-kdevops/kdevops
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> ---
>>>    tools/testing/selftests/kmod/settings | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>    create mode 100644 tools/testing/selftests/kmod/settings
>>>
>>> diff --git a/tools/testing/selftests/kmod/settings b/tools/testing/selftests/kmod/settings
>>> new file mode 100644
>>> index 000000000000..6fca0f1a4594
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/kmod/settings
>>> @@ -0,0 +1,4 @@
>>> +# measured from a manual run:
>>> +# time ./tools/testing/selftests/kmod/kmod.sh
>>> +# Then add ~50 seconds more gracetime.
>>> +timeout=350
>>
>> Adding timeouts like this for individual tests increases the overall kselftest
>> run-time. I am not in favor of adding timeouts.
>>
>> We have to find a better way to do this.
> 
> Well if folks don't have this the test will fail, and so a false
> positive. If the goal is to have a low time timeout for "do not run
> tests past this time and do not fail if we stopped the test" then
> that seems to be likely one way to go and each test may need to be
> modified to not fail fatally in case of a special signal.
> 

We are finding more and more that timeout values are requiring
tweaks. I am in favor of coming up a way to exit the test with
a timeout condition.

thanks,
-- Shuah

