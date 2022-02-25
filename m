Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9454C4D8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 19:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiBYSXC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 13:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiBYSXA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 13:23:00 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EE31BE87
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 10:22:28 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id t11so7460457ioi.7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4i7Dn6xMqNIvDQ6SKHYlCE8bqBPJnnLQezZBe+tm+7E=;
        b=P6fzb+OZwpOlvaG3+EnWy1v6RTMFv/HjCAiOKJanAe76hkVLxtNE5HdrdpTBhWnZxP
         BpxRm/AAeooby+ng8DNSr6qE1UgblJnuS+pbruvGLX7cFH5ZHPSo0WfWiM56kRe20HZ5
         pzvkhw4ZAIOsXC2D2YuzQqd2s0NERUatK41Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4i7Dn6xMqNIvDQ6SKHYlCE8bqBPJnnLQezZBe+tm+7E=;
        b=SI03mJaoCTfgB+YdgQHgNjQVhHMq1+e6W/zhwNoeHbjha0bsBbje69ZdRvyOzSUt8t
         t7XDiw2Z5KIPlZ449DPQBEcQc4xs1CMIcsfcG0zL+7pHnbc9qBJZDBYnpDhArhElJm/3
         tqh6OwnPfVZm30EgIWUvNA6U/Mo8nR8YGneNr6PO2oC6UK/esApi9aXu9oydy5dbuty2
         CUNDhg+C1LAZ405PLsrDTYy5Ujt5cG2uXSMmWNNq+VscK0AeLJ4pNDAmzMdfbr3PaMTh
         XMryQznvKMrjSmWMebCDZkWtgYLE78/vNZWxL0brmvYq3Lf0kC2xAtMTG/xoHTxu9sxX
         R2tQ==
X-Gm-Message-State: AOAM5330lsVmVvXU4P8y/0AfsmvJr7z1+tUZ+3C8NgQ0QXN5rgSTU+Et
        my803ZuXKJAh2v63koO6zJ+AZw==
X-Google-Smtp-Source: ABdhPJzo/Kt9WGTU8DxFi837ltOzHh2NPMAEUvMDP0w2rSR46kgdf8Wl5YnxAc9awM/UaRhOFNu2vA==
X-Received: by 2002:a05:6638:bc1:b0:311:905f:790c with SMTP id g1-20020a0566380bc100b00311905f790cmr7025930jad.74.1645813347815;
        Fri, 25 Feb 2022 10:22:27 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d8189000000b006415781ebe5sm1957643ion.5.2022.02.25.10.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 10:22:27 -0800 (PST)
Subject: Re: [PATCH v3 0/5] selftests/resctrl: Add resctrl_tests into
 kselftest set
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <d9f81a0f-5f25-9304-fdca-fc164224a786@linuxfoundation.org>
 <TYAPR01MB63306F67590849B0354D8FB78B3E9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <34174016-e4fd-be4c-a5c0-81d63557de64@linuxfoundation.org>
Date:   Fri, 25 Feb 2022 11:22:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB63306F67590849B0354D8FB78B3E9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
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

On 2/25/22 1:03 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Shuah,
> 
>> On 2/15/22 7:26 PM, Shaopeng Tan wrote:
>>> Hello,
>>>
>>> The aim of this series is to make resctrl_tests run by using kselftest
>>> framework.
>>> - I modify resctrl_test Makefile and kselftest Makefile,
>>>     to enable build/run resctrl_tests by using kselftest framework.
>>>     Of course, users can also build/run resctrl_tests without
>>>     using framework as before.
>>> - I change the default limited time for resctrl_tests to 120 seconds, to
>>>     ensure the resctrl_tests finish in limited time on different environments.
>>> - When resctrl file system is not supported by environment or
>>>     resctrl_tests is not run as root, return skip code of kselftest framework.
>>> - If resctrl_tests does not finish in limited time, terminate it as
>>>     same as executing ctrl+c that kills parent process and child process.
>>>
>>> Difference from v2:
>>> - I reworte changelog of this patch series.
>>> - I added how to use framework to run resctrl to README. [PATCH v3
>>> 2/5]
>>> - License has no dependencies on this patch series, I separated from it this
>> patch series to another patch.
>>> https://lore.kernel.org/lkml/20211213100154.180599-1-tan.shaopeng@jp.f
>>> ujitsu.com/
>>>
>>> With regard to the limited time, I think 120s is not a problem since
>>> some tests have a longer timeout (e.g. net test is 300s). Please let me know if
>> this is wrong.
>>>
>>> Thanks,
>>>
>>> Shaopeng Tan (5):
>>>     selftests/resctrl: Kill child process before parent process terminates
>>>       if SIGTERM is received
>>>     selftests/resctrl: Make resctrl_tests run using kselftest framework
>>>     selftests/resctrl: Update README about using kselftest framework to
>>>       build/run resctrl_tests
>>>     selftests/resctrl: Change the default limited time to 120 seconds
>>>     selftests/resctrl: Fix resctrl_tests' return code to work with
>>>       selftest framework
>>>
>>>    tools/testing/selftests/Makefile              |  1 +
>>>    tools/testing/selftests/resctrl/Makefile      | 20 ++++-------
>>>    tools/testing/selftests/resctrl/README        | 34
>> +++++++++++++++++++
>>>    .../testing/selftests/resctrl/resctrl_tests.c |  4 +--
>>>    tools/testing/selftests/resctrl/resctrl_val.c |  1 +
>>>    tools/testing/selftests/resctrl/settings      |  1 +
>>>    6 files changed, 45 insertions(+), 16 deletions(-)
>>>    create mode 100644 tools/testing/selftests/resctrl/settings
>>>
>>
>> Reviewed the patches - patches 1/5, 4/5 & 5/5 don't depend on kselftest
>> framework improvements. 2/5 and 3/5 are.
>>
>> Please reorder the patches - move 4/5 and 5/5 up and make 2/5 and 3/5 the
>> last in this series. Also see comments on individual patches.
> 
> Ok, I will reorder all patches as follows, so that independent patches come first
> and Makefile related patches come last:
> [PATCH 1/5] selftests/resctrl: Kill child process before parent process terminates if SIGTERM is received
> [PATCH 4/5] selftests/resctrl: Change the default limited time to 120 seconds
> [PATCH 5/5] selftests/resctrl: Fix resctrl_tests' return code to work with selftest framework
> [PATCH 2/5] selftests/resctrl: Make resctrl_tests run using kselftest framework
> [PATCH 3/5] selftests/resctrl: Update README about using kselftest framework to build/run resctrl_tests
> [PATCH] selftests/resctrl: Add missing SPDX license to Makefile
> 
> Please let me know if I'm wrong.
> 

This split looks good to me.

thanks,
-- Shuah

