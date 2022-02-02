Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D54A74F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 16:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbiBBPwu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 10:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbiBBPwu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 10:52:50 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314C9C061714
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 07:52:50 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z18so8608367ilp.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 07:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hnuCjOcrcVbTrSMGDeFitTnyY+vwDbK2/TPhiEo9TIY=;
        b=bGrhcn/ZvfDpHWNEWDSBjLp+4cy2d/yHhtihOOYV3lMkyzPmQxHG84pnZf01rhqafB
         WbEdrn1JDmAZhI0+ucBk7sTbZ5hhY6+d3AA1OZBz2+JRSROtN3nUtnC7vZbh28Rhod8Q
         iKMvXn7CqgBHMWzG6+vZ0i+h+urQ2ZH1maBHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hnuCjOcrcVbTrSMGDeFitTnyY+vwDbK2/TPhiEo9TIY=;
        b=oAFIY1Q0flPVJrO8XrUajO80WP0eS6tziX/n/FW/GQNRmsSUYCd1fDfnpSxsIPCDsZ
         F2hlsPRXEqY3G6ttBl29K+yxokwhbutlLZ1HKF4wC9qgRqz1k58npOnRWuJePO3+ONqn
         MbesN7jhXD0qk41C2+JrnJ2f4xd9ypGt4GXprQGwjSxxteDMSswBtFM+I0ZKWS00KCbF
         JBSrNAdCplRt/zZ82iXP7FWC6k2qgFP58flA75ochH5EBKy1BsCKyOApU9CpYrGZtktU
         OH1AhtePiryQ+IQB/0F35VptGYee36pGIFQkzLqqUV+N8ku4tWpkl1iGDk3Dz60YNB2s
         +IcQ==
X-Gm-Message-State: AOAM5322sJ5YCwYGKQm+6g051fNPnOn/qQKnzxQyLksCLhthlKGqcb6Z
        i++ytPP2kStuEyoKU02D1fUr/IPMV7X2iQ==
X-Google-Smtp-Source: ABdhPJyF+eRCT1nRVCPDFDYtMeqLp9IKbZfVRn14uMg4P8XLDHSDNIADZx4gognWvY9yFB+l1cKjHw==
X-Received: by 2002:a92:1901:: with SMTP id 1mr16973107ilz.70.1643817169453;
        Wed, 02 Feb 2022 07:52:49 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e11sm17164586ioq.41.2022.02.02.07.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 07:52:49 -0800 (PST)
Subject: Re: [PATCH] pidfd: fix test failure due to stack overflow on some
 arches
To:     Christian Brauner <brauner@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220127212951.3604667-1-axelrasmussen@google.com>
 <20220128085616.tnsowlg5iff6ofm4@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <924d8fd8-7069-41d2-9887-f36160d9f598@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 08:52:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220128085616.tnsowlg5iff6ofm4@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/22 1:56 AM, Christian Brauner wrote:
> On Thu, Jan 27, 2022 at 01:29:51PM -0800, Axel Rasmussen wrote:
>> When running the pidfd_fdinfo_test on arm64, it fails for me. After some
>> digging, the reason is that the child exits due to SIGBUS, because it
>> overflows the 1024 byte stack we've reserved for it.
>>
>> To fix the issue, increase the stack size to 8192 bytes (this number is
>> somewhat arbitrary, and was arrived at through experimentation -- I kept
>> doubling until the failure no longer occurred).
>>
>> Also, let's make the issue easier to debug. wait_for_pid() returns an
>> ambiguous value: it may return -1 in all of these cases:
>>
>> 1. waitpid() itself returned -1
>> 2. waitpid() returned success, but we found !WIFEXITED(status).
>> 3. The child process exited, but it did so with a -1 exit code.
>>
>> There's no way for the caller to tell the difference. So, at least log
>> which occurred, so the test runner can debug things.
>>
>> While debugging this, I found that we had !WIFEXITED(), because the
>> child exited due to a signal. This seems like a reasonably common case,
>> so also print out whether or not we have WIFSIGNALED(), and the
>> associated WTERMSIG() (if any). This lets us see the SIGBUS I'm fixing
>> clearly when it occurs.
>>
>> Finally, I'm suspicious of allocating the child's stack on our stack.
>> man clone(2) suggests that the correct way to do this is with mmap(),
>> and in particular by setting MAP_STACK. So, switch to doing it that way
>> instead.
> 
> Heh, yes. :)
> 
> commit 99c3a000279919cc4875c9dfa9c3ebb41ed8773e
> Author: Michael Kerrisk <mtk.manpages@gmail.com>
> Date:   Thu Nov 14 12:19:21 2019 +0100
> 
>      clone.2: Allocate child's stack using mmap(2) rather than malloc(3)
> 
>      Christian Brauner suggested mmap(MAP_STACKED), rather than
>      malloc(), as the canonical way of allocating a stack for the
>      child of clone(), and Jann Horn noted some reasons why:
> 
>          Not on Linux, but on OpenBSD, they do use MAP_STACK now
>          AFAIK; this was announced here:
>          <http://openbsd-archive.7691.n7.nabble.com/stack-register-checking-td338238.html>.
>          Basically they periodically check whether the userspace
>          stack pointer points into a MAP_STACK region, and if not,
>          they kill the process. So even if it's a no-op on Linux, it
>          might make sense to advise people to use the flag to improve
>          portability? I'm not sure if that's something that belongs
>          in Linux manpages.
> 
>          Another reason against malloc() is that when setting up
>          thread stacks in proper, reliable software, you'll probably
>          want to place a guard page (in other words, a 4K PROT_NONE
>          VMA) at the bottom of the stack to reliably catch stack
>          overflows; and you probably don't want to do that with
>          malloc, in particular with non-page-aligned allocations.
> 
>      And the OpenBSD 6.5 manual pages says:
> 
>          MAP_STACK
>              Indicate that the mapping is used as a stack. This
>              flag must be used in combination with MAP_ANON and
>              MAP_PRIVATE.
> 
>      And I then noticed that MAP_STACK seems already to be on
>      FreeBSD for a long time:
> 
>          MAP_STACK
>              Map the area as a stack.  MAP_ANON is implied.
>              Offset should be 0, fd must be -1, and prot should
>              include at least PROT_READ and PROT_WRITE.  This
>              option creates a memory region that grows to at
>              most len bytes in size, starting from the stack
>              top and growing down.  The stack top is the start‐
>              ing address returned by the call, plus len bytes.
>              The bottom of the stack at maximum growth is the
>              starting address returned by the call.
> 
>              The entire area is reserved from the point of view
>              of other mmap() calls, even if not faulted in yet.
> 
>      Reported-by: Jann Horn <jannh@google.com>
>      Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
>      Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
> 
> 
>>
>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>> ---
> 
> Yeah, stack handling - especially with legacy clone() - is yucky on the
> best of days. Thank you for the fix.
> 
> Acked-by: Christian Brauner <brauner@kernel.org>
> 

Thank you both. Will apply for 5.17-rc4 or so.

thanks,
-- Shuah
