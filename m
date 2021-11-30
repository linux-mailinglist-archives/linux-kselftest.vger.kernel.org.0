Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1CD463C0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 17:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhK3QpW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 11:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244335AbhK3QpK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 11:45:10 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980EFC061746
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Nov 2021 08:41:50 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id a11so21630143ilj.6
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Nov 2021 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qNDySkV1TDMjsXZgIAndGnAJEHYPbFyQnbCSCL0UXYc=;
        b=Fg5EfYqMvlbzQGAt7dGOr94Udoqh9O3lMIDTD7ZCrxLZmLeepT/dYuQY+xvOOJ5Lma
         o0HpC8crk9O1MHvJki29w57Z+OnRE2LP9BBC9Pn88Be6rrZEMgOT8vSy1kO4Oye/pazb
         UUaXHDFwAZPlBvDwESDQmFIrr1TUupf/B+ig4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNDySkV1TDMjsXZgIAndGnAJEHYPbFyQnbCSCL0UXYc=;
        b=aPvF41wpLArwB5GYPgJXZVI/gNhNImbLlcj8W1bSz72YuASCt3wwrimVb4YkbVJHj/
         0POhYtWaLWKx1tjdqTWOR+L1p2Orm5QX4E0RebcW7vnY5675+LU2s+CYnzIWkV0AfN4c
         uRgkXEV8KQL9HFc1n078Su8ugc/WuVwpVEyqNMHWnvbbwcGzhti9uwSiCwLcyxllRqBS
         cFNMRq370LLJuphKjlJsxoGOYZHb6hX1RtRhBR8E29c4ET5sFmsfcj8N0jd+o67RpZ6u
         UOMo4kxGEdtENVghE9GW/UjWL3yN0KB+W+uUsY+Gzxgqw6XLE5HrW3LCRo5wpgNjuzcn
         Q4fQ==
X-Gm-Message-State: AOAM530W++qqnSpHV/ghjU/9Qzp2vJiWmHgd71bO9Ij6PRh8MurR3cY2
        J9CeWB1RO+7sk9jlg+T66/eoaw==
X-Google-Smtp-Source: ABdhPJwZ6qoCwAzlKny10FO8SQ2/Nr4zqiq19J5P5L2Hq1YUBtmMr/yGDSYvri/mgotGD+VbY4YSmg==
X-Received: by 2002:a05:6e02:1a03:: with SMTP id s3mr109743ild.73.1638290510084;
        Tue, 30 Nov 2021 08:41:50 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h1sm4820725iow.31.2021.11.30.08.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:41:49 -0800 (PST)
Subject: Re: [PATCH 1/2] selftests: cgroup: build error multiple outpt files
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
        christian@brauner.io, nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211105162530.3307666-1-anders.roxell@linaro.org>
 <61b21c4b-fc26-5e41-3aed-22a7e56b04ba@linuxfoundation.org>
 <20211123142600.r5d52iwhbqhujiux@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <815f4089-49e0-aada-aaf4-83fb079abef7@linuxfoundation.org>
Date:   Tue, 30 Nov 2021 09:41:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211123142600.r5d52iwhbqhujiux@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/23/21 7:26 AM, Christian Brauner wrote:
> On Fri, Nov 19, 2021 at 05:22:20PM -0700, Shuah Khan wrote:
>> On 11/5/21 10:25 AM, Anders Roxell wrote:
>>> When building selftests/cgroup: with clang the following error are seen:
>>>
>>> clang -Wall -pthread    test_memcontrol.c cgroup_util.c ../clone3/clone3_selftests.h  -o /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol
>>> clang: error: cannot specify -o when generating multiple output files
>>> make[3]: *** [../lib.mk:146: /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol] Error 1
>>>
>>> Rework to add the header files to LOCAL_HDRS before including ../lib.mk,
>>> since the dependency is evaluated in '$(OUTPUT)/%:%.c $(LOCAL_HDRS)' in
>>> file lib.mk.
>>>
>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>>    tools/testing/selftests/cgroup/Makefile | 12 +++++++-----
>>>    tools/testing/selftests/lib.mk          |  2 +-
>>>    2 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
>>> index 59e222460581..745fe25fa0b9 100644
>>> --- a/tools/testing/selftests/cgroup/Makefile
>>> +++ b/tools/testing/selftests/cgroup/Makefile
>>> @@ -11,10 +11,12 @@ TEST_GEN_PROGS += test_core
>>>    TEST_GEN_PROGS += test_freezer
>>>    TEST_GEN_PROGS += test_kill
>>> +LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
>>> +
>>
>> This looks odd to me. Why are we introducing dependencies between tests?
>> clone3 includes in cgroup? Looks odd to me.
> 
> The cgroup tests need access to clone3() functionality in order to test
> CLONE_INTO_CGROUP which is more suited to be placed alongside the cgroup
> tests. There are a few other tests that include the clone3 header.
> 

If other tests are also including this header, we could move it up under
selftests level. Might have to add include directory.

thanks,
-- Shuah
