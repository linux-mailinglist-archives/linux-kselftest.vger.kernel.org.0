Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7B9467C36
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 18:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353056AbhLCRML (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 12:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353038AbhLCRMK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 12:12:10 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDCEC061353
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 09:08:46 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id a11so3366548ilj.6
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 09:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1RDvbrYOX+dfwz42a6cMLN1shF07/G7vOPaQYwXhXQ4=;
        b=UOOJS0iIGifCWj8ZQ9itfcgA2SGqCaE6OL6GZSdYz/PhJD4HHWeDk9Sqna5QJq1vJ+
         gLo4apTwfTkF9S6yGyrflLRlQiIfvtpfKNFL6dxmkMAIlmDG+dn84QsOnnCsmWiSGVa6
         mberxGs3zV6chnvGoL8LQT8jggX0ln44F217Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1RDvbrYOX+dfwz42a6cMLN1shF07/G7vOPaQYwXhXQ4=;
        b=QPxkDluNwrDAvnSoQ0YEF8aWBqrMwELOz+HLZxr9Ibx1DruBjryO6/sMSaLGgXsriE
         Vs4qLTlNeJp3ULIXx/moosU1oB7kHfV/4fezWCNoELvdXf23DWfgnzsEQ4VZYId4rV/P
         lXt8HXw9++pBbL8QpuaAAQEtqMXWxEtEXF/Hst2VXH5yY3vYDdo1KwgLYku2we/FcZiu
         2a8Wl2I4UidmcBABQQpLyO5YigqX7DZ66Deaplq/+mUK3oH/eJ14IL5McmRcEDLSj/Tk
         2OVwOHKCZ2k4d6iMPRx2BG/L1CcsjExXYBFxWIEv1lmfeH4Dq+AoXxoF46KYotRXXMXH
         JtEA==
X-Gm-Message-State: AOAM532z3sQ8bDBPtoyyG4zmIdPQadr5ss1HrhL38COtQzuDGh64J4Sk
        m+RHtPBRrK3Gy5+BxM5irowmfK+QXKfhQA==
X-Google-Smtp-Source: ABdhPJxGd5YO1gtYaBYMSdBs1JnsaybLx9cKTocrYXdbPPzNQo2azTR4LN8EAx9i28ftujoaAXt0Jw==
X-Received: by 2002:a05:6e02:12c2:: with SMTP id i2mr18518681ilm.155.1638551325638;
        Fri, 03 Dec 2021 09:08:45 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b8sm2098487iow.2.2021.12.03.09.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 09:08:45 -0800 (PST)
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
 <815f4089-49e0-aada-aaf4-83fb079abef7@linuxfoundation.org>
 <20211201130637.phskqu7rkl5ty2xq@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6c8ef410-479a-a218-81ef-2131cd9a3663@linuxfoundation.org>
Date:   Fri, 3 Dec 2021 10:08:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211201130637.phskqu7rkl5ty2xq@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/1/21 6:06 AM, Christian Brauner wrote:
> On Tue, Nov 30, 2021 at 09:41:49AM -0700, Shuah Khan wrote:
>> On 11/23/21 7:26 AM, Christian Brauner wrote:
>>> On Fri, Nov 19, 2021 at 05:22:20PM -0700, Shuah Khan wrote:
>>>> On 11/5/21 10:25 AM, Anders Roxell wrote:
>>>>> When building selftests/cgroup: with clang the following error are seen:
>>>>>
>>>>> clang -Wall -pthread    test_memcontrol.c cgroup_util.c ../clone3/clone3_selftests.h  -o /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol
>>>>> clang: error: cannot specify -o when generating multiple output files
>>>>> make[3]: *** [../lib.mk:146: /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol] Error 1
>>>>>
>>>>> Rework to add the header files to LOCAL_HDRS before including ../lib.mk,
>>>>> since the dependency is evaluated in '$(OUTPUT)/%:%.c $(LOCAL_HDRS)' in
>>>>> file lib.mk.
>>>>>
>>>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>>> ---
>>>>>     tools/testing/selftests/cgroup/Makefile | 12 +++++++-----
>>>>>     tools/testing/selftests/lib.mk          |  2 +-
>>>>>     2 files changed, 8 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
>>>>> index 59e222460581..745fe25fa0b9 100644
>>>>> --- a/tools/testing/selftests/cgroup/Makefile
>>>>> +++ b/tools/testing/selftests/cgroup/Makefile
>>>>> @@ -11,10 +11,12 @@ TEST_GEN_PROGS += test_core
>>>>>     TEST_GEN_PROGS += test_freezer
>>>>>     TEST_GEN_PROGS += test_kill
>>>>> +LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
>>>>> +
>>>>
>>>> This looks odd to me. Why are we introducing dependencies between tests?
>>>> clone3 includes in cgroup? Looks odd to me.
>>>
>>> The cgroup tests need access to clone3() functionality in order to test
>>> CLONE_INTO_CGROUP which is more suited to be placed alongside the cgroup
>>> tests. There are a few other tests that include the clone3 header.
>>>
>>
>> If other tests are also including this header, we could move it up under
>> selftests level. Might have to add include directory.
> 
> No objection from me if that's useful. I won't have time for that in the
> near future. (This might be of interest for one of the LF programs that
> help get new folks interested in kernel development started.)
> 
> Christian
> 

Thanks. I will apply this fix for now.

thanks,
-- Shuah
