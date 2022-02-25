Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600814C4D86
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 19:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiBYSVX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 13:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiBYSVW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 13:21:22 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258201F9801
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 10:20:50 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r7so7478896iot.3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 10:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MWLlCQx/OHozBmLwVGzmPeq2Ic2iWbuSjFqtIjn7Lz8=;
        b=V8r36s3vT+1gs9l0tfc87OEjEEk2YBK14rZMzKm8N9OdsZrvjU2tslt20Ljk8UQPSK
         OympIVHSG6d24g+b66Ds/k48iSb9vd+wkZO9c7PR8/1M+TSsQcXa2HB2yHa1wiHcIhPe
         kwujV1XNG+iTQaHtMJKccdwQt3OJuaL86Agig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MWLlCQx/OHozBmLwVGzmPeq2Ic2iWbuSjFqtIjn7Lz8=;
        b=DepiZsc7pGqR5pazTN5aj0PHiy9sdnPZySGfAYIbEu6P8YzOEU56GwW3/KB81tG3Ao
         /22oMnshrkWfB8O32KFoC/0VvEZHicHRJjpJLnFtf05izFB/QcZ5R7mneRkqSd0FR4j9
         xrQemb5AACHHcwke3M6Twup9GF8dSbUGKOmnz/gd//0vWVhBkxcahhigaxqfl2lY91t/
         deTYVp/8/+WRsNtpQ/swloIH/aDlDGi3//jUXn8ZowSC+uN993WA568H6GII4WMQmWl9
         35EchtPAUuG5FAhpHR9Lc2ryzmCfHRVS0J3qmSUxjsl25k7+WUIS6mGqPGuZOtG78iB5
         Fylw==
X-Gm-Message-State: AOAM532qWZEX3vFVEUvROEEFuPidgK8Mkf+8dMpBp/bpsx5sWTMI8SMP
        Ml8UTxh59NiBL8FL1fwPUXffHQ==
X-Google-Smtp-Source: ABdhPJxfC2RtKazndNmHoXswy1ToULjeL9n9L0TlP95AwtBRC1K5bIpUGaxwCkBuHDLSrxmhCCMk5A==
X-Received: by 2002:a02:c850:0:b0:30e:54b4:d8de with SMTP id r16-20020a02c850000000b0030e54b4d8demr6784696jao.146.1645813249475;
        Fri, 25 Feb 2022 10:20:49 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w25-20020a5ed619000000b00640d84049c0sm1876803iom.20.2022.02.25.10.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 10:20:49 -0800 (PST)
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
 <5200cb0b-6417-d97b-7f17-eae4bf4b0901@linuxfoundation.org>
 <TYAPR01MB6330E0C641FC7F0EEE0DCA688B3E9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <04c4e4b1-b499-8d35-2eb6-9914cc579c0b@linuxfoundation.org>
Date:   Fri, 25 Feb 2022 11:20:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB6330E0C641FC7F0EEE0DCA688B3E9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/25/22 1:02 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Shuah,
> 
>> On 2/22/22 12:55 AM, tan.shaopeng@fujitsu.com wrote:
>>> Hi Khan,
>>>
>>>> On 2/15/22 7:26 PM, Shaopeng Tan wrote:
>>>>> In kselftest framework, all tests can be build/run at a time, and a
>>>>> sub test also can be build/run individually. As follows:
>>>>> $ make -C tools/testing/selftests run_tests $ make -C
>>>>> tools/testing/selftests TARGETS=ptrace run_tests
>>>>>
>>>>> However, resctrl_tests cannot be run using kselftest framework,
>>>>> users have to change directory to tools/testing/selftests/resctrl/,
>>>>> run "make" to build executable file "resctrl_tests", and run "sudo
>>>>> ./resctrl_tests" to execute the test.
>>>>>
>>>>> To build/run resctrl_tests using kselftest framework.
>>>>> Modify tools/testing/selftests/Makefile and
>>>>> tools/testing/selftests/resctrl/Makefile.
>>>>>
>>>>> Even after this change, users can still build/run resctrl_tests
>>>>> without using framework as before.
>>>>>
>>>>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>>>>> ---
>>>>> Some important feedbacks from v1&v2 are addressed as follows:
>>>>>
>>>>> - The changelog mentions that changes were made to the resctrl
>>>>>      selftest Makefile but it does not describe what the change
>> accomplish
>>>>>      or why they are needed.
>>>>>      => By changing the Makefile, resctrl_tests can use kselftest
>>>>>         framework like other sub tests. I described this in changelog.
>>>>>
>>>>> - The changelog did not describe how a user may use the kselftest
>>>>>      framework to run the resctrl tests nor the requested information
>>>>>      on how existing workflows are impacted.
>>>>>      => I described how to build/run resctrl_tests with kselftest
>> framework,
>>>>>         and described the existing workflows are not impacted that users
>> can
>>>>>         build/run resctrl_tests without using kselftest framework as
>> before.
>>>>>
>>>>> - tools/testing/selftests/resctrl/README should be updated.
>>>>>      => I separate the update of README to a new patch.[patch v3 3/5]
>>>>>
>>>>> - Why is the meaning of "EXTRA_SOURCES" (i.e. what is "extra"?) and
>>>>>      why is "SRCS" no longer sufficient?
>>>>>      => I referred to other Makefiles, and found "SRCS" is better
>>>>>         than "EXTRA_SOURCES". So, I updated it to use "SRCS".
>>>>>
>>>>>     tools/testing/selftests/Makefile         |  1 +
>>>>>     tools/testing/selftests/resctrl/Makefile | 20 ++++++--------------
>>>>>     2 files changed, 7 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/Makefile
>>>>> b/tools/testing/selftests/Makefile
>>>>> index c852eb40c4f7..7df397c6893c 100644
>>>>> --- a/tools/testing/selftests/Makefile
>>>>> +++ b/tools/testing/selftests/Makefile
>>>>> @@ -51,6 +51,7 @@ TARGETS += proc
>>>>>     TARGETS += pstore
>>>>>     TARGETS += ptrace
>>>>>     TARGETS += openat2
>>>>> +TARGETS += resctrl
>>>>>     TARGETS += rlimits
>>>>>     TARGETS += rseq
>>>>>     TARGETS += rtc
>>>>> diff --git a/tools/testing/selftests/resctrl/Makefile
>>>>> b/tools/testing/selftests/resctrl/Makefile
>>>>> index 6bcee2ec91a9..de26638540ba 100644
>>>>> --- a/tools/testing/selftests/resctrl/Makefile
>>>>> +++ b/tools/testing/selftests/resctrl/Makefile
>>>>> @@ -1,17 +1,9 @@
>>>>> -CC = $(CROSS_COMPILE)gcc
>>>>> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -SRCS=$(wildcard *.c)
>>>>> -OBJS=$(SRCS:.c=.o)
>>>>> +CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
>>>>>
>>>>> -all: resctrl_tests
>>>>> +TEST_GEN_PROGS := resctrl_tests
>>>>> +SRCS := $(wildcard *.c)
>>>>>
>>>>> -$(OBJS): $(SRCS)
>>>>> -	$(CC) $(CFLAGS) -c $(SRCS)
>>>>> +all: $(TEST_GEN_PROGS)
>>>>>
>>>>> -resctrl_tests: $(OBJS)
>>>>> -	$(CC) $(CFLAGS) -o $@ $^
>>>>> -
>>>>> -.PHONY: clean
>>>>> -
>>>>> -clean:
>>>>> -	$(RM) $(OBJS) resctrl_tests
>>>>> +$(TEST_GEN_PROGS): $(SRCS)
>>>>
>>>> This patch breaks the test build - the below use-cases fail
>>>>
>>>> make kselftest-all TARGETS=resctrl
>>>> make -C  tools/testing/selftests/ TARGETS=resctrl
>>>>
>>>> Also a simple make in tools/testing/selftests/resctr
>>>
>>> Thanks for your feedbacks.
>>> I applied these patches to the source below and built resctrl_tests
>>> successfully using above use-cases on x86/arm machine.
>>> (1)
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>    Tag: v5.16
>>> (2)
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>    Tag: next-20220217
>>>
>>> Could you tell me which kernel source you used to build and what error
>>> message you got?
>>>
>>
>> I tried this on Linux 5.17-rc4
> 
> I tried these patches on Linux 5.17-rc4 with gcc version 8.4.1
> and resctrl_tests is still built successfully.
> 
> Could you tell me what error message you got when you built it?

Here it is:

make
gcc   resctrl_tests.o cache.c cat_test.c cmt_test.c fill_buf.c mba_test.c mbm_test.c resctrlfs.c resctrl_tests.c resctrl_val.c   -o resctrl_tests
/usr/bin/ld: /tmp/ccoarGr4.o:(.bss+0x0): multiple definition of `is_amd'; resctrl_tests.o:/linux/linux_5.17/tools/testing/selftests/resctrl/resctrl_tests.c:16: first defined here
/usr/bin/ld: /tmp/ccoarGr4.o: in function `detect_amd':
resctrl_tests.c:(.text+0x63b): multiple definition of `detect_amd'; resctrl_tests.o:/linux/linux_5.17/tools/testing/selftests/resctrl/resctrl_tests.c:19: first defined here
/usr/bin/ld: /tmp/ccoarGr4.o: in function `tests_cleanup':
resctrl_tests.c:(.text+0x780): multiple definition of `tests_cleanup'; resctrl_tests.o:/linux/linux_5.17/tools/testing/selftests/resctrl/resctrl_tests.c:50: first defined here
/usr/bin/ld: /tmp/ccoarGr4.o: in function `main':
resctrl_tests.c:(.text+0xadd): multiple definition of `main'; resctrl_tests.o:/linux/linux_5.17/tools/testing/selftests/resctrl/resctrl_tests.c:129: first defined here
collect2: error: ld returned 1 exit status
make: *** [<builtin>: resctrl_tests] Error 1

I have gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0

Take a look at the changes to
tools/testing/selftests/resctrl/Makefile

I don't think you need to make the changes you made. I would start
small with including lib.mk and work from there.

thanks,
-- Shuah
