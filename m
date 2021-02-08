Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86DF3143AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 00:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBHXYe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 18:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhBHXYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 18:24:32 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC956C06178C
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 15:23:51 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 18so6381535oiz.7
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 15:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=02Fg2L/cP5O7yEA4aDL/0wbnSxjB/HCeUwPhCj0v2gs=;
        b=fsN5YCV/mulJoJ47yEU+cNQ+BMgru+mQR+5hsX98yZsDYTQ2eoyPicl2LApff+GBWH
         Oill4Ay5CEe0yvmu+p55TC0osIvP+XveznYfzjSff6j7ZmulDiZP70DRfkibSFb44ihB
         /vScocqKsR96xgZKUDi93txyQXg+NpyOn9aVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=02Fg2L/cP5O7yEA4aDL/0wbnSxjB/HCeUwPhCj0v2gs=;
        b=qoJfROFjNOC5yenHTmHJCuNGO3sFoXD1krNMzMw06UgMCrtZhaAx99yv9UR0ihz7kL
         UUQcgKjh0tl/MA9IPwc6zvaAGz0l0AxG3k/Wg9N1w1YZooyTTDFZm8PDq/Mc5XLVTDF2
         9iFFeCMALXHC3Fr2rh+Ao8rvEJeea2Wl+nsZ0T5iOjKKAVZzfOOMFS/rEeX5g0TcgRN7
         A0Tb6LHbCgPq7ay2MmRWkJkcZmCW+AVx0iYNTnqou4OxiY6O1hbsArt5h4aZYG3SoM0v
         tJ6KoR1uo7OQKR647C4zenuJyv407PR4cPV6V2PRJ2VAohIW6HvV6HvE4b7vxFDMKAod
         lUGw==
X-Gm-Message-State: AOAM530fnT1p0hR/9rBu2kGT9uJoHtuNWqcoh3UNEBWuEAryA9HLCiZ/
        NqHVRr1fG2KCkPQ2FgDDr5Lbhw==
X-Google-Smtp-Source: ABdhPJzW4ZKjg72PScgkzDJMPPF7mK3cqkqqKQiSQt7DyqfZNSsHm7bj68ptwMEMriHGlA4GxXV62Q==
X-Received: by 2002:aca:4508:: with SMTP id s8mr758346oia.118.1612826631286;
        Mon, 08 Feb 2021 15:23:51 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x13sm400036otg.79.2021.02.08.15.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 15:23:50 -0800 (PST)
Subject: Re: [PATCH 1/5] kselftests: dmabuf-heaps: Fix Makefile's inclusion of
 the kernel's usr/include dir
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Laura Abbott <labbott@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210129030514.1231773-1-john.stultz@linaro.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <27bd6340-617a-37a2-d17f-8e50b5d5362f@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 16:23:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129030514.1231773-1-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/21 8:05 PM, John Stultz wrote:
> Copied in from somewhere else, the makefile was including
> the kerne's usr/include dir, which caused the asm/ioctl.h file
> to be used.
> 
> Unfortunately, that file has different values for _IOC_SIZEBITS
> and _IOC_WRITE than include/uapi/asm-generic/ioctl.h which then
> causes the _IOCW macros to give the wrong ioctl numbers,
> specifically for DMA_BUF_IOCTL_SYNC.
> 
> This patch simply removes the extra include from the Makefile
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Brian Starkey <brian.starkey@arm.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Laura Abbott <labbott@kernel.org>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Daniel Mentz <danielmentz@google.com>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kselftest@vger.kernel.org
> Fixes: a8779927fd86c ("kselftests: Add dma-heap test")
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>   tools/testing/selftests/dmabuf-heaps/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
> index 607c2acd2082..604b43ece15f 100644
> --- a/tools/testing/selftests/dmabuf-heaps/Makefile
> +++ b/tools/testing/selftests/dmabuf-heaps/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include
> +CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
>   
>   TEST_GEN_PROGS = dmabuf-heap
>   
> 

Thanks John for all these 5 fix and cleanup patches.

Applied to linux-kselftest next for 5.12-rc1

thanks,
-- Shuah
