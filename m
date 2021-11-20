Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7252457A1D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Nov 2021 01:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhKTAZY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 19:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhKTAZY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 19:25:24 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA1C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 16:22:22 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x10so14947117ioj.9
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 16:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=45aoiIXLNHX/rElliOua9/jn7RznBxUCcrDpMi0LV+8=;
        b=JCbnJJdfHDf/Ck6Y9dH93bwkVp/YCaWqIXQ/G832da1Y4FRlbORIL/8Ro3C6PDwTnh
         mTLCjDWV03dDzQH1K1sp9GXpu/xlrxYWAOqPi0AyJxfOv2u17vq4GhCBbbrD69neKC6/
         nLDiTmjnO4xe8VRpEoF8jVBAKOYnes9qv+Ipc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=45aoiIXLNHX/rElliOua9/jn7RznBxUCcrDpMi0LV+8=;
        b=TucOSms/5yMYLvo9T1tyMUx9NiNTMJhx+WrhL6GEN5CXnzlM3QfbZVheeFjWryAwp7
         G2ucxJEJ8SxOpZWBHIc4ow12h6Q1nSB84kT9qheUvMgsbXyRy394YxeHwOKIrjIDcm0k
         mUTvrSHEfToQesAYbX8OhR0hETmDmRym+Ms//yRh8eYJaaKv5Bgf2gj4/L2omt7dYE1D
         Dcb1dl3i4gvTCXo0w3EMld1x+B4bQBp+ci7oHDpSDJKC8DjB/R2gc5oueFqsFts/XE81
         Mc6sn9YUy2IMkgq7ehIdw1d4tFrYyGxM8Ec2mw4EEWH91Vs/Ds08zavvyrYHSm4D8vL4
         /HBQ==
X-Gm-Message-State: AOAM531Ui+jS/9VOdUFP00bmc06YLmNBoU66Anv9LJlKCWp+3lAiY7HD
        UEIo84AK5jHtxC0yXx1hIflPxQ==
X-Google-Smtp-Source: ABdhPJxaN5oCOmmGf4TnBvJnw+z3+nee3C+NVAWqPPJAD1cXa/QZx7wbZU4dlQ/jTRbiJcdPEhfJ7A==
X-Received: by 2002:a05:6638:238b:: with SMTP id q11mr31249300jat.43.1637367741713;
        Fri, 19 Nov 2021 16:22:21 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k11sm1093497ilv.66.2021.11.19.16.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 16:22:21 -0800 (PST)
Subject: Re: [PATCH 1/2] selftests: cgroup: build error multiple outpt files
To:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
        christian@brauner.io
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211105162530.3307666-1-anders.roxell@linaro.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <61b21c4b-fc26-5e41-3aed-22a7e56b04ba@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 17:22:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211105162530.3307666-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/21 10:25 AM, Anders Roxell wrote:
> When building selftests/cgroup: with clang the following error are seen:
> 
> clang -Wall -pthread    test_memcontrol.c cgroup_util.c ../clone3/clone3_selftests.h  -o /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol
> clang: error: cannot specify -o when generating multiple output files
> make[3]: *** [../lib.mk:146: /home/anders/.cache/tuxmake/builds/current/kselftest/cgroup/test_memcontrol] Error 1
> 
> Rework to add the header files to LOCAL_HDRS before including ../lib.mk,
> since the dependency is evaluated in '$(OUTPUT)/%:%.c $(LOCAL_HDRS)' in
> file lib.mk.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   tools/testing/selftests/cgroup/Makefile | 12 +++++++-----
>   tools/testing/selftests/lib.mk          |  2 +-
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> index 59e222460581..745fe25fa0b9 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -11,10 +11,12 @@ TEST_GEN_PROGS += test_core
>   TEST_GEN_PROGS += test_freezer
>   TEST_GEN_PROGS += test_kill
>   
> +LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
> +

This looks odd to me. Why are we introducing dependencies between tests?
clone3 includes in cgroup? Looks odd to me.

thanks,
-- Shuah
