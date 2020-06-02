Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17CE1EC008
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFBQce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgFBQcd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 12:32:33 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F119C08C5C0
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Jun 2020 09:32:33 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x202so12090968oix.11
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jun 2020 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OIPqrxkSqnuynSyRY7vRQBZYHR+WMgRkEpmVgbjrHTc=;
        b=HG6Wxw5rrMdJqd7hGhdtskkbbmAPB2XQ3eAV+2Qcl4rpBYsCOjygxljQAyM2Jy1kkk
         XFsQwe32kPYBzlFBb+/7mRLKidJ8bE8akWMH+cBzQ8TYU6c/cKGrZwdDuhsQkBuWfPbB
         rvCONwG6lFEiU8Bpx5royuU3hazmbnnAxlavo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIPqrxkSqnuynSyRY7vRQBZYHR+WMgRkEpmVgbjrHTc=;
        b=fyp7h6Ltfi5Of/YoqaL0vlixpELS1Qb/7MXX7/aesHwcEuFQ+9+HKgwGxl2Rdhae6x
         3KunnS+8l9dZ51rdnKPaobfKHVVW1i0tjxwtlhCynsi3kyIUYVX0eEchdSs92ERfVJ1U
         koAwKBKMCKL87vtrMVS0F5JuMfHTfODBozh+/QabJ3N2p/l8A5TDn1Wq/1gIx5cXVNpC
         ERqmRQ1tpBaibFKPtAcZs3KMZVXdRd+OlM7YUhqPTcy1yPLxMAQdEQR4NB2BJnXC+VCL
         hRN/MuDskmE+UIK5LpUQEJ2rBtyKEh0uj8q8PcpnsphVpSuNv6ZWVw9YVzHtMe3NFoiD
         R3ZA==
X-Gm-Message-State: AOAM5310VxEKm2TEvZV2SkC4JMtwO/HgQplsK1n3UaB/LULs/riLmN6E
        /kfO/DYrvG1XU5tYN9KxZuGHYQ==
X-Google-Smtp-Source: ABdhPJyuZvnoCIiugarIgnNCPIIZA/ndxaeoH02CojLkcB8mkMHhNJzZuOixiJQetxBh///FWvlBuA==
X-Received: by 2002:aca:4c15:: with SMTP id z21mr3660499oia.85.1591115552974;
        Tue, 02 Jun 2020 09:32:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 33sm751060ott.0.2020.06.02.09.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 09:32:32 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests, sysctl, lib: Fix prime_numbers and sysctl
 test to run
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <218210da-7d06-5b6e-13af-13a07e8e7064@linuxfoundation.org>
 <20200529233942.a47bbd8e918175e9af3fefab@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <834784a5-835f-d42d-9cdb-2dbf3139f0b5@linuxfoundation.org>
Date:   Tue, 2 Jun 2020 10:32:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529233942.a47bbd8e918175e9af3fefab@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/29/20 8:39 AM, Masami Hiramatsu wrote:
> On Fri, 29 May 2020 08:14:39 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 5/28/20 8:51 AM, Masami Hiramatsu wrote:
>>> Hi,
>>>
>>> Recently, I found some tests were always skipped.
>>> Here is a series of patches to fix those issues.
>>>
>>> The prime_numbers test is skipped in some cases because
>>> prime_numbers.ko is not always compiled.
>>> Since the CONFIG_PRIME_NUMBERS is not independently
>>> configurable item (it has no title and help), it is enabled
>>> only if other configs (DRM_DEBUG_SELFTEST etc.) select it.
>>>
>>> To fix this issue, I added a title and help for
>>> CONFIG_PRIME_NUMBERS.
>>>
>>> The sysctl test is skipped because
>>>    - selftests/sysctl/config requires CONFIG_TEST_SYSCTL=y. But
>>>      since lib/test_sysctl.c doesn't use module_init(), the
>>>      test_syscall is not listed under /sys/module/ and the
>>>      test script gives up.
>>>    - Even if we make CONFIG_TEST_SYSCTL=m, the test script checks
>>>      /sys/modules/test_sysctl before loading module and gives up.
>>>    - Ayway, since the test module introduces useless sysctl
>>>      interface to the kernel, it would better be a module.
>>>
>>> This series includes fixes for above 3 points.
>>>    - Fix lib/test_sysctl.c to use module_init()
>>>    - Fix tools/testing/selftests/sysctl/sysctl.sh to try to load
>>>      test module if it is not loaded (nor embedded).
>>>    - Fix tools/testing/selftests/sysctl/config to require
>>>      CONFIG_TEST_SYSCTL=m, not y.
>>>
>>> Thank you,
>>>
>>> ---
>>>
>>> Masami Hiramatsu (4):
>>>         lib: Make prime number generator independently selectable
>>>         lib: Make test_sysctl initialized as module
>>>         selftests/sysctl: Fix to load test_sysctl module
>>>         selftests/sysctl: Make sysctl test driver as a module
>>>
>>>
>>>    lib/math/Kconfig                         |    7 ++++++-
>>>    lib/test_sysctl.c                        |    2 +-
>>>    tools/testing/selftests/sysctl/config    |    2 +-
>>>    tools/testing/selftests/sysctl/sysctl.sh |   13 ++-----------
>>>    4 files changed, 10 insertions(+), 14 deletions(-)
>>>
>>> --
>>> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
>>>
>>
>> Thanks Masami. I see Kees reviewing patches. I will wait for Luis to
>> weigh in on patch 2 before pulling this series in.
> 
> OK, Thanks Shuah!
> 
> 

Applied to linux-kselftest next for Linux 5.8-rc1.

thanks,
-- Shuah
