Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321C44C2079
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 01:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbiBXANx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 19:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245158AbiBXANx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 19:13:53 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04093606CC
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 16:13:24 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r7so881759iot.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 16:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XyYknUun+Ddrww1SSrtzpbIs8BRQxV9z2z6D5KQxpAY=;
        b=PinJWtVZji/D+weJjsqoeKg0vX4N/3QY6c6SUxgAbSzcAbUMYoX4GkQ2fXlSive99Z
         8a3OWxhikeYSDTUj05HdIx93dBL+yJjJTSlsqm3zWXCDYh8vTsal6pau4lehN9yD2uLX
         LxpGvmnTJI0M46W6AasnjOXHfl5M43oBeMaBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XyYknUun+Ddrww1SSrtzpbIs8BRQxV9z2z6D5KQxpAY=;
        b=a6mfTc5J9RlJMOEx5NXa1aBY2QYklK3Reh/zWnD9QOnAzf+U8y1fSUIM9XiJAk4JKH
         oF9JPEJnJXG9UJgtMbI0K330a0P9qe0T46d7Lh0ERX8PxMw8XuhU5QN0UAIAUwYfR6Tv
         YA8+c8uBbfwsKWxS++pP9bRyRmb45c7RCfyzEx20lBtdqKtwJwRuhLl/jytRXroVTp4h
         v9ka2MYo/vVInTcEq3SHTIy620/oDB31dhM3XuGF5AFNHhVYFEwQb2qsma0zjD9ENGaL
         XG8++18xXaTBXpe8NE8CCBsHGntAQ5sG2c2J8CIB/wxkhxUOk+7ghlPfe7JAaxoR9+f5
         hJ9Q==
X-Gm-Message-State: AOAM533jFnqzAJaPhzFmOabHtFTQ0RkWAjtloq/GE1jHbqWhDHUT95d5
        SRKje/v40ZFZuBh5JSi8fP6QLg==
X-Google-Smtp-Source: ABdhPJxaouIBdOY1qgwPhBXj4EVDKZPmWsmeast1LF/IxcJtpuvmSBtOjHEmhERM2vtelB4ZHvX2cg==
X-Received: by 2002:a02:19c6:0:b0:30e:e6a5:67ad with SMTP id b189-20020a0219c6000000b0030ee6a567admr41420jab.45.1645661603302;
        Wed, 23 Feb 2022 16:13:23 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d18sm681572iln.79.2022.02.23.16.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 16:13:22 -0800 (PST)
Subject: Re: [PATCH v3 2/5] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <20220216022641.2998318-3-tan.shaopeng@jp.fujitsu.com>
 <1bbc4049-2c08-39be-d82b-9d98ee663e72@linuxfoundation.org>
 <TYAPR01MB63302321D2A50D9A690993AF8B3B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5200cb0b-6417-d97b-7f17-eae4bf4b0901@linuxfoundation.org>
Date:   Wed, 23 Feb 2022 17:13:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB63302321D2A50D9A690993AF8B3B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/22/22 12:55 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Khan,
> 
>> On 2/15/22 7:26 PM, Shaopeng Tan wrote:
>>> In kselftest framework, all tests can be build/run at a time, and a
>>> sub test also can be build/run individually. As follows:
>>> $ make -C tools/testing/selftests run_tests $ make -C
>>> tools/testing/selftests TARGETS=ptrace run_tests
>>>
>>> However, resctrl_tests cannot be run using kselftest framework, users
>>> have to change directory to tools/testing/selftests/resctrl/, run
>>> "make" to build executable file "resctrl_tests", and run "sudo
>>> ./resctrl_tests" to execute the test.
>>>
>>> To build/run resctrl_tests using kselftest framework.
>>> Modify tools/testing/selftests/Makefile and
>>> tools/testing/selftests/resctrl/Makefile.
>>>
>>> Even after this change, users can still build/run resctrl_tests
>>> without using framework as before.
>>>
>>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>>> ---
>>> Some important feedbacks from v1&v2 are addressed as follows:
>>>
>>> - The changelog mentions that changes were made to the resctrl
>>>     selftest Makefile but it does not describe what the change accomplish
>>>     or why they are needed.
>>>     => By changing the Makefile, resctrl_tests can use kselftest
>>>        framework like other sub tests. I described this in changelog.
>>>
>>> - The changelog did not describe how a user may use the kselftest
>>>     framework to run the resctrl tests nor the requested information
>>>     on how existing workflows are impacted.
>>>     => I described how to build/run resctrl_tests with kselftest framework,
>>>        and described the existing workflows are not impacted that users can
>>>        build/run resctrl_tests without using kselftest framework as before.
>>>
>>> - tools/testing/selftests/resctrl/README should be updated.
>>>     => I separate the update of README to a new patch.[patch v3 3/5]
>>>
>>> - Why is the meaning of "EXTRA_SOURCES" (i.e. what is "extra"?) and
>>>     why is "SRCS" no longer sufficient?
>>>     => I referred to other Makefiles, and found "SRCS" is better
>>>        than "EXTRA_SOURCES". So, I updated it to use "SRCS".
>>>
>>>    tools/testing/selftests/Makefile         |  1 +
>>>    tools/testing/selftests/resctrl/Makefile | 20 ++++++--------------
>>>    2 files changed, 7 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/Makefile
>>> b/tools/testing/selftests/Makefile
>>> index c852eb40c4f7..7df397c6893c 100644
>>> --- a/tools/testing/selftests/Makefile
>>> +++ b/tools/testing/selftests/Makefile
>>> @@ -51,6 +51,7 @@ TARGETS += proc
>>>    TARGETS += pstore
>>>    TARGETS += ptrace
>>>    TARGETS += openat2
>>> +TARGETS += resctrl
>>>    TARGETS += rlimits
>>>    TARGETS += rseq
>>>    TARGETS += rtc
>>> diff --git a/tools/testing/selftests/resctrl/Makefile
>>> b/tools/testing/selftests/resctrl/Makefile
>>> index 6bcee2ec91a9..de26638540ba 100644
>>> --- a/tools/testing/selftests/resctrl/Makefile
>>> +++ b/tools/testing/selftests/resctrl/Makefile
>>> @@ -1,17 +1,9 @@
>>> -CC = $(CROSS_COMPILE)gcc
>>> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -SRCS=$(wildcard *.c)
>>> -OBJS=$(SRCS:.c=.o)
>>> +CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
>>>
>>> -all: resctrl_tests
>>> +TEST_GEN_PROGS := resctrl_tests
>>> +SRCS := $(wildcard *.c)
>>>
>>> -$(OBJS): $(SRCS)
>>> -	$(CC) $(CFLAGS) -c $(SRCS)
>>> +all: $(TEST_GEN_PROGS)
>>>
>>> -resctrl_tests: $(OBJS)
>>> -	$(CC) $(CFLAGS) -o $@ $^
>>> -
>>> -.PHONY: clean
>>> -
>>> -clean:
>>> -	$(RM) $(OBJS) resctrl_tests
>>> +$(TEST_GEN_PROGS): $(SRCS)
>>
>> This patch breaks the test build - the below use-cases fail
>>
>> make kselftest-all TARGETS=resctrl
>> make -C  tools/testing/selftests/ TARGETS=resctrl
>>
>> Also a simple make in tools/testing/selftests/resctr
> 
> Thanks for your feedbacks.
> I applied these patches to the source below and built
> resctrl_tests successfully using above use-cases on x86/arm machine.
> (1)
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   Tag: v5.16
> (2)
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Tag: next-20220217
> 
> Could you tell me which kernel source you used to build
> and what error message you got?
> 

I tried this on Linux 5.17-rc4

thanks,
-- Shuah
