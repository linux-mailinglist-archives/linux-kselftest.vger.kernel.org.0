Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332FB6AC75F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjCFQMQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 11:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjCFQL7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 11:11:59 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76B4FA88
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 08:08:38 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 76so4207636iou.9
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 08:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678118803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7dAgDboD1nwP5+XX6Gpi6cj6HuqQDphe3J0S8kZqwA=;
        b=cmwkGk0sfDxLR0/c/zD8q+CxEYBkWnqe2zJi29SN0wR76WgMhwakXUaUDgl+/ibRRX
         ybb2Glc9vdkT/k60sZoh/0wLZ3lRUumuJxyopfVdDHEJ+Qx0jnEkS92eZO3JvSRRAeCP
         B+TDlfkL84dD5TD1LRW6wSEU+RnRARQbRa9OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678118803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7dAgDboD1nwP5+XX6Gpi6cj6HuqQDphe3J0S8kZqwA=;
        b=OZtkheTwi6NCr3MNvefzfMXR11Vq/HiLSzDKHQUf9U3qo3tjM2ExK12mXt6yNaZk/r
         CPcEfQlChyCCB9bmIPBmveL7Bs2FVU8+HLvGS5zKKkokuoAgWc5QFJ2Bg7by7QtkpEcZ
         YCH6dD8T+mA23+cCS9kG2B+di2XA0tyPljrOoB6KdKRHKrahRffv87fxIz0dLtktCSAN
         TvaVOv+lXveLnjyZYbWh+i+nZ6fBAR43KEE50Z7IBGtc3mlAgzrsh1t6JDBNRK0vJ87q
         T3s+Ice5i2osn/tzC8HKLuYvWWIlu9zQxjo45+Gt2GKr9edY8LIkUQvzz6KXqUYJ83eE
         7AWQ==
X-Gm-Message-State: AO0yUKWe/jlZzJ7Ww1eLObPrVTS26Rh1GhsXCDNmO5lxckXfnlBsZkrh
        B/+xMHkfOIsBrocLSuC/rDGY4Q==
X-Google-Smtp-Source: AK7set/5wMHvgBGYNORNTLIQc8lg5UH9pESn3evMck0I8U2TUY+aFX1R4Mnp6ivgn4D8wf8+cM17Hw==
X-Received: by 2002:a6b:5a0e:0:b0:72c:f57a:a37b with SMTP id o14-20020a6b5a0e000000b0072cf57aa37bmr6270225iob.2.1678118802712;
        Mon, 06 Mar 2023 08:06:42 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y6-20020a6bc406000000b00743fe29dd56sm3442423ioa.4.2023.03.06.08.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 08:06:42 -0800 (PST)
Message-ID: <9a0e7062-2d16-3743-ffb6-a6b56bfbbd20@linuxfoundation.org>
Date:   Mon, 6 Mar 2023 09:06:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] selftests/kmod: increase the kmod timeout from 45 to
 165
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
 <537d3d3d-9ecc-bdd9-f703-708f6826d1f2@linuxfoundation.org>
 <ZAJrFvIDj98C9SkD@bombadil.infradead.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZAJrFvIDj98C9SkD@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/23 14:48, Luis Chamberlain wrote:
> On Fri, Mar 03, 2023 at 01:35:10PM -0700, Shuah Khan wrote:
>> On 2/27/23 15:42, Luis Chamberlain wrote:
>>> On Mon, Feb 27, 2023 at 03:32:50PM -0700, Shuah Khan wrote:
>>>> On 2/6/23 16:43, Luis Chamberlain wrote:
>>>>> The default sefltests timeout is 45 seconds. If you run the kmod
>>>>> selftests on your own with say:
>>>>>
>>>>> ./tools/testings/selftests/kmod.sh
>>>>>
>>>>> Then the default timeout won't be in effect.
>>>>>
>>>>> I've never ran kmod selftests using the generic make wrapper
>>>>> (./tools/testing/selftests/run_kselftest.sh -s) util now
>>>>> that I have support for it on kdevops [0]. And with that the
>>>>> test is limitted to the default timeout which we quickly run
>>>>> into. Bump this up to what I see is required on 8GiB / 8 vcpu
>>>>> libvirt q35 guest as can be easily created now with kdevops.
>>>>>
>>>>> To run selftests with kdevops:
>>>>>
>>>>> make menuconfig # enable dedicated selftests and kmod test
>>>>> make
>>>>> make bringup
>>>>> make linux
>>>>> make selftests-kmod
>>>>>
>>>>> This ends up taking about 280 seconds now, give or take add
>>>>> 50 seconds more more and we end up with 350. Document the
>>>>> rationale.
>>>>>
>>>>> [0] https://github.com/linux-kdevops/kdevops
>>>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>>>> ---
>>>>>     tools/testing/selftests/kmod/settings | 4 ++++
>>>>>     1 file changed, 4 insertions(+)
>>>>>     create mode 100644 tools/testing/selftests/kmod/settings
>>>>>
>>>>> diff --git a/tools/testing/selftests/kmod/settings b/tools/testing/selftests/kmod/settings
>>>>> new file mode 100644
>>>>> index 000000000000..6fca0f1a4594
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/kmod/settings
>>>>> @@ -0,0 +1,4 @@
>>>>> +# measured from a manual run:
>>>>> +# time ./tools/testing/selftests/kmod/kmod.sh
>>>>> +# Then add ~50 seconds more gracetime.
>>>>> +timeout=350
>>>>
>>>> Adding timeouts like this for individual tests increases the overall kselftest
>>>> run-time. I am not in favor of adding timeouts.
>>>>
>>>> We have to find a better way to do this.
>>>
>>> Well if folks don't have this the test will fail, and so a false
>>> positive. If the goal is to have a low time timeout for "do not run
>>> tests past this time and do not fail if we stopped the test" then
>>> that seems to be likely one way to go and each test may need to be
>>> modified to not fail fatally in case of a special signal.
>>>
>>
>> We are finding more and more that timeout values are requiring
>> tweaks. I am in favor of coming up a way to exit the test with
>> a timeout condition.
> 
> OK so do we use the existing timeout as a "optional, I don't want my
> test to take longer than this" or "if this test takes longer than
> this amount this is a fatal issue"?

It isn't a fatal issue. So I wouldn't call it one. I would add a
message saying test timed out.

One way to handle this is:
- Add a test run-time option and have user tune it as needed.

Make the timeout an option so users can set it based on their
environments.

> 
> I ask because right now we can't override it even with an environment
> variable. If we had such support we can let test runners (like kdevops)
> use selftests with its own set of qualified / verified timeouts for the
> VMs it uses.
> 
> For instance, Iw ant to soon start asking 0day to enable my kdevops
> 0-day tests for the subsystems I maintain, but I can't do that yet as
> the timeout is not correct.

This test isn't part of the default run, so day has to run this as a
special case and it would make prefect sense to provide a tunable
timeout option.

thanks,
-- Shuah
> 
>    Luis

