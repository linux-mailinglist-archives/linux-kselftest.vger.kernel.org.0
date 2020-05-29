Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AAB1E7FE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 16:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgE2OOn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2OOm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 10:14:42 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA819C03E969
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 07:14:41 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h7so2042189otr.3
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dwfdBt6MNJ0tS8gZFOZy2adyJ873xKDyxvzwYkXq+q4=;
        b=FtWcJhYo8DaeyqYqrs1fmFDmd/pNzDtwoz0NNOgOtc0UpnlJMkCOVnBJ/zjV/3ckoq
         7u9eJod64sbCWvgOjCLpvLpR1TrslJahPrq+aqT87HyHlYT6laei2vFTt+MkSPbrY/XH
         YqjE7NrL/MEmorW8CTaU/kVke19ceMraHIMCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dwfdBt6MNJ0tS8gZFOZy2adyJ873xKDyxvzwYkXq+q4=;
        b=Iehcy6GIICYpgIP7pMzicKlPZ4VDuBFuI4iyaU4dJt0gGLtyQjlRVk0kylD1OIsZ4d
         GyLP6Tnyk4mol+DRCe0rEE/OtEr38GisDfYmakF7dPu6UcddootDorsfUqYqPK2rUwx9
         sMGMJzy2VaXVfZvMacTmOjkclMpocOavgRXTmCcdWSlt65TNIWTLZ4wUmxiIARAlhHcI
         6TbBNqrSdjZ7WjsUOOU3PVwhWBql1ggtYRPudk1G6jyMxQmr16LEbJ7G9B4YUgnMxuk1
         7dL22hN0/DvUmUZ/W1yH7wcZssjkLeTzryw7JmaPzh7sAUbdm5V7WUWZNvWvDA4RYjOy
         db2A==
X-Gm-Message-State: AOAM530SHbUhahfc3bJYdRxJ+ki95YuvdLqfAlzZYaP8szXzPahkSIa9
        by5T20UFEFLy4qrHnZefiOCM+g==
X-Google-Smtp-Source: ABdhPJySK6gsZgroSQhXgG9wNYlbneWRx+x+0IHfUzGT7tDDbhsu+/qEYE9lLrwY48fhUzTVyj8X6Q==
X-Received: by 2002:a9d:400d:: with SMTP id m13mr4694613ote.98.1590761681211;
        Fri, 29 May 2020 07:14:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c3sm2481011otb.47.2020.05.29.07.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 07:14:40 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests, sysctl, lib: Fix prime_numbers and sysctl
 test to run
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <218210da-7d06-5b6e-13af-13a07e8e7064@linuxfoundation.org>
Date:   Fri, 29 May 2020 08:14:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <159067751438.229397.6746886115540895104.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/28/20 8:51 AM, Masami Hiramatsu wrote:
> Hi,
> 
> Recently, I found some tests were always skipped.
> Here is a series of patches to fix those issues.
> 
> The prime_numbers test is skipped in some cases because
> prime_numbers.ko is not always compiled.
> Since the CONFIG_PRIME_NUMBERS is not independently
> configurable item (it has no title and help), it is enabled
> only if other configs (DRM_DEBUG_SELFTEST etc.) select it.
> 
> To fix this issue, I added a title and help for
> CONFIG_PRIME_NUMBERS.
> 
> The sysctl test is skipped because
>   - selftests/sysctl/config requires CONFIG_TEST_SYSCTL=y. But
>     since lib/test_sysctl.c doesn't use module_init(), the
>     test_syscall is not listed under /sys/module/ and the
>     test script gives up.
>   - Even if we make CONFIG_TEST_SYSCTL=m, the test script checks
>     /sys/modules/test_sysctl before loading module and gives up.
>   - Ayway, since the test module introduces useless sysctl
>     interface to the kernel, it would better be a module.
> 
> This series includes fixes for above 3 points.
>   - Fix lib/test_sysctl.c to use module_init()
>   - Fix tools/testing/selftests/sysctl/sysctl.sh to try to load
>     test module if it is not loaded (nor embedded).
>   - Fix tools/testing/selftests/sysctl/config to require
>     CONFIG_TEST_SYSCTL=m, not y.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (4):
>        lib: Make prime number generator independently selectable
>        lib: Make test_sysctl initialized as module
>        selftests/sysctl: Fix to load test_sysctl module
>        selftests/sysctl: Make sysctl test driver as a module
> 
> 
>   lib/math/Kconfig                         |    7 ++++++-
>   lib/test_sysctl.c                        |    2 +-
>   tools/testing/selftests/sysctl/config    |    2 +-
>   tools/testing/selftests/sysctl/sysctl.sh |   13 ++-----------
>   4 files changed, 10 insertions(+), 14 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 

Thanks Masami. I see Kees reviewing patches. I will wait for Luis to
weigh in on patch 2 before pulling this series in.

thanks,
-- Shuah
